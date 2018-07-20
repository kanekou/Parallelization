/*
参考URL: https://qiita.com/hamadu/items/fce4ee1e4b5c2c2d24df
行ごとに並列して行列演算を行う
第一引数として，行列のサイズを指定する
*/

package main

import (
	"fmt"
	"os"
	"runtime"
	"strconv"
	"time"
)

type Matrix [][]int

func computePart(i int, a, b, c *Matrix, ch chan int) {
	ac := len((*a)[0])
	bc := len((*b)[0])
	for j := 0; j < bc; j++ {
		part := 0
		for k := 0; k < ac; k++ {
			part += (*a)[i][k] * (*b)[k][j]
		}
		(*c)[i][j] = part
	}
	ch <- 1
}

func mulConcurrent(a, b *Matrix) Matrix {
	ar := len(*a)
	ac := len((*a)[0])
	br := len(*b)
	bc := len((*b)[0])
	if ac != br {
		panic("wrong matrix type")
	}
	c := make(Matrix, ar)
	for i := 0; i < ar; i++ {
		c[i] = make([]int, bc)
	}

	ch := make(chan int)

	// それぞれの行を並列処理させる
	for i := 0; i < ar; i++ {
		go computePart(i, a, b, &c, ch)
	}

	// 終わるまで待つ
	for i := 0; i < ar; i++ {
		<-ch
	}
	return c
}

func main() {
	n, _ := strconv.Atoi(os.Args[1])
	k, _ := strconv.Atoi(os.Args[2])
	runtime.GOMAXPROCS(k)

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

	ans = mulConcurrent(&a, &b)

	end := time.Now() //測定終了
	exeSpeed := end.Sub(start)
	fmt.Printf("time = %.10f sec \n", exeSpeed.Seconds())

	fmt.Println(ans[0][0])
}
