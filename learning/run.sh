#!/bin/bash
echo "======================================="
echo "=--- please type which sim you want --="
echo "=---- 1 for Hebbian + scaling --------="
echo "=---- 2 for Hebbian + anti-Hebbian ---="
echo "=---- 3 for Hebbian + Hebbian --------="
read -n 1 k <&1
echo ""
echo "=------------ messages: --------------="
if [[ $k = 1 ]] ; then
echo "Hebbian + scaling chosen"
echo "======================================="
cd Hebbian_scaling
else
if [[ $k = 2 ]] ; then
echo "Hebbian + anti-Hebbian chosen"
echo "======================================="
cd Hebbian_antiHebbian
else
if [[ $k = 3 ]] ; then
echo "Hebbian + Hebbian chosen"
echo "======================================="
cd Hebbian_Hebbian
else
echo "wrong input"
echo "type 1 or 2"
echo "exiting"
echo "======================================="
exit
fi
fi
fi
echo ""
echo "======================================="
echo "=------------- compiling -------------="
echo "=                                     ="
echo "=------------ messages: --------------="
if [[ $k = 1 ]] || [[ $k = 2 ]] || [[ $k = 3 ]]; then
gfortran complementary_switch_learning.f90 -o complementary_executable -Ofast
fi
echo "======================================="
echo ""
echo "======================================="
echo "=-------------  running  -------------="
echo "=                                     ="
echo "=------------ messages: --------------="
if [[ $k = 1 ]] || [[ $k = 2 ]] || [[ $k = 3 ]]; then
./complementary_executable
fi
echo "======================================="
echo ""
echo "======================================="
echo "=------------- plotting  -------------="
echo "=                                     ="
echo "=------------ messages: --------------="
if [[ $k = 1 ]] || [[ $k = 2 ]] || [[ $k = 3 ]]; then
gnuplot plots.gnu
rm *.mod
rm complementary_executable
rm plots_tmp.txt
cd ..
fi
echo "======================================="
echo ""
echo "======================================="
echo "=-------------    done   -------------="
echo "======================================="
echo ""
echo "======================================="
echo "=-------------    bye    -------------="
echo "======================================="
