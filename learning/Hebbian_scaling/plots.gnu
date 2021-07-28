working_directory = system('cat plots_tmp.txt')."/"

set terminal qt size 1024,1024 enhanced font "Arial, 15" persist

set linetype 1 lc rgb "#a6cee3" lw 2
set linetype 2 lc rgb "#1f78b4" lw 2
set linetype 3 lc rgb "#b2df8a" lw 2
set linetype 4 lc rgb "#33a02c" lw 2
set linetype 5 lc rgb "#fb9a99" lw 2
set linetype 6 lc rgb "#e31a1c" lw 2
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

set border linewidth 1.5

unset key

set border 1+2
set ytics nomirror out
set xtics nomirror out

set rmargin 10

set multiplot

set origin 0,0
set size 1,0.3022
set xrange [0:20]
set yrange [0:1.0]
set ylabel "weight"
set xlabel "time (mins)"
set label "scaling" at 9.3,1.0
p for [i=18:33] working_directory."data03.dat" u ($1/60000):i w l

set origin 0,0.3
set size 1,0.26
set yrange [0:2.5]
set format x ""
unset xlabel
unset label
set label "Hebbian" at 9,2.5
p for [i=2:17] working_directory."data03.dat" u ($1/60000):i w l

set origin 0,0.57
set size 0.5,0.23
set xrange [0:17]
set mxtics 3
set xtics out nomirror 1,3
set xlabel "signal input"
set yrange [0:3]
set ytics 1
set format x
unset label
set label "after" at 7.5,3
p working_directory."data02.dat" u 1:(4.4*$2) w l lt 17, working_directory."data02.dat" u 1:5 w l lt 18, working_directory."data02.dat" u 1:6 w l lt 19

set origin 0,0.78
set size 0.5,0.18
set xrange [0:17]
unset xlabel
set format x ""
unset label
set label "before" at 7.2,3
p working_directory."data02.dat" u 1:(4.4*$2) w l lt 17, working_directory."data02.dat" u 1:3 w l lt 18, working_directory."data02.dat" u 1:4 w l lt 19

set origin 0.5,0.57
set size 0.5,0.23
set xrange [0:400]
set xtics 200
unset mxtics
set xlabel "neuron"
set format x
unset label
set label "scaling" at 160,3
p working_directory."data01.dat" u ($1-3600):2 lc rgb "gray" pt 7 ps 0.5, working_directory."data01.dat" u ($1-3600):3 lt 19 pt 7 ps 0.5

set origin 0.5,0.78
set size 0.5,0.18
unset xlabel
set format x ""
unset label
set label "Hebbian" at 160,3
p working_directory."data01.dat" u ($1-3200):2 lc rgb "gray" pt 7 ps 0.5, working_directory."data01.dat" u ($1-3200):3 lt 18 pt 7 ps 0.5
