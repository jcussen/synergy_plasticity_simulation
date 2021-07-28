working_directory = system('cat plots_tmp.txt')."/"

set terminal qt size 1024,1024 enhanced font "Arial, 15" persist

set linetype 1 lc rgb "#4c4c4c" lw 2
set linetype 2 lc rgb "#d94801" lw 2
set linetype 3 lc rgb "#215ad4" lw 2
set linetype 4 lc rgb "#e78ac3" lw 2
set linetype 5 lc rgb "#e5c494" lw 2
set linetype 6 lc rgb "#66c2a5" lw 2
set linetype 7 lc rgb "#fdbf6f" lw 2
set linetype 8 lc rgb "#ff7f00" lw 2
set linetype 9 lc rgb "#cab2d6" lw 2
set linetype 10 lc rgb "#6a3d9a" lw 2
set linetype 11 lc rgb "#ffff99" lw 2
set linetype 12 lc rgb "#b15928" lw 2
set linetype 13 lc rgb "#b3de69" lw 2
set linetype 14 lc rgb "#fccde5" lw 2
set linetype 15 lc rgb "#d9d9d9" lw 2
set linetype 16 lc rgb "#bc80bd" lw 2

set linetype 17 lc rgb "#de2e26" lw 2
set linetype 18 lc rgb "#3182bd" lw 2
set linetype 19 lc rgb "#08306b" lw 2

set linetype 20 lc -1 lw 2

set border linewidth 1.5

unset key

set border 1+2
set ytics nomirror out
set xtics nomirror out

set rmargin 10

set multiplot

#######################################################

set origin 0,0
set size 0.45,0.3022
set xrange [0:2000]
set yrange [-70:-30]
set xtics 1000
set ytics -70,20
set ylabel "membrane potential (mV)"
set xlabel "time (ms)"
p working_directory."data01.dat" every ::0::19999 u ($1-1000):2 w l lt 1

set origin 0.36,0
set size 0.4,0.3022
set format y ""
unset ylabel
p working_directory."data01.dat" every ::20001::39999 u ($1-1000):2 w l lt 2

set origin 0.66,0
set size 0.4,0.3022
p working_directory."data01.dat" every ::40100::59999 u ($1-1000):2 w l lt 3

#######################################################

set origin 0,0.3
set size 0.45,0.25
set yrange [-50:50]
set format y
unset xlabel
set format x ""
set ytics 25
set ylabel "current (nA)"
p working_directory."data02.dat" every ::0::19999 u ($1-1000):($2/100) w l lt 17, "" every ::0::19999 u ($1-1000):(($3+$4)/100) w l lt 18, "" every ::0::19999 u ($1-1000):(($2+$3+$4+$5)/100) w l lt 20

set origin 0.36,0.3
set size 0.4,0.25
set format y ""
unset ylabel
p working_directory."data02.dat" every ::20001::39999 u ($1-1000):($2/100) w l lt 17, "" every ::20001::39999 u ($1-1000):(($3+$4)/100) w l lt 18, "" every ::20001::39999 u ($1-1000):(($2+$3+$4+$5)/100) w l lt 20

set origin 0.66,0.3
set size 0.4,0.25
p working_directory."data02.dat" every ::40100::59999 u ($1-1000):($2/100) w l lt 17, "" every ::40100::59999 u ($1-1000):(($3+$4)/100) w l lt 18, "" every ::40100::59999 u ($1-1000):(($2+$3+$4+$5)/100) w l lt 20

#######################################################

set origin 0,0.55
set size 0.45,0.25
set yrange [0:60]
set format y
unset xlabel
set format x ""
set ytics 20
set ylabel "input (Hz)"
set label "Control" at 800,70 textcolor lt 1 #rgb "#4c4c4c"
p working_directory."data03.dat" every ::0::19999 u ($1-1000):2 w l lt 4, "" every ::0::19999 u ($1-1000):17 w l lt 5, "" every ::0::19999 u ($1-1000):10 w l lt 6, "" every ::0::19999 u ($1-1000):(($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14+$15+$16+$17)/16) w l lt 20

set origin 0.36,0.55
set size 0.4,0.25
set format y ""
unset ylabel
unset label
set label "Weak inhibition" at 500,70 textcolor lt 2
p working_directory."data03.dat" every ::20001::39999 u ($1-1000):2 w l lt 4, "" every ::20001::39999 u ($1-1000):17 w l lt 5, "" every ::20001::39999 u ($1-1000):10 w l lt 6, "" every ::20001::39999 u ($1-1000):(($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14+$15+$16+$17)/16) w l lt 20

set origin 0.66,0.55
set size 0.4,0.25
unset label
set label "Strong inhibition" at 500,70 textcolor lt 3
p working_directory."data03.dat" every ::40100::59999 u ($1-1000):2 w l lt 4, "" every ::40100::59999 u ($1-1000):17 w l lt 5, "" every ::40100::59999 u ($1-1000):10 w l lt 6, "" every ::40100::59999 u ($1-1000):(($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14+$15+$16+$17)/16) w l lt 20
