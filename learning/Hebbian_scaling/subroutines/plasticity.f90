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
!==========================================================================================!
!=========================== scaling plasticity - pop 2 ===================================!
	j0 = ne + ni1 + 1
	jf = ne + ni1 + ni2
	x(12) = x(12)*pr(184)
	IF(x(12).GT.pr(182)*2.0d0) msynw(j0:jf) = msynw(j0:jf) + pr(181)*pr(93)*(x(12) - pr(182))		!potentiation
	IF(x(12).LT.pr(182)*0.5d0) msynw(j0:jf) = msynw(j0:jf) + pr(181)*msynw(j0:jf)*(x(12) - pr(182))		!depression
	IF(spk_post) x(12) = x(12) + pr(185)
!==========================================================================================!
!======================== max and min values for inhibitory synapses ======================!
	j0 = ne + 1				!vector starting point
	jf = ne + ni1 + ni2			!vector ending point
	WHERE(msynw(j0:jf).GT.pr(153)) msynw(j0:jf) = pr(153)	!clip weights to max value
	WHERE(msynw(j0:jf).LT.pr(157)) msynw(j0:jf) = pr(157)	!clip weigths to min value
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
