!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                           ALLOCATION OF ARRAY SIZES                        !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE allocation()
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	IMPLICIT NONE

	ALLOCATE(msynw(tot_n),msynw0(tot_n),patt_time(n_pw),inp_patt(tot_n))
	ALLOCATE(msynw1(tot_n),msynw2(tot_n),msynw5(tot_n),msynw10(tot_n),msynw20(tot_n))
	ALLOCATE(spkt(tot_n),spk(tot_n),spkr(tot_n))
	ALLOCATE(ypost1(tot_n),ypost2(tot_n),ypre1(tot_n),ypre2(tot_n))
	ALLOCATE(spkt_post1(tot_n),spkt_post2(tot_n),spkt_pre1(tot_n),spkt_pre2(tot_n))
	ALLOCATE(tmp_inp(tot_n),tmpi1(n_pw),tmpi2(n_pw))

	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
