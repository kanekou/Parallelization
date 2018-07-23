set terminal svg
set ylabel 'time(sec)'
set xlabel 'N'
set title 'Matrix Operation ExecutionSpeed by Golang'
set key left box
set output "output_Matrix_go.svg"
plot "./Go/go_ave.txt" w lp title "逐次", for [i=1:4] sprintf("./Go/go_thread%d_ave.txt", i*2) w lp title sprintf("並列度%d", i*2)

set title 'Matrix Operation ExecutionSpeed by Golang \(Sequential None\)'
set output "output_Matrix_no_sequential_go.svg"
plot for [i=1:4] sprintf("./Go/go_thread%d_ave.txt", i*2) w lp title sprintf("並列度%d", i*2)


