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
	IF(sims_type.EQ.1) THEN
		OPEN(35,file="output/Hebbian/Hebb_all.dat", status = 'new')
	ELSE
		IF(sims_type.EQ.2) THEN
			OPEN(35,file="output/Hebbian_scaling/scal_all.dat", status = 'new')
		ELSE
			IF(sims_type.EQ.3) THEN
				OPEN(35,file="output/Hebbian_antiHebbian/antiHebb_all.dat", status = 'new')
			END IF
		END IF
	END IF

	IF(sims_type.EQ.1) THEN
		CALL conditions(1)
	ELSE
		DO k = 1,3 ! change this back by uncommenting!
			CALL conditions(k)	!1=control case; 2=pop 1 OFF; 3=pop 2 OFF
		END DO ! uncomment this line too!
	END IF
	CLOSE(35) ! close the output file

	! CALL SYSTEM('mkdir -p output') ! create output folder
!======================== end sim timer and print total time ================================!
    CALL cpu_time(finish)
    PRINT *, 'Total time = ', finish-start, 'seconds'

	! OPEN(30, file =  'output/post_phas.dat', status = 'new')  !write output table
    ! 	WRITE(30, *) post_phas
	! CLOSE(30) 	

	! ! OPEN(31, file =  'output/post_tonic.dat', status = 'new')  !write output table
    ! ! 	WRITE(31, *) post_tonic
	! ! CLOSE(31) 	

	! OPEN(32, file =  'output/ex_spikes.dat', status = 'new')  !write output table
    ! 	WRITE(32, *) ex_spk
	! CLOSE(32) 	

	! OPEN(33, file =  'output/in1_spikes.dat', status = 'new')  !write output table
    ! 	WRITE(33, *) in1_spk
	! CLOSE(33) 	

	! OPEN(34, file =  'output/in2_spikes.dat', status = 'new')  !write output table
    ! 	WRITE(34, *) in2_spk
	! CLOSE(34) 	
	! OPEN(35, file =  'output/all.dat', status = 'new')  !write output table
	! 	DO n=1,n_rows
	! 		WRITE(35, *) cond(n),weight_tm(n),pathwy,step(n),ex_spk(n),in1_spk(n),in2_spk(n),post_phas(n)
	! 	END DO
	! CLOSE(35) 
	! PRINT *, cond
	

!==========================================================================================!
	END PROGRAM
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

