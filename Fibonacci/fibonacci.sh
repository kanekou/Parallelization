#!/usr/bin/env sh

# 以前の測定用ファイルを削除
if ls ./**/*.txt > /dev/null 2>&1 ;
    then rm ./**/*.txt
fi

javac ./Java/FibonacciSuccessively.java ./Java/FibonacciTask.java 

number_of_terms=0;

# 項数N = 5~35まで5刻みで測定
for i in `seq 1 7`
do 
    for j in `seq 1 10` # 各10回測定
    do  
        number_of_terms=`expr $i \* 5`
        
        echo "n="$number_of_terms
        
        echo "go no parallel"
        (go run ./Go/fibonacci.go $number_of_terms) | grep "time" | egrep -o '[0-9]+[\.]+[0-9]+[0-9]'>> ./Go/go_$number_of_terms.txt

        echo "go parallel"
        (go run ./Go/fibonacci_p.go $number_of_terms) | grep "time" | egrep -o '[0-9]+[\.]+[0-9]+[0-9]'>> ./Go/go_p_$number_of_terms.txt

        echo "go parallel fix"
        (go run ./Go/fibonacci_p_fix.go $number_of_terms) | grep "time" | egrep -o '[0-9]+[\.]+[0-9]+[0-9]'>> ./Go/go_p_fix_$number_of_terms.txt
        
        echo "java no parallel"
        cd ./Java/
        (java FibonacciSuccessively $number_of_terms) | grep "time" | egrep -o '[0-9]+[\.]+[0-9]+[0-9]'>> ./Java_$number_of_terms.txt 

        echo "java parallel"
        (java FibonacciTask $number_of_terms) | grep "time" | egrep -o '[0-9]+[\.]+[0-9]+[0-9]'>> ./java_p_$number_of_terms.txt 
        cd ./../
      
        echo "python3 no parallel"
        (python3 -u ./Python/FibonacciSuccessively.py $number_of_terms)  | grep "time" | egrep -o '[0-9]+[\.]+[0-9]+[0-9]' >> ./Python/py3_$number_of_terms.txt 

        echo "python3 parallel"
        (python3 -u ./Python/FibonacciTask.py $number_of_terms) | grep "time" | egrep -o '[0-9]+[\.]+[0-9]+[0-9]'>> ./Python/py3_p_$number_of_terms.txt

    done
done

number_of_terms=0

#平均を求める
for i in `seq 1 7` #項数N = 5~35(5刻み)
do
    number_of_terms=`expr $i \* 5`
   
    /bin/echo -n $number_of_terms" " >> ./Go/go_ave.txt
    cat ./Go/go_$number_of_terms.txt | awk '{x++;sum+=$1}END {print sum/x}' >> ./Go/go_ave.txt
    
    /bin/echo -n $number_of_terms" " >> ./Go/go_p_ave.txt
    cat ./Go/go_p_$number_of_terms.txt | awk '{x++;sum+=$1}END {print sum/x}' >> ./Go/go_p_ave.txt
    
    /bin/echo -n $number_of_terms" " >> ./Go/go_p_fix_ave.txt
    cat ./Go/go_p_fix_$number_of_terms.txt | awk '{x++;sum+=$1}END {print sum/x}' >> ./Go/go_p_fix_ave.txt
    
    /bin/echo -n $number_of_terms" " >> ./Java/java_ave.txt
    cat ./Java/java_$number_of_terms.txt | awk '{x++;sum+=$1}END {print sum/x}' >> ./Java/java_ave.txt

    /bin/echo -n $number_of_terms" " >> ./Java/java_p_ave.txt
    cat ./Java/java_p_$number_of_terms.txt | awk '{x++;sum+=$1}END {print sum/x}' >> ./Java/java_p_ave.txt

    /bin/echo -n $number_of_terms" " >> ./Python/py3_ave.txt
    cat ./Python/py3_$number_of_terms.txt | awk '{x++;sum+=$1}END {print sum/x}' >> ./Python/py3_ave.txt
    
    /bin/echo -n $number_of_terms" " >> ./Python/py3_p_ave.txt
    cat ./Python/py3_p_$number_of_terms.txt | awk '{x++;sum+=$1}END {print sum/x}' >> ./Python/py3_p_ave.txt
done

#グラフ出力
gnuplot fibonacci.plt
gnuplot fibonacci_java.plt
