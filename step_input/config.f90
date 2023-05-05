!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!        FILE WITH PARAMETERS FOR SIMULATION                                 !!!!!!!!
!!!!!!!!        ALL PARAMETERS EXPLAINED BELOW                                      !!!!!!!!
!!!!!!!!        VARIABLES EXPLAINED AT TABLE AT THE END                             !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE config()
	USE PARAMETERS
	USE VARIABLES
	IMPLICIT NONE
	REAL*8 :: tmp
!====================== FOLDER NAME - 6 CHARACTERS ========================================!
	! folder = "data11"
!==========================================================================================!
!======================== PRE-SYNAPTIC NEURONS (PATHWAYS)==================================!
	!number of pathways
	n_pw = 16
	!number of excitatory neurons per pathway
	ne_pw = 200
	!number of inhibitory neurons type 1 per pathway
	ni_pw1 = 25
	!number of inhibitory neurons type 2 per pathway
	ni_pw2 = 25
	!total number of pre-synaptic neurons
	ne = n_pw*ne_pw
	ni1 = n_pw*ni_pw1
	ni2 = n_pw*ni_pw2
	tot_n = ne+ni1+ni2
	!preferred input signal number
	pref_pw = 9
	pathways=(/1, 9/) ! changed this to include pathway 5 too!
	learning_times=(/0, 1, 2, 5, 10, 20/) !times that weights were sampled during learning
	row_count=1

!==========================================================================================!
!============================== SIMULATION PARAMETERS =====================================!
	!integration time step (ms)
	dt = 0.1d0
	!pi
	dpi = 2.0d0*(4.0d0*ATAN(1.0d0))
	!one second in iterations
	one_sec = INT(1000.0d0/dt)
!==========================================================================================!
!==================NEURON PARAMETERS==============================!
	!neuron membrane potential time constant, tau (ms)
	pr(1) = 30.0d0
	!resting membrane potential (mV) -> same as reset
	pr(2) = -65.0d0
	!refractory period excitatory (ms)
	pr(3) = 5.0d0
	!spiking threshold (mV)
	pr(4) = -50.0d0
!==========================================================================================!
!========================== SYNAPSE PARAMETERS ============================================!
	!reversal potential - excitatory - AMPA (mV) -> not used
	pr(31) = 0.0d0
	!reversal potential - inhibitory - GABA_A (mV)
	pr(32) = -80.0d0
	!synaptic time constant - AMPA (ms)
	pr(35) = 5.0d0
	pr(35) = EXP(-1.0d0*dt/pr(35))
	!synaptic time constant - GABA_A (ms)
	pr(36) = 10.0d0
	pr(36) = EXP(-1.0d0*dt/pr(36))
!==========================================================================================!
!================================ EXTERNAL INPUT ==========================================!
	!background firing-rate -> excitatory neurons (Hz)
	pr(75) = 2.0d0
	pr(75) = (dt*pr(75))/1000.0d0
	!background firing-rate -> inhibitory neurons (Hz)
	pr(76) = 4.0d0
	pr(76) = (dt*pr(76))/1000.0d0

	!input step (Hz)
	pr(77) = 5.0d0
	!phasic/tonic period (ms)
	pr(78) = 50.0d0
	!number of trials
	n_trials = 10 !changed this from 50,000 to 10 for test
	!number of observations/rows in final output table
	n_rows = n_trials*size(learning_times)*size(pathways)*9*3
	max_step_rate=50.0d0
! !==========================================================================================!
! !======================== FILES WITH DATA FROM SIMULATION =================================!
! 	OPEN(100,file="plots_tmp.txt")
! 	WRITE(100,"(A6)")folder
! 	CLOSE(100)

! 	CALL SYSTEM('mkdir '//folder)
! 	OPEN(1,file=folder//'/data01.dat')
! 	OPEN(2,file=folder//'/data02.dat')
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!        VARIABLES                                                           !!!!!!!!
!!!!!!!!        x(1)  -> membrane potential (mV)                                    !!!!!!!!
!!!!!!!!        x(2)  -> AMPA conductance (g_leak)                                  !!!!!!!!
!!!!!!!!        x(3)  -> GABA_A conductance (g_leak)                                !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!        msynw  -> synaptic weights                                          !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!        patt_time -> OU variable                                            !!!!!!!!
!!!!!!!!        inp_patt -> rate envelope for inh. Poisson process                  !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!        inp_fr -> step rate                                                 !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!        phasic, tonic -> spike count during phasic and tonic periods        !!!!!!!!
!!!!!!!!        phasic_f, tonic_f -> rate during phasic and tonic periods           !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
