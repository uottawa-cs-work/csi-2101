package main

import (
	"fmt"
	"math/rand"
	"strconv"
	"time"
)

// Task 1
var i int

func makeCakeAndSend(cs chan string) {
	i = i + 1
	cakeName := "Strawberry Cake " + strconv.Itoa(i)
	fmt.Println("Making a cake and sending...", cakeName)
	cs <- cakeName
}

func receiveCakeAndPack(cs chan string) {
	s := <-cs
	fmt.Println("Packing recieved cake: ", s)
}

// Task 2
type course struct {
	NStudents int
	Professor string
	Avg       float64
}

// Task 3
type coordinate struct {
	xCoord int
	yCoord int
}

func playerOne(location coordinate, boxsize int) {
	playerLocation := coordinate{0, 0}
	numMoves := 0

	for playerLocation != location {
		playerLocationAddress := &playerLocation
		*playerLocationAddress = coordinate{rand.Intn(boxsize), rand.Intn(boxsize)}
		numMoves++
	}

	response := fmt.Sprintf("Player 1 found the treasure after %d moves", numMoves)
	fmt.Println(response)
}

func playerTwo(location coordinate, boxsize int) {
	playerLocation := coordinate{boxsize, boxsize}
	numMoves := 0

	for playerLocation != location {
		playerLocationAddress := &playerLocation
		*playerLocationAddress = coordinate{rand.Intn(boxsize), rand.Intn(boxsize)}
		numMoves++
	}

	response := fmt.Sprintf("Player 2 found the treasure after %d moves", numMoves)
	fmt.Println(response)
}

func main() {
	fmt.Println("------------- Task 1 -------------")
	cs := make(chan string)

	for i := 0; i < 3; i++ {
		go makeCakeAndSend(cs)
		go receiveCakeAndPack(cs)

		time.Sleep(1 * 1e9)
	}

	fmt.Println("\n------------- Task 2 -------------")

	m := make(map[string]course)

	course1 := course{NStudents: 186, Professor: "Lang", Avg: 79.5}
	course2 := course{NStudents: 211, Professor: "Moura", Avg: 81.0}

	m["CSI2101"] = course1
	m["CSI2120"] = course2

	for k, v := range m {
		fmt.Printf("Course Code: %s\n", k)
		fmt.Printf("Number of students: %d\n", v.NStudents)
		fmt.Printf("Professor: %s\n", v.Professor)
		fmt.Printf("Average: %f\n\n", v.Avg)
	}

	fmt.Println("------------- Task 3 -------------")

	boxSize := (rand.Intn(10-5) + 5)
	location := coordinate{rand.Intn(boxSize), rand.Intn(boxSize)}

	go playerOne(location, boxSize)
	time.Sleep(1 * 1e6)
	go playerTwo(location, boxSize)
	time.Sleep(1 * 1e6)
}
