!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                  FILE WITH INITAL CONDITIONS FOR SIMULATION                !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE initial_conditions()
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	IMPLICIT NONE
	INTEGER			::	i,pw,j0,jf,n
	REAL*8			::	r,w_init,w_init0
	INTEGER, DIMENSION(:), ALLOCATABLE :: seed
!===================== SEED INITIALISATION TO BE THE SAME =================================!
	CALL RANDOM_SEED(size = n)
	ALLOCATE(seed(n))
	seed = 399393317 + 37 * (/ (i - 1, i = 1, n) /)
	CALL RANDOM_SEED(PUT = seed)
	DEALLOCATE(seed)
!==========================================================================================!
!======================== FIRING RATE OF INHIBITORY POPULATIONS ===========================!
	!population 1 -> as a function of control firing-rate
	pr(205) = 1.0d0
	!population 2 -> as a function of control firing-rate
	pr(206) = 1.0d0
!==========================================================================================!
!======================== EXCITATORY RECEPTIVE FIELD WEIGHTS ==============================!
	DO pw = 1,n_pw
		CALL RANDOM_NUMBER(tmp_inp)
		j0 = ((pw-1)*ne_pw)+1
		jf = pw*ne_pw
		w_init0 = (1.0d0/(1.0d0+r_0)) + ((r_0/(1.0d0+r_0))/(1.0d0+0.25d0*(DBLE(pw-pref_pw))**2))
		msynw(j0:jf) = w_init0*pr(91) + 2.0d0*pr(92)*tmp_inp(j0:jf) - pr(92)
	END DO
!==========================================================================================!
!======================== INHIBITORY RANDOM INITIAL WEIGHTS ===============================!
	msynw(ne+1:ne+ni1+ni2) = pr(93) + 2.0d0*pr(94)*tmp_inp(ne+1:ne+ni1+ni2) - pr(94)
!==========================================================================================!
!============================= CHECKING FOR NEGATIVE WEIGHTS ==============================!
	WHERE(msynw.LE.0.0d0) msynw = 0.00001d0 
!==========================================================================================!
!========================= VARIABLES INITIALISATION =======================================!
	x = 0.0d0		!all variables to zero
	x(1) = pr(2)		!membrane potential to resting membrane potential
	x(11) = pr(191)		!anti-Hebbian learning rate to initial value
	tr = 0.0d0		!simulation time to zero
	spk_post = .FALSE.	!no spike at t=0
	patt_time = 0.0d0	!input rate envelope to zero
!---------------------- spike times for LIF and plasticity --------------------------------!
	spkt_post = -1000.0d0
	spkt_post1 = -1000.0d0
	spkt_post2 = -1000.0d0
	spkt_pre1 = -1000.0d0
	spkt_pre2 = -1000.0d0
!------------------------------------------------------------------------------------------!
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
