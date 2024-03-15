package main

import (
	"fmt"
	"math"
	"math/rand"
	"sync"
	"time"
)

func numbers(sz int) (res chan float64) {
	res = make(chan float64)
	go func() {
		defer close(res)
		num := 0.0
		time.Sleep(time.Duration(rand.Intn(1000)) * time.Microsecond)
		for i := 0; i < sz; i++ {
			num += math.Sqrt(math.Abs(rand.Float64()))
		}
		num /= float64(sz)
		res <- num
		return
	}()
	return
}

func main() {
	var nGo int
	fmt.Print("Number of Go routines: ")
	fmt.Scanf("%d \n", &nGo)
	res := make([]chan float64, nGo)
	var wg sync.WaitGroup

	for i := 0; i < nGo; i++ {

		wg.Add(1)
		go func(idx int) {
			res[idx] = numbers(1000)
			defer wg.Done()
			fmt.Printf("Result from routine %d: %f\n", idx, <-res[idx])
		}(i)
	}
	wg.Wait()
}
