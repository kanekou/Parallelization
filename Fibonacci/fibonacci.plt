set terminal svg
set ylabel 'time(sec)'
set xlabel 'N'
set key box left
set title 'Fibonacci ExecutionSpeed'
set output "output_fibonacci.svg"
plot "./Go/go_ave.txt" with lp title "Golang 逐次","./Go/go_p_ave.txt" with lp title "Golang 並列","./Go/go_p_fix_ave.txt" with lp title "Golang 並列改良","./Java/java_ave.txt" with lp title "Java 逐次","./Java/java_p_ave.txt" with lp title "Java 並列","./Python/py3_ave.txt" with lp title "Python3 逐次","./Python/py3_p_ave.txt" with lp title "Python3 並列"
