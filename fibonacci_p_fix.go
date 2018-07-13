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
    Ch chan int64
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

func (g *MyWaitGroup) Wait(cs chan int64) {
    g.Wg.Wait()
    close(g.Ch)
    cs <- g.MaxCount
}

func (g *MyWaitGroup) fibonacci(n int64) {
    switch {
    case n == 0:
        break
    case n == 1:
        g.Ch <- 1
    case n < 0:
        fmt.Println("Parameter should be positive integers")
        os.Exit(1)
    default: 
        g.Add()
        go func() {
            defer g.Done()
            g.fibonacci(n-2)
        }()
     
        g.Add()
        go func() {
            defer g.Done()
            g.fibonacci(n-1)
        }()
    }
}

func printResult(cs <-chan int64, done chan<- bool){
    var sum int64
    for s := range cs {
        sum += s
    }
    //fmt.Println(sum)
 
    done <- true
}

func printMax(cs <-chan int64, done chan<- bool) {
    //fmt.Printf("Max:%d\n", <-cs)
    done <- true
}

func main() {
    g := &MyWaitGroup{ Count:0,MaxCount:0,Ch:make(chan int64,100) }
    var i int64
    i, _ = strconv.ParseInt(os.Args[1],10, 64)
 
    start:= time.Now()  //測定開始

    g.Add()
    go func() {
        defer func(){
            g.Done()
        }()
        g.fibonacci(i)
    }()
 
    done1 := make(chan int64,100)
    go g.Wait(done1)
 
    done2 := make(chan bool,100)
    go printResult(g.Ch, done2)
    <-done2
 
    done3 := make(chan bool,100)
    go printMax(done1, done3)
    <-done3
 
    end := time.Now()   //測定完了
    exeSpeed := end.Sub(start)
    fmt.Printf("time = %.10f sec \n",exeSpeed.Seconds())
}
