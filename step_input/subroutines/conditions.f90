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
	INTEGER		::	k

!============================ main simulation - control ===================================!
	IF(k.EQ.1) THEN ! If both inhibitory populations are on
	!------------------------ FIRING RATE OF INHIBITORY POPULATIONS ---------------------------!
		pr(205) = 1.0d0		!population 1 -> as a function of control firing-rate
		pr(206) = 1.0d0		!population 2 -> as a function of control firing-rate
	!------------------------------------------------------------------------------------------!
	END IF
!==========================================================================================!
!============================ main simulation - 2nd case ==================================!
	IF(k.EQ.2) THEN ! if population 1 is off (if hebbian simulations then it doesn't matter which one?). First Hebbian population is off in all cases
	!------------------------ FIRING RATE OF INHIBITORY POPULATIONS ---------------------------!
		IF(sims_type.EQ.1) THEN ! if hebbian in both populations
			pr(205) = 1.0d0		!population 1 -> as a function of control firing-rate 
			pr(206) = 0.8d0		!population 2 -> as a function of control firing-rate
		END IF
		IF(sims_type.EQ.2) THEN ! if homeostatic scaling condition
			pr(205) = 0.0d0		!population 1 -> as a function of control firing-rate
			pr(206) = 2.8d0		!population 2 -> as a function of control firing-rate
		END IF
		IF(sims_type.EQ.3) THEN ! if anti-Hebbian simulation 
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
!=============================== sequence of trials =======================================!
	CALL step_sims(k)
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!         INHIBITORY FIRING-RATE FOR EACH CASE AND CALL OF MAIN SIMS         !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE step_sims(k)
	USE VARIABLES
	USE PARAMETERS
	USE TEMP
	IMPLICIT NONE
	INTEGER					:: i,pw,n,row,w,k,tm,pw_n,x_phasic
	INTEGER, DIMENSION(:), ALLOCATABLE	:: seed
!========= simulation without plasticity for membrane potential dynamics ==================!
!--------------------------- reset variables for different cases --------------------------!
	phasic = 0.0d0						!spike count for phasic period
	tonic = 0.0d0						!spike count for tonic period
	inp_fr = -1.0d0*pr(77)					!initial step firing rate
	counter=0
!------------------------------------------------------------------------------------------!
!------------------------- loop over weight profiles at each learning time --------------------------!
	DO w=1,size(learning_times)
		tm=learning_times(w)		!this value is the weight time
		!--------------------- select the weights to be used ---------------------------------!
		IF (tm.EQ.0) THEN 
			msynw=msynw0
		END IF
		IF (tm.EQ.1) THEN 
			msynw=msynw1
		END IF
		IF (tm.EQ.2) THEN 
			msynw=msynw2
		END IF
		IF (tm.EQ.5) THEN 
			msynw=msynw5
		END IF
		IF (tm.EQ.10) THEN 
			msynw=msynw10
		END IF
		IF (tm.EQ.20) THEN 
			msynw=msynw20
		END IF
	!--------------------- SEED INITIALISATION TO BE THE SAME ---------------------------------!
		CALL RANDOM_SEED(size = n)
		ALLOCATE(seed(n))
		seed = seed0 + 37 * (/ (i - 1, i = 1, n) /)
		CALL RANDOM_SEED(PUT = seed)
		DEALLOCATE(seed)

		CALL RANDOM_NUMBER(rand_mult) !random number between 0 and 1 to multiply by firing rate
	!------------------------------------------------------------------------------------------!
	!---------------------------- loop over input pathways/signal groups ------------------------------------!
		DO pw_n = 1,size(pathways)
			pw=pathways(pw_n)				!set the pathway number
		
		!---------------------------- loop over number of trials -------------------------------------!
			DO i = 1,n_trials
				inp_fr = rand_mult(i)*max_step_rate		!step firing rate generated according to random vector
				CALL initial_conditions2()		!implement initial conditions
				CALL simulation0(10.0d0)		!argument is simulated time in milliseconds
				x(5) = 0.0d0				!reset postsynaptic spike count
				counter=0					!reset the presynaptic spike counts
				CALL simulation(pr(78),pw)		! phasic simulation
				x_phasic = int(x(5)) ! save phasic postsynaptic spike count
				counter_phasic = counter ! save phasic presynaptic spike counts
				x(5) = 0.0d0				!reset postsynaptic spike count
				counter=0					!reset the presynaptic spike counts
				CALL simulation(pr(78),pw)		! tonic simulation 
				WRITE(35,*) row_count, k, tm, pw, inp_fr, x_phasic, counter_phasic(1), counter_phasic(2), counter_phasic(3), &
				& counter_phasic(4), counter_phasic(5), counter_phasic(6), int(x(5)), counter(1), counter(2), counter(3), &
				& counter(4), counter(5), counter(6)
				row_count=row_count+1
			END DO
		!------------------------------------------------------------------------------------------!
		END DO
		!------------------------------------------------------------------------------------------!
	END DO
!------------------------------------------------------------------------------------------!
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
