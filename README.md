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
```
go run fibonacci.go 20
```

### 実行時間計測結果

- output_fibonacci.svg : Golang,Java,Python3

![fibonacci](https://github.com/e165726/Parallelization/blob/master/Fibonacci/output_fibonacci.svg)

全体的にNが上がっていくにつれ，並列化した処理が遅くなる．Javaは見えないので拡大する．
___

- output_Matrix_java.svg : Java

![fibonacci_java](https://github.com/e165726/Parallelization/blob/master/Fibonacci/output_fibonacci_java.svg)

Javaも並列化処理はNに比例して低速となる．

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

- output_Matrix_go.svg : Golang

![matrix_go](https://github.com/e165726/Parallelization/blob/master/Matrix/output_Matrix_go.svg)

逐次処理に比べて並列処理が大幅に高速化している．
___
- output_Matrix_no_sequential_go.svg : Golang(逐次なし)

![matrix_go_no_sequentioal](https://github.com/e165726/Parallelization/blob/master/Matrix/output_Matrix_no_sequential_go.svg)

並列度4が一番高速である．
___

- output_Matrix_java.svg : Java

![matrix_java](https://github.com/e165726/Parallelization/blob/master/Matrix/output_Matrix_java.svg)

逐次処理が最も高速である．並列化による高速化は見られない．
___

- output_Matrix_py3.svg : Python3

![matrix_py3](https://github.com/e165726/Parallelization/blob/master/Matrix/output_Matrix_py3.svg)

numpyが最も高速である．次に逐次処理となる．並列化による高速化は見られず，低速化している．

## 全体考察
フィボナッチ数列の実行結果が並列処理よりも逐次処理の方が速くなっていた．理由として，フィボナッチ数列は解を出すために，一つ前の解と二つ前の解が必要な逐次性が高いものだということが挙げられる．これにより，解を出すために他の解が計算結果を出すまで待つ必要があるため，その待機時間による遅延が逐次処理より遅くなった理由として有力だと思われる．

行列の積計算は，Go言語では逐次処理より並列処理の方が処理速度は速くなった．しかし，JavaとPython3では並列処理より逐次処理の方が速くなった．理由として，Go言語はゴルーチンと呼ばれる軽量スレッドを持ち，効率よく並列処理を行えるという利点が挙げられる．具体的には，長く実行されているゴルーチンのグローバルキューへの退避，処理が終了したプロセッサーが他プロフェッサーからゴルーチンの取得を行うといった等の工夫を行い，処理を効率化し，並列性の高い並列処理において高速化を図っていると考えられる．


output_Matrix_no_sequential_go.svgのグラフを見ると並列度4が最も高速であることがわかる。これは測定に使用したMacBook Pro (Retina、13-inch、Early 2015)が最大CPUコア数4であるためだと予測される．

 
 ## 参考サイト
 - [Goでお手軽に行列の積を爆速並列計算](https://qiita.com/hamadu/items/fce4ee1e4b5c2c2d24df)
 - [Golangでゴルーチンにより再帰関数を並列処理](https://qiita.com/hiroykam/items/fdbb68ea21e5c67b8225)
