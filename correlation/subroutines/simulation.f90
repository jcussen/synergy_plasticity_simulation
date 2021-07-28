!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!        MAIN SIMULATION -> CALLS ROUTINES FOR INPUT, NEURON AND DATA OUTPUT !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!            SIMULATION WITHOUT PLASTICITY FOR CORRELATION MEASURE           !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE simulation(tot_time_r, k)	!tot_time_r = time in minutes
	USE VARIABLES
	USE PARAMETERS
	IMPLICIT NONE
	INTEGER 		::	t,tt,tot_time,k
	REAL*8			::	tot_time_r
	tot_time = INT(tot_time_r*60.0d0)	!total simulation time - this is multiplied by 60 since there are 60 secs in a minute
!================================ main loop ===============================================!
	DO tt = 1,tot_time
	!---------------------------loop over one second of neuronal time--------------------------!
		DO t = 1,one_sec
			tr = tr + dt		!from interation to neuronal time
			CALL input_g(t)		!inhomogeneous input onto postsynaptic neuron
			CALL lif()		!leaky integrate-and-fire neuron
			CALL averages()		!calculate averate for input and ouput rate
			IF (MOD(count_pre, steps_smpl).EQ.(0)) THEN !if sample rate 
				CALL write_to_vectors() !output the activity to vectors
			END IF
			count_pre=count_pre+1 !increment the count variable
		END DO
		CALL averages2()		!calculate averate for input and ouput rate
	!------------------------------------------------------------------------------------------!
	END DO
	CALL outputs(tot_time, k)			!file output for correlation
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                         OUTPUT ACTIVITY TO VECTORS                         !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE write_to_vectors()
	USE VARIABLES
	USE PARAMETERS
	IMPLICIT NONE
	INTEGER 		::	pw
!-------------------------------- loop over pathways -------------------------------------!
	DO pw = 1,n_pw
		activity_ex_full(count_pre/steps_smpl, pw)= activity(pw)
		activity_in1_full(count_pre/steps_smpl, pw)= activity_in1(pw)
		activity_in2_full(count_pre/steps_smpl, pw)= activity_in2(pw)
		activity_post_full(count_pre/steps_smpl)= x(5)
	END DO
		
	END SUBROUTINE

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!        CALCULATION OF AVERAGES IN ONE SECOND FOR INPUT AND OUTPUT          !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE averages()
	USE VARIABLES
	IMPLICIT NONE
!-------------------------------- average output rate -------------------------------------!
	x(6) = x(6) + x(5)
!------------------------------------------------------------------------------------------!
!---------------------------- square of average output rate -------------------------------!
	x(7) = x(7) + x(5)*x(5)
!------------------------------------------------------------------------------------------!
!-------------------------------- average input rate --------------------------------------!
	activity_av = activity_av + (activity/200.0d0)

!------------------------------------------------------------------------------------------!
!---------------------------- square of average input rate --------------------------------!
	activity_av2 = activity_av2 + (activity/200.0d0)*(activity/200.0d0)
!------------------------------------------------------------------------------------------!
!------------------------- average of cross term (input*output) ---------------------------!
	cross_activity = cross_activity + (activity/200.0d0)*x(5)
!------------------------------------------------------------------------------------------!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!        CALCULATION OF AVERAGES IN ONE MINUTE FOR INPUT AND OUTPUT          !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE averages2()
	USE VARIABLES
	USE PARAMETERS
	IMPLICIT NONE
!-------------------------------- average output rate -------------------------------------!
	x(8) = x(8) + x(6)/DBLE(one_sec)
!------------------------------------------------------------------------------------------!
!---------------------------- square of average output rate -------------------------------!
	x(9) = x(9) + x(7)/DBLE(one_sec)
!------------------------------------------------------------------------------------------!
!-------------------------------- average input rate --------------------------------------!
	activity_av_t = activity_av_t + activity_av/DBLE(one_sec)

!------------------------------------------------------------------------------------------!
!---------------------------- square of average input rate --------------------------------!
	activity_av_t2 = activity_av_t2 + activity_av2/DBLE(one_sec)
!------------------------------------------------------------------------------------------!
!------------------------- average of cross term (input*output) ---------------------------!
	cross_activity_t = cross_activity_t + cross_activity/DBLE(one_sec)
!------------------------------------------------------------------------------------------!
!---------------------------------- reset variables ---------------------------------------!
	x(6:7) = 0.0d0
	activity_av = 0.0d0
	activity_av2 = 0.0d0
	cross_activity = 0.0d0
!------------------------------------------------------------------------------------------!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                        DATA OUTPUT FOR PLOT                                !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE outputs(tot_time, k)
	USE VARIABLES
	USE PARAMETERS
	IMPLICIT NONE
	INTEGER			::	tot_time,pw,k
	REAL*8,ALLOCATABLE	::	covariance(:),norm(:)
