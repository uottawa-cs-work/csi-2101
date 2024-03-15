package main

import (
	"fmt"
	"time"
)

var (
	Count      int = 0
	nFunctions int = 2
	sem            = make(chan bool, 1)
)

func main() {
	ch := make(chan int)
	fmt.Printf("Count = %d\n", Count)
	go increment(ch, 1000)
	go decrement(ch, 1000)
	for i := 0; i < nFunctions*1000; i++ {
		fmt.Printf("Waiting %d\n", Count)
		<-ch
	}
	fmt.Printf("Count = %d\n", Count)
}

func increment(ch chan int, nSteps int) {
	sem <- true
	defer func() { <-sem }()

	for i := 0; i < nSteps; i++ {
		cnt := Count
		time.Sleep(3 * time.Millisecond)
		Count = cnt + 1
		ch <- 1
	}
	return
}

func decrement(ch chan int, nSteps int) {
	sem <- true
	defer func() { <-sem }()

	for i := 0; i < nSteps; i++ {
		cnt := Count
		time.Sleep(2 * time.Millisecond)
		Count = cnt - 1
		ch <- 1
	}
	return
}
