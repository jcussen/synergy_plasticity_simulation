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
!======================== anti-Hebbian plasticity - pop 2 =================================!
	j0 = ne + ni1 + 1			!vector starting point
	jf = ne + ni1 + ni2			!vector ending point
!------------------------- finding which input neurons spiked -----------------------------!
	WHERE(spk(j0:jf))
		ypost2(j0:jf) = ypost2(j0:jf)*EXP((spkt_post2(j0:jf)-tr)/pr(193))		!update post trace
		spkt_post2(j0:jf) = tr								!update time of last spike for trace
		msynw(j0:jf) = msynw(j0:jf) - x(11)*(ypost2(j0:jf) - pr(192))			!update weights
	END WHERE
!------------------------------------------------------------------------------------------!
!--------------------------- updates when post neuron spikes ------------------------------!
	IF(spk_post) THEN
		ypre2(j0:jf) = ypre2(j0:jf)*EXP((spkt_pre2(j0:jf)-tr)/pr(193))			!update pre trace
		spkt_pre2(j0:jf) = tr								!update time of last spike for trace
		msynw(j0:jf) = msynw(j0:jf) - x(11)*ypre2(j0:jf)				!update weights
		ypost2(j0:jf) = ypost2(j0:jf)*EXP((spkt_post2(j0:jf)-tr)/pr(193)) + 1.0d0	!update post trace with spike
		spkt_post2(j0:jf) = tr								!update time of last trace update
	END IF
!------------------------------------------------------------------------------------------!
!----------------------------- finding which input neurons spiked -------------------------!
	WHERE(spk(j0:jf))
		ypre2(j0:jf) = ypre2(j0:jf)*EXP((spkt_pre2(j0:jf)-tr)/pr(193)) + 1.0d0		!update pre trace with spike
		spkt_pre2(j0:jf) = tr								!update time of last trace update
	END WHERE
!------------------------------------------------------------------------------------------!
!------------------------------ decaying of learning rate ---------------------------------!
	x(11) = x(11)*pr(194)
!------------------------------------------------------------------------------------------!
!==========================================================================================!
!======================== max and min values for inhibitory synapses ======================!
	j0 = ne + 1				!vector starting point
	jf = ne + ni1 + ni2			!vector ending point
	WHERE(msynw(j0:jf).GT.pr(153)) msynw(j0:jf) = pr(153)	!clip weights to max value
	WHERE(msynw(j0:jf).LT.pr(157)) msynw(j0:jf) = pr(157)	!clip weigths to min value
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
