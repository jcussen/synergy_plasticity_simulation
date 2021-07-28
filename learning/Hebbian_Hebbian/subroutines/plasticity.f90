!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!            IMPLEMENTATION OF HEBBIAN AND ANTI-HEBBIAN PLASTICITY           !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE plasticity_i()
	USE VARIABLES
	USE PARAMETERS
	IMPLICIT NONE
	INTEGER		::	j0,jf
!=========================== Hebbian plasticity - pop 1 ===================================!
	j0 = ne + 1				!vector starting point
	jf = ne + ni1				!vector ending point
!------------------------- finding which input neurons spiked -----------------------------!
	WHERE(spk(j0:jf))
		ypost1(j0:jf) = ypost1(j0:jf)*EXP((spkt_post1(j0:jf)-tr)/pr(173))		!update post trace
		spkt_post1(j0:jf) = tr								!update last time trace is updated
		msynw(j0:jf) = msynw(j0:jf) + pr(171)*(ypost1(j0:jf) - pr(172))			!update weights
	END WHERE
!------------------------------------------------------------------------------------------!
!--------------------------- updates when post neuron spikes ------------------------------!
	IF(spk_post) THEN
		ypre1(j0:jf) = ypre1(j0:jf)*EXP((spkt_pre1(j0:jf)-tr)/pr(173))			!update pre trace
		spkt_pre1(j0:jf) = tr								!update last time trace is updated
		msynw(j0:jf) = msynw(j0:jf) + pr(171)*ypre1(j0:jf)				!update weight
		ypost1(j0:jf) = ypost1(j0:jf)*EXP((spkt_post1(j0:jf)-tr)/pr(173)) + 1.0d0	!update post trace with spike
		spkt_post1(j0:jf) = tr								!update last time trace is updated
	END IF
!------------------------------------------------------------------------------------------!
!----------------------------- finding which input neurons spiked -------------------------!
	WHERE(spk(j0:jf))
		ypre1(j0:jf) = ypre1(j0:jf)*EXP((spkt_pre1(j0:jf)-tr)/pr(173)) + 1.0d0		!update pre trace with spike
		spkt_pre1(j0:jf) = tr								!update time of last spike for trace
	END WHERE
!------------------------------------------------------------------------------------------!
!=========================== Hebbian plasticity - pop 2 ===================================!
	j0 = ne + ni1 + 1			!vector starting point
	jf = ne + ni1 + ni2			!vector ending point
!------------------------- finding which input neurons spiked -----------------------------!
	WHERE(spk(j0:jf))
		ypost1(j0:jf) = ypost1(j0:jf)*EXP((spkt_post1(j0:jf)-tr)/pr(173))		!update post trace
		spkt_post1(j0:jf) = tr								!update last time trace is updated
		msynw(j0:jf) = msynw(j0:jf) + pr(171)*(ypost1(j0:jf) - pr(172))			!update weights
	END WHERE
!------------------------------------------------------------------------------------------!
!--------------------------- updates when post neuron spikes ------------------------------!
	IF(spk_post) THEN
		ypre1(j0:jf) = ypre1(j0:jf)*EXP((spkt_pre1(j0:jf)-tr)/pr(173))			!update pre trace
		spkt_pre1(j0:jf) = tr								!update last time trace is updated
		msynw(j0:jf) = msynw(j0:jf) + pr(171)*ypre1(j0:jf)				!update weight
		ypost1(j0:jf) = ypost1(j0:jf)*EXP((spkt_post1(j0:jf)-tr)/pr(173)) + 1.0d0	!update post trace with spike
		spkt_post1(j0:jf) = tr								!update last time trace is updated
	END IF
!------------------------------------------------------------------------------------------!
!----------------------------- finding which input neurons spiked -------------------------!
	WHERE(spk(j0:jf))
		ypre1(j0:jf) = ypre1(j0:jf)*EXP((spkt_pre1(j0:jf)-tr)/pr(173)) + 1.0d0		!update pre trace with spike
		spkt_pre1(j0:jf) = tr								!update time of last spike for trace
	END WHERE
!------------------------------------------------------------------------------------------!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
