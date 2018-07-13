//https://qiita.com/hiroykam/items/fdbb68ea21e5c67b8225

package main

import (
    "fmt"
    "os"
    "time"
    "strconv"
)

func fibonacci(n int64) int64 {
    switch {
    case n == 0:
        return 0
    case n == 1:
        return 1
    case n < 0:
        fmt.Println("Parameter should be positive integers")
        os.Exit(1)
    }
    return fibonacci(n - 2) + fibonacci(n - 1)
}

func main() {
    start:= time.Now()   //測定開始

    var i int64
    i, _ = strconv.ParseInt(os.Args[1],10, 64)
    //fmt.Println(fibonacci(i))
    fibonacci(i)

    end := time.Now()      //測定終了          
    exeSpeed := end.Sub(start)
    fmt.Printf("time = %.10f sec \n",exeSpeed.Seconds())
}
