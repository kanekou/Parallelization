# Parallelization
計算問題を並列化し，速度計測を行う．

## 実行環境
MacBook Pro (Retina、13-inch、Early 2015)

## fibonacci数列
2つ前の項と1つ前の項を足してできる数列のことをfibonacci数列という．
今回は様々な言語でfibonacci数列の並列化を行い，逐次処理とどのような違いがでるのか検証する．

処理速度計測のため，結果を出力するprint文はコメントアウトしている．

### 実行方法 

引数として，項数を指定する．

例: N=20  
```./fibonacci/fibonacci.go```
```
go run fibonacci.go 20
```

### 実行時間計測結果

shell scriptを実行することで，実行時間が測定され，グラフ出力される．

例:各言語の実行時間測定  
./fibonacci/fibonacci.sh
```
sh fibonacci.sh
```

- ```./fibonacci/output_fibonacci.svg``` : Golang,Java,Python3

![fibonacci](https://github.com/e165726/Parallelization/blob/master/Fibonacci/output_fibonacci.svg)

全体的にNが上がっていくにつれ，並列化した処理が遅くなる．Javaは見えないので単体で測定する．
___

- ```./fibonacci/output_Matrix_java.svg``` : Java

![fibonacci_java](https://github.com/e165726/Parallelization/blob/master/Fibonacci/output_fibonacci_java.svg)

Javaも並列化処理はNに比例して低速となる．全体的な並列処理よりも逐次処理の方が速くなってることがわかる．

## 行列演算
行列の掛け算を様々な言語で実装し、逐次処理とどのような違いがでるか検証する．
行ごとの掛け算を並列化する．

処理速度計測のため，結果を出力するprint文はコメントアウトしている．

### 実行方法

- 逐次処理

引数として，行列のサイズを指定する．

例: 4*4行列  
./matrix/matrix.go
```
go run matrix.go 4
```

- 並列処理

 第1引数に行列のサイズを，第2引数に並列度を指定する．

 例: 4*4行列，並列度2  
 ./matrix/matrix_p.go
```
go run matrix_p.go 4 2 
```

### 実行時間計測結果

各言語ごとにshell scriptを実行することで，実行時間が測定され，グラフ出力される．

例:Go言語の実行時間測定  
./matrix/matrix.sh
```
sh matrix_go.sh 
```

- ```./matrix/output_Matrix_go.svg``` : Golang

![matrix_go](https://github.com/e165726/Parallelization/blob/master/Matrix/output_Matrix_go.svg)

逐次処理に比べて並列処理が大幅に高速化している．逐次なしで見てみる．
___
- ```./matrix/output_Matrix_no_sequential_go.svg``` : Golang(逐次なし)

![matrix_go_no_sequentioal](https://github.com/e165726/Parallelization/blob/master/Matrix/output_Matrix_no_sequential_go.svg)

並列度4が一番高速である．これは測定に使用したMacBook Pro (Retina、13-inch、Early 2015)が最大CPUコア数4であるためだと考えられる．
___

- ```./matrix/output_Matrix_java.svg``` : Java

![matrix_java](https://github.com/e165726/Parallelization/blob/master/Matrix/output_Matrix_java.svg)

逐次処理が最も高速である．並列化による高速化は見られない．
___

- ```./matrix/output_Matrix_py3.sv```g : Python3

![matrix_py3](https://github.com/e165726/Parallelization/blob/master/Matrix/output_Matrix_py3.svg)

numpyが最も高速である．次に逐次処理となる．並列化による高速化は見られず，低速化している．

## 改善点
時間の関係上，RubyやPerlの実装と時間計測が間に合わなかったのが課題として残った．行列計算のJavaは使用したクラスが古いため，適切なクラスを使用すれば高速化が図れる可能性がある．

## 参考サイト
 - [Goでお手軽に行列の積を爆速並列計算](https://qiita.com/hamadu/items/fce4ee1e4b5c2c2d24df)
 - [Golangでゴルーチンにより再帰関数を並列処理](https://qiita.com/hiroykam/items/fdbb68ea21e5c67b8225)
 - [Java oracle公式ドキュメント](https://docs.oracle.com/javase/jp/8/docs/api/java/util/concurrent/RecursiveTask.html)
 
