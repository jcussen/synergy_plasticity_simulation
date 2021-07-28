!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!        PARAMETERS AND SUBROUTINE FOR THREE CASES IN SIMS                   !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!         INHIBITORY FIRING-RATE FOR EACH CASE AND CALL OF MAIN SIMS         !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE conditions(k)
	USE VARIABLES
	USE PARAMETERS
	USE TEMP
	IMPLICIT NONE
	INTEGER					:: i,n,k
	INTEGER, DIMENSION(:), ALLOCATABLE	:: seed
!============================ main simulation - control ===================================!
	IF(k.EQ.1) THEN
	!------------------------ FIRING RATE OF INHIBITORY POPULATIONS ---------------------------!
		pr(205) = 1.0d0		!population 1 -> as a function of control firing-rate
		pr(206) = 1.0d0		!population 2 -> as a function of control firing-rate
	!------------------------------------------------------------------------------------------!
	END IF
!==========================================================================================!
!============================ main simulation - 2nd case ==================================!
	IF(k.EQ.2) THEN
	!------------------------ FIRING RATE OF INHIBITORY POPULATIONS ---------------------------!
		IF(sims_type.EQ.1) THEN
			pr(205) = 1.0d0		!population 1 -> as a function of control firing-rate
			pr(206) = 0.8d0		!population 2 -> as a function of control firing-rate
		END IF
		IF(sims_type.EQ.2) THEN
			pr(205) = 0.0d0		!population 1 -> as a function of control firing-rate
			pr(206) = 2.8d0		!population 2 -> as a function of control firing-rate
		END IF
		IF(sims_type.EQ.3) THEN
			pr(205) = 0.0d0		!population 1 -> as a function of control firing-rate
			pr(206) = 4.1d0		!population 2 -> as a function of control firing-rate
		END IF
	!------------------------------------------------------------------------------------------!
	END IF
!==========================================================================================!
!============================ main simulation - 3rd case ==================================!
	IF(k.EQ.3) THEN
	!------------------------ FIRING RATE OF INHIBITORY POPULATIONS ---------------------------!
		IF(sims_type.EQ.1) THEN
			pr(205) = 1.0d0		!population 1 -> as a function of control firing-rate
			pr(206) = 1.2d0		!population 2 -> as a function of control firing-rate
		END IF
		IF(sims_type.EQ.2) THEN
			pr(205) = 6.9d0		!population 1 -> as a function of control firing-rate
			pr(206) = 0.0d0		!population 2 -> as a function of control firing-rate
		END IF
		IF(sims_type.EQ.3) THEN
			pr(205) = 2.3d0		!population 1 -> as a function of control firing-rate
			pr(206) = 0.0d0		!population 2 -> as a function of control firing-rate
		END IF
	!------------------------------------------------------------------------------------------!
	END IF
!==========================================================================================!
!================================ MAIN SIMULATION =========================================!
!--------------------- SEED INITIALISATION TO BE THE SAME ---------------------------------!
	CALL RANDOM_SEED(size = n)
	ALLOCATE(seed(n))
	seed = seed0 + 37 * (/ (i - 1, i = 1, n) /)
	CALL RANDOM_SEED(PUT = seed)
	DEALLOCATE(seed)
!------------------------------------------------------------------------------------------!
!--------- simulation without plasticity for membrane potential dynamics ------------------!
	CALL initial_conditions2()	!implement initial conditions
	CALL simulation0(1.0d0)		!argument is simulated time in seconds
	CALL simulation(2.0d0)		!argument is simulated time in seconds
!------------------------------------------------------------------------------------------!
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
