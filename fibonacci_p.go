//参考URL:https://qiita.com/hiroykam/items/fdbb68ea21e5c67b8225

package main

import (
    "fmt"
    "os"
    "sync"
    "strconv"
    "time"
)

type MyWaitGroup struct {
    Wg sync.WaitGroup
    Count int64
    MaxCount int64
}

func (g *MyWaitGroup) Add() {
    g.Wg.Add(1)
    g.Count++
    if g.MaxCount < g.Count { g.MaxCount = g.Count }
}

func (g *MyWaitGroup) Done() {
    g.Wg.Done()
    g.Count--
}

func (g *MyWaitGroup) Wait() {
    g.Wg.Wait()
    fmt.Printf("Max:%d\n", g.MaxCount)
}

func (g *MyWaitGroup) fibonacci(n int64) int64 {
    switch {
    case n == 0:
        return 0
    case n == 1:
        return 1
    case n < 0:
        fmt.Println("Parameter should be positive integers")
        os.Exit(1)
    }
 
    ch1 := make(chan int64)
    g.Add()
    go func() {
        defer close(ch1)
        defer g.Done()
        ch1 <- g.fibonacci(n-2)
    }()
 
    ch2 := make(chan int64)
    g.Add()
    go func() {
        defer close(ch2)
        defer g.Done()
        ch2 <- g.fibonacci(n-1)
    }()
    return <-ch1 + <-ch2
}

func main() {
    start:= time.Now()  //測定開始
 
    g := &MyWaitGroup{ Count:0, MaxCount:0 }
    var i int64
    i, _ = strconv.ParseInt(os.Args[1],10, 64)
    ch := make(chan int64)
    g.Add()
    go func() {
        defer close(ch)
        defer g.Done()
        ch <- g.fibonacci(i)
    }()
 
    fmt.Println(<-ch)
    g.Wait()
 
    end := time.Now()   //測定完了
    exeSpeed := end.Sub(start)
    fmt.Printf("time = %.10f sec \n",exeSpeed.Seconds())
}
