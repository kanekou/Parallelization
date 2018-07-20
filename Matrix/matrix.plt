set terminal svg
set ylabel 'time(sec)'
set xlabel 'N'
set title 'Matrix Operation ExecutionSpeed by Golang'
set output "output_Matrix.svg"
plot "./Go/go_ave.txt" w lp title "逐次", for [i=1:7] sprintf("./Go/go_thread%d_ave.txt", 4**i) w lp title sprintf("並列度%d", 4**i)
