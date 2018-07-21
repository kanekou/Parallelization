#!/usr/bin/env sh

# 以前の測定用ファイルを削除
if ls ./Python/*.txt > /dev/null 2>&1 ;
    then rm ./Python/*.txt
fi

size_of_matrix=0;

# N * N(N=100 ~ 1000)の行列の実行時間を測定
for n in `seq 1 10`
do 
    for i in `seq 1 1` # 10回測定した平均
    do  
        size_of_matrix=`expr $n \* 100`
        thread_size=1
        
        echo "Python Sequential, N = $size_of_matrix * $size_of_matrix"
        (python3 ./Python/matrix.py $size_of_matrix) | grep "time" | egrep -o '[0-9]+[\.]+[0-9]+[0-9]'>> ./Python/py3_matrix$size_of_matrix.txt

        for p in `seq 1 3` # 並列度4**p(p=1~8)まで測定
        do
            thread_size=`expr $thread_size \* 4`

            #echo "Java Concurrency $thread_size, N = $size_of_matrix * $size_of_matrix"
            #(java NQueen $size_of_matrix) | grep "Time" | egrep -o '[0-9]+[\.]+[0-9]+[0-9]'>> java_$size_of_matrix.txt 
            
            echo "Python Concurrency $thread_size, N = $size_of_matrix * $size_of_matrix"
            (python3 ./Python/matrix_p.py $size_of_matrix $thread_size) | grep "time" | egrep -o '[0-9]+[\.]+[0-9]+[0-9]'>> ./Python/py3_thread${thread_size}_matrix${size_of_matrix}.txt

        done    
    done
done


size_of_matrix=0

#平均を求める
for n in `seq 1 10` # N * N(N=100 ~ 1000)の行
do
    size_of_matrix=`expr $n \* 100`
    thread_size=1
    
    /bin/echo -n $size_of_matrix" " >> ./Python/py3_ave.txt
    cat ./Python/py3_matrix$size_of_matrix.txt | awk '{x++;sum+=$1}END {print sum/x}' >> ./Python/py3_ave.txt
    
    for p in `seq 1 3` # 並列度4**p(p=1~8)まで計算
    do
        thread_size=`expr $thread_size \* 4`

        #/bin/echo -n $size_of_matrix" " >> py2_ave.txt
        #cat py2_$size_of_matrix.txt | awk '{x++;sum+=$1}END {print sum/x}' >> py2_ave.txt
        
        /bin/echo -n $size_of_matrix" " >> ./Python/py3_thread${thread_size}_ave.txt
        cat ./Python/py3_thread${thread_size}_matrix${size_of_matrix}.txt  | awk '{x++;sum+=$1}END {print sum/x}' >> ./Python/py3_thread${thread_size}_ave.txt
    done
done

#グラフ出力
gnuplot matrix_py.plt
