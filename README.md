# Parallelization
計算問題を並列化し，速度計測を行う．

## fibonacci数列
2つ前の項と1つ前の項を足してできる数列のことをfibonacci数列という．
今回は様々な言語でfibonacci数列の並列化を行い，逐次処理とどのような違いがでるのか検証する．

処理速度計測のため，結果を出力するprint文はコメントアウトしている．

### 実行方法 

引数として，項数を指定する．

例: N=20
```
go run fibonacci.go 20
```

### 実行時間計測結果

- output_fibonacci.svg

![fibonacci数列](https://github.com/e165726/Parallelization/blob/master/Fibonacci/output_fibonacci.svg)

## 行列演算
行列の掛け算を様々な言語で実装し、逐次処理とどのような違いがでるか検証する．
行ごとの掛け算を並列化する．

処理速度計測のため，結果を出力するprint文はコメントアウトしている．

### 実行方法

- 逐次処理

引数として，行列のサイズを指定する．

例: 4*4行列
```
go run matrix.go 4
```

- 並列処理

 第1引数に行列のサイズを，第2引数に並列度を指定する．

 例: 4*4行列，並列度2
```
go run matrix_p.go 4 2 
```

### 実行時間計測結果

- output_Matrix_go.svg

![matrix_go](https://github.com/e165726/Parallelization/blob/master/Matrix/output_Matrix_go.svg)

- output_Matrix_no_sequential_go.svg

![matrix_go_no_sequentioal](https://github.com/e165726/Parallelization/blob/master/Matrix/output_Matrix_no_sequential_go.svg)

- output_Matrix_java.svg

![matrix_java](https://github.com/e165726/Parallelization/blob/master/Matrix/output_Matrix_java.svg)

- output_Matrix_py3.svg

![matrix_py3](https://github.com/e165726/Parallelization/blob/master/Matrix/output_Matrix_py3.svg)

 
 ## 参考サイト
 - [Goでお手軽に行列の積を爆速並列計算](https://qiita.com/hamadu/items/fce4ee1e4b5c2c2d24df)
 - [Golangでゴルーチンにより再帰関数を並列処理](https://qiita.com/hiroykam/items/fdbb68ea21e5c67b8225)
