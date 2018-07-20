set terminal svg
set ylabel 'time(sec)'
set xlabel 'N'
set title 'Matrix Operation ExecutionSpeed by Golang'
set output "output_Matrix.svg"
plot "./Go/go_ave.txt" w lp title "逐次", "./Go/go_thread2_ave.txt" w lp title "並列度2", "./Go/go_thread3_ave.txt" w lp title "並列度3", "./Go/go_thread4_ave.txt" w lp title "並列度4", "./Go/go_thread5_ave.txt" w lp title "並列度5", "./Go/go_thread6_ave.txt" w lp title "並列度6", "./Go/go_thread7_ave.txt" w lp title "並列度7", "./Go/go_thread8_ave.txt" w lp title "並列度8", "./Go/go_thread9_ave.txt" w lp title "並列度9", "./Go/go_thread10_ave.txt" w lp title "並列度10"
 
