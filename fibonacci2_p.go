//複数のfibonacci数列を逐次処理し，終了時間を計測する
//各fibonacciのnの値は10万としている

package main

import (
	"fmt"
	"time"
	//"math/big"
)

func main() {

	ch := make(chan int)
	t0 := time.Now()

	//ゴルーチン並列実行
	go fib(ch, 0)
	go fib(ch, 1)
	go fib(ch, 2)
	go fib(ch, 3)
	go fib(ch, 4)

	// ゴルーチン終了待ち
	<-ch
	<-ch
	<-ch
	<-ch
	<-ch

	t1 := time.Now()
	fmt.Println(t1.Sub(t0).String())
}

func fib(c chan int, n int) {
	f0 := 1
	f1 := 1
	tmp := 0
	for i := 1; i < 100000; i++ {
		tmp = f0 + f1
		f0, f1 = f1, tmp
	}
	fmt.Printf("Ch%d End\n", n)
	fmt.Println(f0)
	c <- 0 // 終了時に送信
}