!--------------------- arrays to calculate covariance and normalization (SD) --------------!
	ALLOCATE(covariance(n_pw),norm(n_pw))
!------------------------------------------------------------------------------------------!
!-------------------------------- average output rate -------------------------------------!
	x(8) = x(8)/DBLE(tot_time)
!------------------------------------------------------------------------------------------!
!---------------------------- square of average output rate -------------------------------!
	x(9) = x(9)/DBLE(tot_time)
!------------------------------------------------------------------------------------------!
!-------------------------------- average input rate --------------------------------------!
	activity_av_t = activity_av_t/DBLE(tot_time)
!------------------------------------------------------------------------------------------!
!---------------------------- square of average input rate --------------------------------!
	activity_av_t2 = activity_av_t2/DBLE(tot_time)
!------------------------------------------------------------------------------------------!
!------------------------- average of cross term (input*output) ---------------------------!
	cross_activity_t = cross_activity_t/DBLE(tot_time)
!------------------------------------------------------------------------------------------!
!------------------------------ covariance (input and output) -----------------------------!
	covariance = cross_activity_t - x(8)*activity_av_t
!------------------------------------------------------------------------------------------!
!----------------------- norm term for Pearson correlation SD*SD --------------------------!
	norm = DSQRT( (activity_av_t2 - (activity_av_t**2))*(x(9) - (x(8)**2)) )
!------------------------------------------------------------------------------------------!
!--------------------------------- output to file -----------------------------------------!
	DO pw = 1,n_pw
		WRITE(1,*)pw,covariance(pw)/norm(pw)
	END DO
!------------------------------------------------------------------------------------------!
!---------------------------------- output fodlers ----------------------------------------!

!get subfolder name - MUST BE 6 CHARS LENGTH
	IF (k.EQ.1) THEN
		subfol='contrl'
	END IF
	IF (k.EQ.2) THEN
		subfol='p1_off'
	END IF
	IF (k.EQ.3) THEN
		subfol='p2_off'
	END IF

!get sim folder name - MUST BE 9 CHARS LENGTH
	IF(sims_type.EQ.1) THEN
		simfol='Hebb_Hebb'
	END IF
	IF(sims_type.EQ.2) THEN
		simfol='Hebb_Scal'
	END IF
	IF(sims_type.EQ.3) THEN
		simfol='Hebb_Anti'
	END IF

!------------------------------------------------------------------------------------------!
!--------------------------------- output variables ---------------------------------------!

	CALL SYSTEM('mkdir -p '//output_fold//'/'//simfol//'/'//subfol) ! create output folder

	OPEN(17, file = output_fold//'/'//simfol//'/'//subfol//'/post_spikes.dat', status = 'new')  !write postsynaptic spikes file
    	WRITE(17,*) spkt_post_full   
	CLOSE(17) 

	OPEN(18, file =  output_fold//'/'//simfol//'/'//subfol//'/ex_activity.dat', status = 'new') !write excitatory inputs file
    	WRITE(18,*) activity_ex_full
	CLOSE(18) 

	OPEN(19, file =  output_fold//'/'//simfol//'/'//subfol//'/in1_activity.dat', status = 'new')  !write inhibitory pop 1 inputs file
    	WRITE(19,*) activity_in1_full   
	CLOSE(19) 

	OPEN(20, file =  output_fold//'/'//simfol//'/'//subfol//'/in2_activity.dat', status = 'new')  !write inhibitory pop 2 inputs file
    	WRITE(20,*) activity_in2_full
	CLOSE(20) 

	OPEN(21, file =  output_fold//'/'//simfol//'/'//subfol//'/post_activity.dat', status = 'new')  !write postsynaptic activity file
    	WRITE(21,*) activity_post_full
	CLOSE(21) 

	OPEN(22, file =  output_fold//'/'//simfol//'/'//subfol//'/ex_spikes.dat', status = 'new')  !write presyn ex pop spike trains
    	WRITE(22,*) spkt_ex
	CLOSE(22) 

	OPEN(23, file =  output_fold//'/'//simfol//'/'//subfol//'/in1_spikes.dat', status = 'new')  !write presyn in1 pop spike trains
    	WRITE(23,*) spkt_in1
	CLOSE(23) 

	OPEN(24, file =  output_fold//'/'//simfol//'/'//subfol//'/in2_spikes.dat', status = 'new')  !write presyn in2 pop spike trains
    	WRITE(24,*) spkt_in2
	CLOSE(24) 	
!------------------------------------------------------------------------------------------!
!----------------------------- deallocate arrays for next sim -----------------------------!
	DEALLOCATE(covariance,norm)
!------------------------------------------------------------------------------------------!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
