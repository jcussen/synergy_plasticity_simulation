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

	ALLOCATE(post_phas(n_trials*9), post_tonic(n_trials*9),  step(n_trials*9))
	ALLOCATE(ex_spk(n_trials*9), in1_spk(n_trials*9), in2_spk(n_trials*9)) !allocate final results table

	ALLOCATE(counter(3)) !this counts the spikes in each population

	ALLOCATE(phasic(9,n_pw),tonic(9,n_pw),phasic_f(8,n_pw),tonic_f(8,n_pw))

	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
