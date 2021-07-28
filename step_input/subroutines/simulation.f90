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
	SUBROUTINE simulation0(tot_time_r)	!tot_time_r = time in milliseconds
	USE VARIABLES
	USE PARAMETERS
	IMPLICIT NONE
	INTEGER 		::	t,tt,tot_time,pw
	REAL*8			::	tot_time_r
	tot_time = INT(tot_time_r/dt)		!total simulation time
!================================ main loop ===============================================!
	DO tt = 1,tot_time
		tr = tr + dt		!from interation to neuronal time
		CALL input_s(0)		!homogeneous input onto postsynaptic neuron
		CALL lif()		!leaky integrate-and-fire neuron
	END DO
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!            SIMULATION WITHOUT PLASTICITY FOR MEM POTENTIAL PLOTS           !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE simulation(tot_time_r,pw)	!tot_time_r = time in milliseconds
	USE VARIABLES
	USE PARAMETERS
	IMPLICIT NONE
	INTEGER 		::	t,tt,tot_time,pw
	REAL*8			::	tot_time_r
	tot_time = INT(tot_time_r/dt)		!total simulation time
!================================ main loop ===============================================!
	DO tt = 1,tot_time
		tr = tr + dt		!from interation to neuronal time
		CALL input_s(pw)	!inhomogeneous input onto postsynaptic neuron
		CALL lif()		!leaky integrate-and-fire neuron
	END DO
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
