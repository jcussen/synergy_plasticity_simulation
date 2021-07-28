!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                           ALLOCATION OF ARRAY SIZES                        !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE allocation()
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	IMPLICIT NONE

	ALLOCATE(msynw(tot_n),patt_time(n_pw),inp_patt(tot_n))
	ALLOCATE(spkt(tot_n),spk(tot_n),spkr(tot_n))
	ALLOCATE(tmp_inp(tot_n),tmpi1(n_pw),tmpi2(n_pw))

	ALLOCATE(activity(n_pw))
	ALLOCATE(curr_e(n_pw),curr_i1(n_pw),curr_i2(n_pw))
	ALLOCATE(cond_e(n_pw),cond_i1(n_pw),cond_i2(n_pw))

	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
