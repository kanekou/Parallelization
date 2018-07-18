# Parallelization
計算問題を並列化し，速度計測を行う．

## fibonacci数列
2つ前の項と1つ前の項を足してできる数列のことをfibonacci数列という．
今回は様々な言語でfibonacci数列の並列化を行い，逐次処理とどのような違いがでるのか検証する．

### 実行方法 

引数として，項数を指定する．

例:
```
go run fibonacci.go 20
```

## 行列演算
行列の掛け算を様々な言語で実装し、逐次処理とどのような違いがでるか検証する．
行ごとの掛け算を並列化する．

### 実行方法

#### 逐次処理

引数として，行列のサイズを指定する．

例: 4*4行列
```
go run matrix.go 4
```

#### 並列処理

第1引数に行列のサイズを，第2引数に並列度を指定する．

例: 4*4行列，並列度2
```
go run matrix_p.go 4 2 
```
 
 ##参考サイト
 - [Goでお手軽に行列の積を爆速並列計算](https://qiita.com/hamadu/items/fce4ee1e4b5c2c2d24df)
 - [Golangでゴルーチンにより再帰関数を並列処理](https://qiita.com/hiroykam/items/fdbb68ea21e5c67b8225)
