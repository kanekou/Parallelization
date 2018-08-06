//並列可能なCPUコア数の取得

package main

import (
        "fmt"
        "runtime"
)


func main() {
	cpus := runtime.NumCPU()
	fmt.Println(cpus)
}
