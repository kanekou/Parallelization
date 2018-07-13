//複数のfibonacci数列を逐次処理し，終了時間を計測する
//各fibonacciのnの値は10万としている

package main

import (
	"fmt"
	"time"
)

func main() {

	t0 := time.Now()

	fib(0)
	fib(1)
	fib(2)
	fib(3)
	fib(4)

	t1 := time.Now()
	fmt.Println(t1.Sub(t0).String())
}

func fib(chNum int) {
	f0 := 1
	f1 := 1
	tmp := 0
	for i := 1; i < 100000; i++ {
		tmp = f0 + f1
		f0, f1 = f1, tmp
	}
	fmt.Printf("Ch%d End\n", chNum)
	fmt.Println(f0)
}
