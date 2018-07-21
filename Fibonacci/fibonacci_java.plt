set terminal svg
set ylabel 'time(sec)'
set xlabel 'N'
set key box left
set title 'Fibonacci ExecutionSpeed by Java'
set output "output_fibonacci_java.svg"
plot "./Java/java_ave.txt" with lp title "逐次","./Java/java_p_ave.txt" with lp title "並列"
