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
	INCLUDE 'subroutines/input_step.f90'		!inputs from step
!==========================================================================================!
	PROGRAM COMPLEMENTARY_ISTDP
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	IMPLICIT NONE
	INTEGER			::	k, n
	CHARACTER(len=1)	:: arg
	CHARACTER(LEN=100) :: filename
	REAL :: start, finish
!======================== start sim timer ================================!
    CALL cpu_time(start)
!======================== getting value from user for sims ================================!
	CALL get_command_argument(1, arg)
	READ(arg,'(I1)')sims_type
!======================== initialising subroutines ========================================!
	CALL config()					!call config file with parameters
	CALL allocation()				!allocate vectors and matrices based on parameters
	CALL initial_conditions()			!implement initial conditions
!==========================================================================================!
!========================== three conditions for sims =====================================!
	CALL SYSTEM('mkdir -p '//folder) ! create output folder if doesn't exist
	IF(sims_type.EQ.1) THEN
		CALL SYSTEM('mkdir -p '//folder//'/'//'Hebbian') ! create folder if doesn't exist
		WRITE (filename, '(A,A,I0,A,I0,A)') folder, '/Hebbian/', int(seed0), '_', n_trials, '.dat' ! create filename
		OPEN(35, file=filename, status='new') ! open file
	ELSE
		IF(sims_type.EQ.2) THEN
			CALL SYSTEM('mkdir -p '//folder//'/'//'Hebbian_scaling')
			WRITE (filename, '(A,A,I0,A,I0,A)') folder, '/Hebbian_scaling/', int(seed0), '_', n_trials, '.dat'
			OPEN(35, file=filename, status='new')
		ELSE
			IF(sims_type.EQ.3) THEN
				CALL SYSTEM('mkdir -p '//folder//'/'//'Hebbian_antiHebbian')
				WRITE (filename, '(A,A,I0,A,I0,A)') folder, '/Hebbian_antiHebbian/', int(seed0), '_', n_trials, '.dat'
				OPEN(35, file=filename, status='new')
			END IF
		END IF
	END IF

	IF(sims_type.EQ.1) THEN
		CALL conditions(1)
	ELSE
		DO k = 1,3
			CALL conditions(k)	!1=control case; 2=pop 1 OFF; 3=pop 2 OFF
		END DO
	END IF
	CLOSE(35) ! close the output file

!======================== end sim timer and print total time ================================!
    CALL cpu_time(finish)
    PRINT *, 'Total time = ', finish-start, 'seconds'

!==========================================================================================!
	END PROGRAM
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

