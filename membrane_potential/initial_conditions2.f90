!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                  FILE WITH INITAL CONDITIONS FOR SIMULATION                !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE initial_conditions2()
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	IMPLICIT NONE
!========================= VARIABLES INITIALISATION =======================================!
	x = 0.0d0		!all variables to zero
	x(1) = pr(2)		!membrane potential to resting membrane potential
	tr = 0.0d0		!simulation time to zero
	spk_post = .FALSE.	!no spike at t=0
	patt_time = 0.0d0	!input rate envelope to zero
	spkt = -1000.0d0
!------------------------------ spike times for LIF ---------------------------------------!
	spkt_post = -1000.0d0
!------------------------------------------------------------------------------------------!
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
