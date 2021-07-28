!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!        DECLARATION OF SHARED VARIABLES (PARAMETERS, VARIABLES, TEMP)       !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	MODULE PARAMETERS
	IMPLICIT NONE
	INTEGER			:: ne,ni1,ni2,tot_n,total_time,ne_pw,ni_pw1,ni_pw2,n_pw,one_sec,pref_pw
	REAL*8			:: pr(300),dt,dpi,seed0
	CHARACTER*6		:: folder
	END MODULE

	MODULE VARIABLES
	IMPLICIT NONE
	REAL*8,ALLOCATABLE	:: msynw(:),spkt(:)
	LOGICAL,ALLOCATABLE	:: spk(:)
	LOGICAL			:: spk_post
	REAL*8			:: x(30),tr,spkt_post
	REAL*8,ALLOCATABLE	:: patt_time(:),inp_patt(:),spkr(:)
	REAL*8,ALLOCATABLE	:: curr_e(:),curr_i1(:),curr_i2(:),activity(:)
	REAL*8,ALLOCATABLE	:: cond_e(:),cond_i1(:),cond_i2(:)
	REAL*8			:: curr_leak
	INTEGER			:: sims_type
	END MODULE

	MODULE TEMP
	IMPLICIT NONE
	REAL*8,ALLOCATABLE	:: tmp_inp(:),tmpi1(:),tmpi2(:)
	END MODULE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
