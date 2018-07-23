set terminal svg
set ylabel 'time(sec)'
set xlabel 'N'
set title 'Matrix Operation ExecutionSpeed by Python3'
set key left box
set output "output_Matrix_py3.svg"
plot "./Python/py3_ave.txt" w lp title "逐次","./Python/py3_np_ave.txt" w lp title "逐次\(numpy\)", for [i=2:4] sprintf("./Python/py3_thread%d_ave.txt", i*2) w lp title sprintf("並列度%d", 2*i)

