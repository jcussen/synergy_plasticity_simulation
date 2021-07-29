!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!              IMPLEMENTATION OF HOMOGENEOUS POISSON INPUT                   !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE input_s(pw)
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	IMPLICIT NONE
	INTEGER			::	pw,j0,jf
!======================= GENERATING STEP INPUT ============================================!
	inp_patt = 0.0d0 ! step input increases inp_patt for pathway slightly - makes it more likely to fire!!!
	IF(pw.GT.0) THEN
		inp_patt(((pw-1)*ne_pw)+1:ne_pw*pw) = (dt*inp_fr)/1000.0d0
		inp_patt(((pw-1)*ni_pw1)+ne+1:ne+ni_pw1*pw) = 2.0d0*(dt*inp_fr)/1000.0d0
		inp_patt(((pw-1)*ni_pw2)+ne+ni1+1:ne+ni1+ni_pw2*pw) = 2.0d0*(dt*inp_fr)/1000.0d0
	END IF
!==========================================================================================!
!======================== generate spikes from rate probabilities =========================!
!-------------------------- resetting presynaptic spikes variables ------------------------!
	spkr = 0.0d0
	spk = .FALSE.
!------------------------------------------------------------------------------------------!
!------------------------ vector with random numbers between 0 and 1 ----------------------!
	CALL RANDOM_NUMBER(tmp_inp)
!------------------------------------------------------------------------------------------!
!------------------------- excitatory neurons ---------------------------------------------!
	j0 = 1			!vector starting point
	jf = ne			!vector ending point
!------------ finding neurons that spiked and implementing refrac period ------------------!
	WHERE((tmp_inp(j0:jf).LE.(pr(75)+inp_patt(j0:jf))).AND.(tr-spkt(j0:jf).GT.pr(3)))
		spk(j0:jf) = .TRUE.	!spike variable to YES
		spkt(j0:jf) = tr	!spike time update
		spkr(j0:jf) = 1.0d0	!spike variable for inputs
	END WHERE
	counter(1)=counter(1)+int(sum(spkr(j0:jf)))!get total spike count for excitatory population
	counter(4)=counter(4)+int(sum(spkr(((pw-1)*ne_pw)+1:ne_pw*pw)))!get spike count for stimulated excitatory pathway
!------------------------------------------------------------------------------------------!
!------------------------------------------------------------------------------------------!
!------------------------ inhibitory neurons pop 1 ----------------------------------------!
	j0 = ne + 1		!vector starting point
	jf = ne + ni1		!vector ending point
!------------ finding neurons that spiked and implementing refrac period ------------------!
	WHERE((tmp_inp(j0:jf).LE.(pr(76)+pr(205)*inp_patt(j0:jf))).AND.(tr-spkt(j0:jf).GT.(0.5d0*pr(3))))
		spk(j0:jf) = .TRUE.	!spike variable to YES
		spkt(j0:jf) = tr	!spike time update
		spkr(j0:jf) = 1.0d0	!spike variable for inputs
	END WHERE
	counter(2)=counter(2)+int(sum(spkr(j0:jf)))	!total spike count for inhib 1 population
	counter(5)=counter(5)+int(sum(spkr(((pw-1)*ni_pw1)+ne+1:ne+ni_pw1*pw))) !spike count for stimulated inhib1 pathway
!------------------------------------------------------------------------------------------!
!------------------------------------------------------------------------------------------!
!------------------------- inhibitory neurons pop 2 ---------------------------------------!
	j0 = ne + ni1 + 1	!vector starting point
	jf = ne + ni1 + ni2	!vector ending point
!------------ finding neurons that spiked and implementing refrac period ------------------!
	WHERE((tmp_inp(j0:jf).LE.(pr(76)+pr(206)*inp_patt(j0:jf))).AND.(tr-spkt(j0:jf).GT.(0.5d0*pr(3))))
		spk(j0:jf) = .TRUE.	!spike variable to YES
		spkt(j0:jf) = tr	!spike time update
		spkr(j0:jf) = 1.0d0	!spike variable for inputs
	END WHERE
	counter(3)=counter(3)+int(sum(spkr(j0:jf)))
	counter(6)=counter(6)+int(sum(spkr(((pw-1)*ni_pw2)+ne+ni1+1:ne+ni1+ni_pw2*pw)))
!------------------------------------------------------------------------------------------!
!------------------------------------------------------------------------------------------!
!==========================================================================================!
!=========================== update synaptic conductances =================================!
!-------------------------excitatory neurons-----------------------------------------------!
	x(2) = x(2) + SUM(spkr(1:ne)*msynw(1:ne))
!------------------------------------------------------------------------------------------!
!-------------------------inhibitory neurons-----------------------------------------------!
	x(3) = x(3) + SUM(spkr(ne+1:ne+ni1+ni2)*msynw(ne+1:ne+ni1+ni2))
!------------------------------------------------------------------------------------------!
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
