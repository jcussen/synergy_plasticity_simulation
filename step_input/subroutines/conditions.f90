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
	INTEGER					:: i,pw,n,j,jj,row,w,k,wt,l
	INTEGER, DIMENSION(:), ALLOCATABLE	:: seed
!========= simulation without plasticity for membrane potential dynamics ==================!
!--------------------------- reset variables for different cases --------------------------!
	phasic = 0.0d0						!spike count for phasic period
	tonic = 0.0d0						!spike count for tonic period
	inp_fr = -1.0d0*pr(77)					!initial step firing rate
	post_phas = 0.0d0 					!initialise the results table to empty
	post_tonic = 0.0d0
	counter=0
!------------------------------------------------------------------------------------------!
!------------------------- loop over 9 step rates (from 0 to 40) --------------------------!
	DO w=1,size(weight_times)
		wt=weight_times(w)		!this value is the weight time
		!--------------------- select the weights to be used ---------------------------------!
		IF (wt.EQ.0) THEN 
			msynw=msynw0
		END IF
		IF (wt.EQ.1) THEN 
			msynw=msynw1
		END IF
		IF (wt.EQ.2) THEN 
			msynw=msynw2
		END IF
		IF (wt.EQ.5) THEN 
			msynw=msynw5
		END IF
		IF (wt.EQ.10) THEN 
			msynw=msynw10
		END IF
		IF (wt.EQ.20) THEN 
			msynw=msynw20
		END IF
		! PRINT *, sum(msynw)
		! DO j = 1,9
	!--------------------- SEED INITIALISATION TO BE THE SAME ---------------------------------!
		CALL RANDOM_SEED(size = n)
		ALLOCATE(seed(n))
		seed = seed0 + 37 * (/ (i - 1, i = 1, n) /)
		CALL RANDOM_SEED(PUT = seed)
		DEALLOCATE(seed)

		CALL RANDOM_NUMBER(inp_hz) !allocate random numbers to this vector for step input magnitude
	!------------------------------------------------------------------------------------------!
	!---------------------------- loop over input signal groups ------------------------------------!
		DO l = 1,size(pulse_sigs)
			pw=pulse_sigs(l)				!set the pathway number
		
		!---------------------------- trials for smoother plot -------------------------------------!
			DO jj = 1,n_trials
				! row=((k-1)+(w-1)+(j-1)+(l-1))*n_trials+jj		!set the row number
				inp_fr = inp_hz(jj)*max_step		!step firing rate generated according to random vector
				CALL initial_conditions2()		!implement initial conditions
				CALL simulation0(10.0d0)		!argument is simulated time in milliseconds
				x(5) = 0.0d0				!reset spike count
				counter=0					!reset the presynaptic spike count
				CALL simulation(pr(78),pw)		!argument is simulated time in milliseconds
				phasic(j,pw) = phasic(j,pw) + x(5)	!add spike count of trial to main counter
				cond(row_count)=k
				! PRINT *, row_count, k, wt, pw, inp_fr, int(x(5)), counter(1), counter(2), counter(3)
				WRITE(35,*) row_count, k, wt, pw, inp_fr, int(x(5)), counter(1), counter(2), counter(3), counter(4), counter(5), counter(6)
				! ! pathwy(row_count)= pw		!save the pathway THIS DOUBLE COMMENTED STUFF MIGHT BE USEFUL FOR EFFICIENT FILE WRITING!
				! ! weight_tm(row_count)=wt		!save the weight_time
				! ! step(row_count)=inp_fr	!save the step input
				! ! post_phas(row_count)= int(x(5)) !save phasic spike count
				! ! ex_spk(row_count)=counter(1)	!save excitatory spike count
				! ! in1_spk(row_count)=counter(2)	!save inhib1 spike count
				! ! in2_spk(row_count)=counter(3) 	!save inhib2 spike count					x(5) = 0.0d0				!reset spike count
				! counter=0					!reset the presynaptic spike count
				! CALL simulation(pr(78),pw)		!argument is simulated time in milliseconds
				! tonic(j,pw) = tonic(j,pw) + x(5)	!add spike count of trial to main counter
				! post_tonic((j-1)*n_trials+jj)= int(x(5))	!save tonic count - although this isn't quite right!
				row_count=row_count+1
			END DO
		!------------------------------------------------------------------------------------------!
		END DO
		!------------------------------------------------------------------------------------------!
		! END DO
	END DO
!------------------------------------------------------------------------------------------!
!--------------------------- from spike count to firing-rate (Hz) -------------------------!
	phasic = (1000.0d0/pr(78))*phasic/DBLE(n_trials) !since this is actually an average value!!!
	tonic = (1000.0d0/pr(78))*tonic/DBLE(n_trials)
!------------------------------------------------------------------------------------------!
!----------------------------- discounting spikes without step input ----------------------!
	DO pw = 1,n_pw
		phasic_f(:,pw) = phasic(2:9,pw)-phasic(1,pw) ! this is subtracting the spikes that occur with no step
		WHERE(phasic_f(:,pw).LT.0.0d0) phasic_f(:,pw) = 0.0d0
		tonic_f(:,pw) = tonic(2:9,pw)-tonic(1,pw)
		WHERE(tonic_f(:,pw).LT.0.0d0) tonic_f(:,pw) = 0.0d0
	END DO
!------------------------------------------------------------------------------------------!
!------------------------------------ output for plots ------------------------------------!
	DO pw = 1,n_pw
		WRITE(1,"(I10,8F20.10)")pw,phasic_f(:,pw)
		WRITE(2,"(I10,8F20.10)")pw,tonic_f(:,pw)
	END DO
	 

	! PRINT *, phasic
	! PRINT *, 'breaker!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
	! PRINT *, tonic
!------------------------------------------------------------------------------------------!
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! !!!!!!!!!!!!         OUTPUT AND SAVE THE SPIKE COUNTS AND OBSERVATIONS         !!!!!!!!!!!!!
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! 	SUBROUTINE savedata(pw, row,counter,phas_post, step_input, w,k)
! 	USE VARIABLES
! 	USE PARAMETERS
! 	USE TEMP
! 	IMPLICIT NONE
! 	INTEGER					:: pw,step_input,row,w,k,phas_post
! 	INTEGER, DIMENSION(:), ALLOCATABLE	:: seed
! 	INTEGER, DIMENSION(3)	:: counter


! !------------------------------------------------------------------------------------------!
! !==========================================================================================!
! 	END SUBROUTINE
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
