/*
参考URL: https://qiita.com/hamadu/items/fce4ee1e4b5c2c2d24df
逐次的に行列演算を行う
第一引数として，行列のサイズを指定する
*/

package main

import (
	"fmt"
	"os"
	"strconv"
	"time"
)

type Matrix [][]int

func mul(a, b *Matrix) Matrix {
	ar := len(*a)
	ac := len((*a)[0])
	br := len(*b)
	bc := len((*b)[0])

	// 縦横のサイズが合わない場合
	if ac != br {
		panic("wrong matrix type")
	}

	// ここが O(n^3) になってる
	c := make(Matrix, ar)
	for i := 0; i < ar; i++ {
		c[i] = make([]int, bc)
		for j := 0; j < bc; j++ {
			for k := 0; k < ac; k++ {
				c[i][j] += (*a)[i][k] * (*b)[k][j]
			}
		}
	}
	return c
}

func main() {
	n, _ := strconv.Atoi(os.Args[1])

	a := make(Matrix, n)
	b := make(Matrix, n)

	//値50を行列に格納
	for i := 0; i < n; i++ {
		a[i] = make([]int, n)
		b[i] = make([]int, n)
		for j := 0; j < n; j++ {
			a[i][j] = 50
			b[i][j] = 50
		}
	}

	var ans Matrix
	start := time.Now() //測定開始

	ans = mul(&a, &b)

	end := time.Now() //測定終了
	exeSpeed := end.Sub(start)
	fmt.Printf("time = %.10f sec \n", exeSpeed.Seconds())
	fmt.Println(ans)
}
