#!/usr/bin/env sh

size_of_matrix=0;

#コンパイル
#javac CrossGene.java Fitness.java Gene.java NQueen.java

# N * N(N=100 ~ 1000)の行列の実行時間を測定
for n in `seq 1 10`
do 
    for j in `seq 1 10` # 10回測定した平均
    do  
        size_of_matrix=`expr $n \* 100`
        
        echo "go, N = $size_of_matrix * $size_of_matrix"
        (go run ./Go/matrix.go $size_of_matrix) | grep "time" | egrep -o '[0-9]+[\.]+[0-9]+[0-9]'>> ./Go/go_matrix$size_of_matrix.txt
       
        for thread_size in `seq 2 10` # 並列度
        do
            echo "go concurrency $thread_size, N = $size_of_matrix * $size_of_matrix"
            
            (go run ./Go/matrix_p.go $size_of_matrix $thread_size) | grep "time" | egrep -o '[0-9]+[\.]+[0-9]+[0-9]'>> ./Go/go_thread${thread_size}_matrix${size_of_matrix}.txt
            
            #echo "java"
            #(java NQueen $size_of_matrix) | grep "Time" | egrep -o '[0-9]+[\.]+[0-9]+[0-9]'>> java_$size_of_matrix.txt 
            
            #echo "python3"
            #(python3 nqueen.py $size_of_matrix) | grep "Time" | egrep -o '[0-9]+[\.]+[0-9]+[0-9]'>> py3_$size_of_matrix.txt
        done    
    done
done


size_of_matrix=0

#平均を求める
for n in `seq 1 10` # N * N(N=100 ~ 1000)の行
do
    size_of_matrix=`expr $n \* 100`
    
    /bin/echo -n $size_of_matrix" " >> ./Go/go_ave.txt
    cat ./Go/go_matrix$size_of_matrix.txt | awk '{x++;sum+=$1}END {print sum/x}' >> ./Go/go_ave.txt
    
    for thread_size in `seq 2 10` # 並列度
    do
        /bin/echo -n $size_of_matrix" " >> ./Go/go_thread${thread_size}_ave.txt
        cat ./Go/go_thread${thread_size}_matrix${size_of_matrix}.txt | awk '{x++;sum+=$1}END {print sum/x}' >> ./Go/go_thread${thread_size}_ave.txt
        
        #/bin/echo -n $size_of_matrix" " >> py2_ave.txt
        #cat py2_$size_of_matrix.txt | awk '{x++;sum+=$1}END {print sum/x}' >> py2_ave.txt
        
        #/bin/echo -n $size_of_matrix" " >> py3_ave.txt
        #cat py3_$size_of_matrix.txt | awk '{x++;sum+=$1}END {print sum/x}' >> py3_ave.txt
    done
done

#グラフ出力
gnuplot matrix.plt
