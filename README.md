# Parallelization
計算問題を並列化し，速度計測を行う．

## fibonacci数列
2つ前の項と1つ前の項を足してできる数列のことをfibonacci数列という．
今回は様々な言語でfibonacci数列の並列化を行い，逐次処理とどのような違いがあるのか検証する．

### 実行方法 

引数として，項数を指定する．

例:
```
go run fibonacci.go 20
```
