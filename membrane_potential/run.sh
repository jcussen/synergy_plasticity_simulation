#!/bin/bash
echo "==================================================================="
echo "=----------------- please type which sim you want ----------------="
echo "=---- 1 for Co-tuned only (from Hebbian) -------------------------="
echo "=---- 2 for Co-tuned (Hebbian) + flat (scaling) ------------------="
echo "=---- 3 for Co-tuned (Hebbian) + counter-tuned (anti-Hebbian) ----="
read -n 1 k <&1
echo ""
echo "=------------------------ messages: ------------------------------="
if [[ $k = 1 ]] ; then
echo "Co-tuned only (from Hebbian) chosen"
echo "==================================================================="
else
if [[ $k = 2 ]] ; then
echo "Co-tuned (Hebbian) + flat (scaling)"
echo "==================================================================="
else
if [[ $k = 3 ]] ; then
echo "Co-tuned (Hebbian) + counter-tuned (anti-Hebbian)"
echo "==================================================================="
else
echo "wrong input"
echo "type 1 or 2 or 3"
echo "exiting"
echo "==================================================================="
exit
fi
fi
fi
echo ""
echo "==================================================================="
echo "=------------------------ compiling ------------------------------="
echo "=                                                                 ="
echo "=------------------------ messages: ------------------------------="
gfortran complementary_switch_membrane.f90 -o complementary_executable -Ofast
echo "==================================================================="
echo ""
echo "==================================================================="
echo "=------------------------  running  ------------------------------="
echo "=                                                                 ="
echo "=------------------------ messages: ------------------------------="
./complementary_executable $k
echo "==================================================================="
echo ""
echo "==================================================================="
echo "=------------------------ plotting  ------------------------------="
echo "=                                                                 ="
echo "=------------------------ messages: ------------------------------="
if [[ $k = 1 ]] ; then
gnuplot plots1.gnu
rm *.mod
rm complementary_executable
fi
if [[ $k = 2 ]] ; then
gnuplot plots2.gnu
rm *.mod
rm complementary_executable
fi
if [[ $k = 3 ]] ; then
gnuplot plots3.gnu
rm *.mod
rm complementary_executable
fi
echo "==================================================================="
echo ""
echo "==================================================================="
echo "=-------------------------    done   -----------------------------="
echo "==================================================================="
echo ""
echo "==================================================================="
echo "==================================================================="
