!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!        DECLARATION OF SHARED VARIABLES (PARAMETERS, VARIABLES, TEMP)       !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	MODULE PARAMETERS
	IMPLICIT NONE
	INTEGER			:: ne,ni1,ni2,tot_n,total_time,ne_pw,ni_pw1,ni_pw2,n_pw,one_sec,pref_pw
	INTEGER			:: n_trials, n_rows, row_count
	REAL*8			:: pr(300),dt,dpi,seed0,max_step
	CHARACTER*6		:: folder
	END MODULE

	MODULE VARIABLES
	IMPLICIT NONE
	REAL*8,ALLOCATABLE	:: msynw(:),spkt(:),inp_hz(:) !inp_hz is the step rate
	LOGICAL,ALLOCATABLE	:: spk(:)
	LOGICAL			:: spk_post
	REAL*8			:: x(30),tr,spkt_post,inp_fr
	REAL*8,ALLOCATABLE	:: patt_time(:),inp_patt(:),spkr(:), step(:), ex_spk(:), in1_spk(:), in2_spk(:)
	REAL*8,ALLOCATABLE	:: msynw0(:),msynw1(:),msynw2(:),msynw5(:),msynw10(:),msynw20(:)
	INTEGER			:: sims_type
	INTEGER,ALLOCATABLE  		:: pulse_sigs(:), weight_times(:),cond(:), weight_tm(:)
	REAL,ALLOCATABLE	:: phasic(:,:),tonic(:,:),phasic_f(:,:),tonic_f(:,:)
	INTEGER,ALLOCATABLE	:: post_phas(:), post_tonic(:), counter(:), pathwy(:)
	END MODULE

	MODULE TEMP
	IMPLICIT NONE
	REAL*8,ALLOCATABLE	:: tmp_inp(:),tmpi1(:),tmpi2(:)
	END MODULE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
