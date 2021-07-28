!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!        MAIN SIMULATION -> CALLS ROUTINES FOR INPUT, NEURON AND DATA OUTPUT !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!            SIMULATION WITHOUT PLASTICITY FOR INITIALISATION                !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE simulation0(tot_time_r)	!tot_time_r = time in seconds
	USE VARIABLES
	USE PARAMETERS
	IMPLICIT NONE
	INTEGER 		::	t,tt,tot_time
	REAL*8			::	tot_time_r
	tot_time = INT(tot_time_r)		!total simulation time
!================================ main loop ===============================================!
	DO tt = 1,tot_time
	!---------------------------loop over one second of neuronal time--------------------------!
		DO t = 1,one_sec
			tr = tr + dt		!from interation to neuronal time
			CALL input_g(t)		!inhomogeneous input onto postsynaptic neuron
			CALL lif()		!leaky integrate-and-fire neuron
		END DO
	!------------------------------------------------------------------------------------------!
	END DO
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!            SIMULATION WITHOUT PLASTICITY FOR MEM POTENTIAL PLOTS           !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE simulation(tot_time_r)	!tot_time_r = time in seconds
	USE VARIABLES
	USE PARAMETERS
	IMPLICIT NONE
	INTEGER 		::	t,tt,tot_time
	REAL*8			::	tot_time_r
	tot_time = INT(tot_time_r)		!total simulation time
!================================ main loop ===============================================!
	DO tt = 1,tot_time
	!---------------------------loop over one second of neuronal time--------------------------!
		DO t = 1,one_sec
			tr = tr + dt		!from interation to neuronal time
			CALL input_g(t)		!inhomogeneous input onto postsynaptic neuron
			CALL lif()		!leaky integrate-and-fire neuron
			CALL currents()		!calculation of excitatory and inhibitory currents
		!----------------------------- output data for plots --------------------------------------!
			IF(spk_post) WRITE(1,*)tr,-25.0d0					!postsynaptic spike
			WRITE(1,*)tr,x(1)							!postsynaptic memb potential
			WRITE(2,"(5F20.5)")tr,SUM(curr_e),SUM(curr_i1),SUM(curr_i2),curr_leak	!currents
			WRITE(3,"(17F20.5)")tr,activity/200.0d0					!input rate
		!------------------------------------------------------------------------------------------!
		END DO
	!------------------------------------------------------------------------------------------!
	END DO
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                        DATA OUTPUT FOR PLOTS                               !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE currents()
	USE VARIABLES
	USE PARAMETERS
	IMPLICIT NONE
	INTEGER		::	pw,j0,jf
	REAL*8		::	tmp
!---------------------------- loop over input signals -------------------------------------!
	DO pw = 1,n_pw
	!------------------------- excitatory neurons ---------------------------------------------!
		j0 = ((pw-1)*ne_pw) + 1				!vector starting point
		jf = pw*ne_pw					!vector ending point
		tmp = SUM(spkr(j0:jf)*msynw(j0:jf))		!excitatory spikes from input signal pw
		cond_e(pw) = cond_e(pw)*pr(35) + tmp		!total excitatory conductance due to signal pw
		curr_e(pw) = cond_e(pw)*x(1)			!total excitatory current due to signal pw
	!------------------------------------------------------------------------------------------!
	!--------------------- inhibitory neurons - pop 1 -----------------------------------------!
		j0 = ((pw-1)*ni_pw1) + ne + 1			!vector starting point
		jf = pw*ni_pw1 + ne				!vector ending point
		tmp = SUM(spkr(j0:jf)*msynw(j0:jf))		!inhibitory spikes from input signal pw pop 1
		cond_i1(pw) = cond_i1(pw)*pr(36) + tmp		!total inhibitory conductance due to signal pw pop 1
		curr_i1(pw) = - cond_i1(pw)*(pr(32)-x(1))	!total inhibitory current due to signal pw pop 1
	!------------------------------------------------------------------------------------------!
	!--------------------- inhibitory neurons - pop 2 -----------------------------------------!
		j0 = ((pw-1)*ni_pw2) + ne + ni1 + 1		!vector starting point
		jf = pw*ni_pw2 + ne + ni1			!vector ending point
		tmp = SUM(spkr(j0:jf)*msynw(j0:jf))		!inhibitory spikes from input signal pw pop 2
		cond_i2(pw) = cond_i2(pw)*pr(36) + tmp		!total inhibitory conductance due to signal pw pop 2
		curr_i2(pw) = - cond_i2(pw)*(pr(32)-x(1))	!total inhibitory current due to signal pw pop 2
	!------------------------------------------------------------------------------------------!
	END DO
!------------------------------------------------------------------------------------------!
	curr_leak = x(1) - pr(2)				!leak current
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
