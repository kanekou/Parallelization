#!/usr/bin/env sh

# 以前の測定用ファイルを削除
if ls ./Java/*.txt > /dev/null 2>&1 ;
    then rm ./Java/*.txt
fi

javac ./Java/MatrixcalSuccessively.java ./Java/MatrixcalTask.java 

size_of_matrix=0;
loop_count=1;

cd ./Java/ 

# N * N(N=100 ~ 1000)の行列の実行時間を測定
for n in `seq 1 10`
do 
    for i in `seq 1 $loop_count` #loop_count回測定した平均
    do  
        size_of_matrix=`expr $n \* 100`
        thread_size=1
        
        echo "Java Sequential, N = $size_of_matrix * $size_of_matrix"
        (java MatrixcalSuccessively $size_of_matrix) | grep "time" | egrep -o '[0-9]+[\.]+[0-9]+[0-9]'>> java_matrix$size_of_matrix.txt
       
        for p in `seq 1 7` # 並列度4**p(p=1~3)まで測定
        do
            thread_size=`expr $thread_size \+ 1`
            
            echo "Java Concurrency $thread_size, N = $size_of_matrix * $size_of_matrix"
            (java MatrixcalTask $size_of_matrix $thread_size) | grep "time" | egrep -o '[0-9]+[\.]+[0-9]+[0-9]'>> java_thread${thread_size}_matrix${size_of_matrix}.txt
            
        done    
    done
done

cd ../


size_of_matrix=0

#平均を求める
for n in `seq 1 10` # N * N(N=100 ~ 1000)の行
do
    size_of_matrix=`expr $n \* 100`
    thread_size=1
    
    /bin/echo -n $size_of_matrix" " >> ./Java/java_ave.txt
    cat ./Java/java_matrix$size_of_matrix.txt | awk '{x++;sum+=$1}END {print sum/x}' >> ./Java/java_ave.txt
    
    for p in `seq 1 7` # 並列度4**p(p=1~3)まで計算
    do
        thread_size=`expr $thread_size \+ 1`
        
        /bin/echo -n $size_of_matrix" " >> ./Java/java_thread${thread_size}_ave.txt
        cat ./Java/java_thread${thread_size}_matrix${size_of_matrix}.txt | awk '{x++;sum+=$1}END {print sum/x}' >> ./Java/java_thread${thread_size}_ave.txt
        
    done
done

#グラフ出力
gnuplot matrix_java.plt
