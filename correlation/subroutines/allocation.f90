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

	! DATA EXPORT ALLOCATIONS
	ALLOCATE(spkt_post_full(int(tot_mins*60*10)), spkt_pre_test(int(tot_mins*60*10))) !target firing rate is 5Hz?
	ALLOCATE(spkt_ex(int(tot_mins*60*14), ne)) !firing rate is roughly 10Hz, so use 12 to be safe
	ALLOCATE(spkt_in1(int(tot_mins*60*25), ni1)) !firing rate potentially a lot higher than ex pop
	ALLOCATE(spkt_in2(int(tot_mins*60*25), ni2)) !firing rate potentially a lot higher than ex pop
	ALLOCATE(spkt_pre_total(ne+ni1+ni2))
	ALLOCATE(activity_ex_full(INT(tot_mins*60.0d0)*steps_smpl, n_pw)) 
	ALLOCATE(activity_post_full(INT(tot_mins*60.0d0)*steps_smpl)) 
	ALLOCATE(activity_in1_full(INT(tot_mins*60.0d0)*steps_smpl, n_pw)) 
	ALLOCATE(activity_in2_full(INT(tot_mins*60.0d0)*steps_smpl, n_pw)) 
	ALLOCATE(activity_in1(n_pw), activity_in2(n_pw))


	ALLOCATE(activity(n_pw))
	ALLOCATE(activity_av(n_pw),activity_av2(n_pw),activity_av_t(n_pw),activity_av_t2(n_pw))
	ALLOCATE(cross_activity(n_pw),cross_activity_t(n_pw))

	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
