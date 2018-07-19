#!/usr/bin/env sh

number_of_terms=0;

#コンパイル
#javac CrossGene.java Fitness.java Gene.java NQueen.java

# 項数N = 5~35まで5刻みで測定
for i in `seq 1 3`
do 
    for j in `seq 1 10` # 10回測定した平均
    do  
        number_of_terms=`expr $i \* 5`
        
        echo "n="$number_of_terms

        echo "go no parallel"
        (go run ./Go/fibonacci.go $number_of_terms) | grep "time" | egrep -o '[0-9]+[\.]+[0-9]+[0-9]'>> ./Go/go_$number_of_terms.txt

        echo "go parallel"
        (go run ./Go/fibonacci_p.go $number_of_terms) | grep "time" | egrep -o '[0-9]+[\.]+[0-9]+[0-9]'>> ./Go/go_p_$number_of_terms.txt

        echo "go parallel fix"
        (go run ./Go/fibonacci_p_fix.go $number_of_terms) | grep "time" | egrep -o '[0-9]+[\.]+[0-9]+[0-9]'>> ./Go/go_p_fix_$number_of_terms.txt

        #echo "java"
        #(java NQueen $number_of_terms) | grep "Time" | egrep -o '[0-9]+[\.]+[0-9]+[0-9]'>> java_$number_of_terms.txt 
        
        #echo "python3"
        #(python3 nqueen.py $number_of_terms) | grep "Time" | egrep -o '[0-9]+[\.]+[0-9]+[0-9]'>> py3_$number_of_terms.txt
        
    done
done

number_of_terms=0

#平均を求める
for i in `seq 1 3` #項数N = 5~35(5刻み)
do
    number_of_terms=`expr $i \* 5`
   
    /bin/echo -n $number_of_terms" " >> ./Go/go_ave.txt
    cat ./Go/go_$number_of_terms.txt | awk '{x++;sum+=$1}END {print sum/x}' >> ./Go/go_ave.txt
    
    /bin/echo -n $number_of_terms" " >> ./Go/go_p_ave.txt
    cat ./Go/go_p_$number_of_terms.txt | awk '{x++;sum+=$1}END {print sum/x}' >> ./Go/go_p_ave.txt
    
    /bin/echo -n $number_of_terms" " >> ./Go/go_p_fix_ave.txt
    cat ./Go/go_p_fix_$number_of_terms.txt | awk '{x++;sum+=$1}END {print sum/x}' >> ./Go/go_p_fix_ave.txt
    
    #/bin/echo -n $number_of_terms" " >> py2_ave.txt
    #cat py2_$number_of_terms.txt | awk '{x++;sum+=$1}END {print sum/x}' >> py2_ave.txt
    
    #/bin/echo -n $number_of_terms" " >> py3_ave.txt
    #cat py3_$number_of_terms.txt | awk '{x++;sum+=$1}END {print sum/x}' >> py3_ave.txt
done

#グラフ出力
gnuplot fibonacci.plt
