!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!                  MAIN FILE WITH SIMULATION CODE                            !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!============================ files with subroutines ======================================!
	INCLUDE 'subroutines/modules.f90'		!modules
	INCLUDE 'subroutines/allocation.f90'		!allocation of vector sizes

	INCLUDE 'config.f90'				!configuration - parameters
	INCLUDE 'initial_conditions.f90'		!values for initial conditions
	INCLUDE 'initial_conditions2.f90'		!values for initial conditions

	INCLUDE 'subroutines/conditions.f90'		!sequence of three cases
	INCLUDE 'subroutines/simulation.f90'		!main simulation
	INCLUDE 'subroutines/LIF.f90'			!leaky integrate-and-fire implementation
	INCLUDE 'subroutines/input_gaussian.f90'	!inputs from OU
!==========================================================================================!
	PROGRAM COMPLEMENTARY_ISTDP
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	IMPLICIT NONE
	INTEGER					:: k
	CHARACTER(len=1)			:: arg
!======================== getting value from user for sims ================================!
	CALL get_command_argument(1, arg)
	READ(arg,'(I1)')sims_type
!======================== initialising subroutines ========================================!
	CALL config()					!call config file with parameters
	CALL allocation()				!allocate vectors and matrices based on parameters
	CALL initial_conditions()			!implement initial conditions
!==========================================================================================!
!========================== three conditions for sims =====================================!
	DO k = 1,3
		CALL conditions(k)	!1=control case; 2=pop 1 OFF; 3=pop 2 OFF
	END DO
!==========================================================================================!
	END PROGRAM
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
