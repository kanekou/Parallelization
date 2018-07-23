set terminal svg
set ylabel 'time(sec)'
set xlabel 'N'
set title 'Matrix Operation ExecutionSpeed by Java'
set key left box
set output "output_Matrix_java.svg"
plot "./Java/java_ave.txt" w lp title "逐次", for [i=1:4] sprintf("./Java/java_thread%d_ave.txt", i*2) w lp title sprintf("並列度%d", i*2)



