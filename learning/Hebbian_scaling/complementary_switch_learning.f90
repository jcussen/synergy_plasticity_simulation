!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!                  MAIN FILE WITH SIMULATION CODE                            !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!============================ files with subroutines ======================================!
	INCLUDE 'subroutines/modules.f90'		!modules
	INCLUDE 'subroutines/allocation.f90'		!allocation of vector sizes

	INCLUDE 'config.f90'				!configuration - parameters
	INCLUDE 'initial_conditions.f90'		!values for initial conditions

	INCLUDE 'subroutines/simulation.f90'
	INCLUDE 'subroutines/LIF.f90'			!leaky integrate-and-fire implementation
	INCLUDE 'subroutines/plasticity.f90'		!plasticity implementation
	INCLUDE 'subroutines/input_gaussian.f90'	!inputs from OU
!==========================================================================================!
	PROGRAM COMPLEMENTARY_ISTDP
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	IMPLICIT NONE
	INTEGER			::	i,pw
!======================== initialising subroutines ========================================!
	CALL config()					!call config file with parameters
	CALL allocation()				!allocate vectors and matrices based on parameters
	CALL initial_conditions()			!implement initial conditions
!==========================================================================================!
!===================== initial weights for plots "before/after ============================!
	msynw0 = msynw
!==========================================================================================!
!================================== main simulation =======================================!
!--------- simulation without plasticity for variables to reach steady state --------------!
	CALL simulation0(0.5d0)		!argument is simulated time in minutes
!------------------------------------------------------------------------------------------!
!-------------------- simulation plasticity at inhibitory synapses ------------------------!
	CALL simulation(19.5d0)		!argument is simulated time in minutes
!------------------------------------------------------------------------------------------!
!==========================================================================================!
!=============================== output for plots =========================================!
!-------- weights before (msynw0), during (msynw1-10), and after (msynw) learning ---------!
	DO i = 1,ne+ni1+ni2
		WRITE(1,*)i,msynw0(i),msynw1(i),msynw2(i),msynw5(i),msynw10(i),msynw(i)
	END DO
!------------------------------------------------------------------------------------------!
!----------------- mean weights per input signal before and after learning ----------------!
	DO pw = 1,n_pw
		WRITE(2,"(I2.2,5F20.5)")pw, &
			SUM(msynw(((pw-1)*ne_pw)+1:pw*ne_pw))/DBLE(ne_pw), &
			SUM(msynw0(((pw-1)*ni_pw1)+ne+1:pw*ni_pw1+ne))/DBLE(ni_pw1), &
			SUM(msynw0(((pw-1)*ni_pw2)+ne+ni1+1:pw*ni_pw2+ne+ni1))/DBLE(ni_pw2), &
			SUM(msynw(((pw-1)*ni_pw1)+ne+1:pw*ni_pw1+ne))/DBLE(ni_pw1), &
			SUM(msynw(((pw-1)*ni_pw2)+ne+ni1+1:pw*ni_pw2+ne+ni1))/DBLE(ni_pw2)
	END DO
!------------------------------------------------------------------------------------------!
!==========================================================================================!
	END PROGRAM
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
