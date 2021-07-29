!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                           ALLOCATION OF ARRAY SIZES                        !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE allocation()
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	IMPLICIT NONE

	ALLOCATE(msynw(tot_n),patt_time(n_pw),inp_patt(tot_n))
	! ALLOCATE(pulse_sigs(3), weight_times(6))
	ALLOCATE(spkt(tot_n),spk(tot_n),spkr(tot_n))
	ALLOCATE(tmp_inp(tot_n),tmpi1(n_pw),tmpi2(n_pw))
	ALLOCATE(msynw0(tot_n),msynw1(tot_n),msynw2(tot_n),msynw5(tot_n),msynw10(tot_n),msynw20(tot_n))

	ALLOCATE(post_phas(n_rows),post_tonic(n_rows),step(n_rows),weight_tm(n_rows),pathwy(n_rows))
	ALLOCATE(ex_spk(n_rows),in1_spk(n_rows),in2_spk(n_rows),cond(n_rows)) !allocate final results table

	ALLOCATE(counter(3)) !this counts the spikes in each population

	ALLOCATE(phasic(9,n_pw),tonic(9,n_pw),phasic_f(8,n_pw),tonic_f(8,n_pw))

	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
