!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!        DECLARATION OF SHARED VARIABLES (PARAMETERS, VARIABLES, TEMP)       !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	MODULE PARAMETERS
	IMPLICIT NONE
	INTEGER			:: ne,ni1,ni2,tot_n,total_time,ne_pw,ni_pw1,ni_pw2,n_pw,one_sec,pref_pw
	REAL*8			:: pr(300),dt,dpi,seed0
	CHARACTER*6		:: folder, output_fold, subfol
	CHARACTER*9	:: simfol
	!data output parameters:
	REAL*8 			:: tot_mins, actvity_smpl_rt
	INTEGER			:: steps_smpl
	END MODULE

	MODULE VARIABLES
	IMPLICIT NONE
	REAL*8,ALLOCATABLE	:: msynw(:),spkt(:)
	LOGICAL,ALLOCATABLE	:: spk(:)
	LOGICAL			:: spk_post
	REAL*8			:: x(30),tr,spkt_post
	REAL*8,ALLOCATABLE	:: patt_time(:),inp_patt(:),spkr(:),activity(:)
	INTEGER			:: sims_type
	INTEGER, ALLOCATABLE :: indices(:)
	INTEGER,ALLOCATABLE :: spkt_pre_total(:)
	REAL*8,ALLOCATABLE	:: activity_av(:),activity_av2(:),activity_av_t(:),activity_av_t2(:), spkt_pre_test(:)
	REAL*8,ALLOCATABLE	:: cross_activity(:),cross_activity_t(:)
	!data output variables
	REAL*8,ALLOCATABLE	:: spkt_post_full(:), activity_ex_full(:,:), activity_post_full(:)
	REAL*8,ALLOCATABLE	:: spkt_ex(:,:), spkt_in1(:,:), spkt_in2(:,:)
	REAL*8,ALLOCATABLE	:: activity_in1_full(:,:), activity_in2_full(:,:)
	REAL*8,ALLOCATABLE	:: activity_in1(:), activity_in2(:)
	INTEGER				:: counter, count_pre
	END MODULE

	MODULE TEMP
	IMPLICIT NONE
	REAL*8,ALLOCATABLE	:: tmp_inp(:),tmpi1(:),tmpi2(:)
	END MODULE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
