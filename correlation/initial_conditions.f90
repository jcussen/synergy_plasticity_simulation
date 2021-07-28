!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                  FILE WITH INITAL CONDITIONS FOR SIMULATION                !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE initial_conditions()
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	IMPLICIT NONE
	INTEGER			::	i,j,pw,j0,jf,n
	REAL*8			::	r,w_init,w_init0
!======================== CHOOSING WHICH WEIGHT PROFILE WILL BE USED ======================!
	IF(sims_type.EQ.1) THEN
		OPEN(101,file="Hebbian/weights.dat")
	ELSE
		IF(sims_type.EQ.2) THEN
			OPEN(101,file="Hebbian_scaling/weights.dat")
		ELSE
			IF(sims_type.EQ.3) THEN
				OPEN(101,file="Hebbian_antiHebbian/weights.dat")
			END IF
		END IF
	END IF
!==========================================================================================!
!====================== GETTING WEIGHTS FROM FILE (OTHER SIMS) ============================!
	DO i = 1,ne + ni1 + ni2
		READ(101,*)j,msynw(j)
	END DO
	CLOSE(101)
!==========================================================================================!
!====================== SAME SEED FOR ALL THREE CASES =====================================!
	seed0 = 395401317
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
