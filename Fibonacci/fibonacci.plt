set terminal svg
set ylabel 'time(sec)'
set xlabel 'N'
set title 'Fibonacci ExecutionSpeed'
set output "output_fibonacci.svg"
plot "./Go/go_ave.txt" with lp,"./Go/go_p_ave.txt" with lp,"./Go/go_p_fix_ave.txt" with lp

