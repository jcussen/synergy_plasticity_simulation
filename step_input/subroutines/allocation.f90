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
	ALLOCATE(msynw0(tot_n),msynw1(tot_n),msynw2(tot_n),msynw5(tot_n),msynw10(tot_n),msynw20(tot_n))

	ALLOCATE(counter(6), counter_phasic(6)) !this counts the spikes in each population
	ALLOCATE(rand_mult(n_trials)) !allocate final results table

	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
