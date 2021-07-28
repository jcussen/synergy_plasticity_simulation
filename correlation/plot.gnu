# working_directory = system('cat plots_tmp.txt')."/"

# set terminal qt size 1024,512 enhanced font "Arial, 15" persist

# set linetype 1 lc rgb "#646464" lw 2
# set linetype 2 lc rgb "#54278f" lw 2
# set linetype 3 lc rgb "#41ab5d" lw 2

# set border linewidth 1.5

# unset key

# set border 1+2
# set ytics nomirror out
# set rmargin 10

# set xrange [0:17]
# set mxtics 3
# set xtics out nomirror 1,3
# set ylabel "correlation"
# set xlabel "signal input"
# set yrange [-0.15:0.25]
# set ytics 0.1
# # p working_directory."data01.dat" every ::0::15 u 1:2 w l lt 1, "" every ::16::31 u 1:2 w l lt 2, "" every ::32::47 u 1:2 w l lt 19, 0 lc -1 lw 1.5
# commented the above line out to suppress the output of the data01.dat file!