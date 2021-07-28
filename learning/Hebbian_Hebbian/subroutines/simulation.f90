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
	SUBROUTINE simulation0(tot_time_r)	!tot_time_r = time in minutes
	USE VARIABLES
	USE PARAMETERS
	IMPLICIT NONE
	INTEGER 		::	t,tt,tot_time
	REAL*8			::	tot_time_r
	tot_time = INT(tot_time_r*60.0d0)	!total simulation time
!================================ main loop ===============================================!
	DO tt = 1,tot_time
	!---------------------------loop over one second of neuronal time--------------------------!
		DO t = 1,one_sec
			tr = tr + dt		!from interation to neuronal time
			CALL input_g(t)		!inhomogeneous input onto postsynaptic neuron
			CALL lif()		!leaky integrate-and-fire neuron
		END DO
	!------------------------------------------------------------------------------------------!
		CALL output()			!output data for plots
	END DO
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!            SIMULATION WITH PLASTICITY AT INHIBITORY SYNAPSES               !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE simulation(tot_time_r)	!tot_time_r = time in minutes
	USE VARIABLES
	USE PARAMETERS
	IMPLICIT NONE
	INTEGER 		::	t,tt,tot_time
	REAL*8			::	tot_time_r
	tot_time = INT(tot_time_r*60.0d0)	!total simulation time
!================================ main loop ===============================================!
	DO tt = 1,tot_time
	!---------------------------loop over one second of neuronal time--------------------------!
		DO t = 1,one_sec
			tr = tr + dt		!from interation to neuronal time
			CALL input_g(t)		!inhomogeneous input onto postsynaptic neuron
			CALL lif()		!leaky integrate-and-fire neuron
			CALL plasticity_i()	!plasticity of inhibitory synapses
		END DO
	!---------------------------save the weight values--------------------------!
		IF(tt.EQ.30) THEN !this is total time 2.5 mins since 30 secs is initialisation at start
			msynw1=msynw
		END IF 
		IF(tt.EQ.120) THEN !this is total time 2.5 mins since 30 secs is initialisation at start
			msynw2=msynw
		END IF 
		IF(tt.EQ.270) THEN !total time= 5 mins
			msynw5=msynw
		END IF 
		IF(tt.EQ.570) THEN !total time= 10 mins
			msynw10=msynw
		END IF 
	!------------------------------------------------------------------------------------------!
		CALL output()			!output data for plots
	END DO
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                        DATA OUTPUT FOR PLOTS                               !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE output()
	USE VARIABLES
	USE PARAMETERS
	USE TEMP
	IMPLICIT NONE
	INTEGER			::	pw
	CHARACTER(15)		::	fm
!==================== calculation of mean weights per input signal ========================!
	DO pw = 1,n_pw
		tmpi1(pw) = SUM(msynw(((pw-1)*ni_pw1)+ne+1:pw*ni_pw1+ne))		!population 1
		tmpi2(pw) = SUM(msynw(((pw-1)*ni_pw2)+ne+ni1+1:pw*ni_pw2+ne+ni1))	!population 2
	END DO
!==========================================================================================!
	WRITE(fm,"(A7,I2.2,A6)")"(E20.5,",2*n_pw,"E20.5)"	!output format
	WRITE(3,fm)tr,tmpi1/DBLE(ni_pw1),tmpi2/DBLE(ni_pw2)	!time in ms, average weight for 16 signals (pop 1), average weight for 16 signals (pop 2)

	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
