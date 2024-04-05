package main

import (
	"fmt"
	"sync"
)

var (
	currFile  string
	isPlaying bool
)

func musicPlayer(commands chan string, data chan string) {
	var command string
	end := false

	for !end {
		command = <-commands
		switch command {
		case "open":
			// Open file
			<-data
			commands <- "done"

		case "play":
			// Play file
			isPlaying = true
			<-data
			commands <- "done"

		case "pause":
			// Pauses
			isPlaying = false
			commands <- "done"

		case "continue":
			// Continue
			isPlaying = true
			commands <- "done"

		case "exit":
			end = true
		}
	}

	close(data)
}

func controller(commands chan string, data chan string) {
	var input1 string
	var input2 string
	end := false

	for !end {
		fmt.Println("Enter Command:")
		fmt.Scanf("%s %s", &input1, &input2)

		switch input1 {
		case "open":
			fmt.Println("The current working directory is changed to " + input2)
			commands <- "open"
			data <- input2
			<-commands

		case "play":
			fmt.Printf("Playing %s ...\n", input2)
			currFile = input2
			commands <- "play"
			data <- input2
			<-commands

		case "pause":
			if !(currFile == "") && isPlaying {
				fmt.Printf("Pausing %s\n", currFile)
				commands <- "pause"
				<-commands
			} else {
				fmt.Println("Nothing playing right now")
			}

		case "continue":
			if !(currFile == "") {
				if !isPlaying {
					fmt.Printf("Continuing %s\n", currFile)
					commands <- "continue"
					<-commands
				} else {
					fmt.Println("Music already playing")
				}
			} else {
				fmt.Println("Select a file to play")
			}

		case "exit":
			fmt.Println("Thanks for listening")
			commands <- "exit"
			end = true
		}
	}

	close(commands)
}

func main() {
	commandChannel := make(chan string)
	dataChannel := make(chan string)

	var wg sync.WaitGroup

	wg.Add(2)
	go func() {
		controller(commandChannel, dataChannel)
		wg.Done()
	}()

	go func() {
		go musicPlayer(commandChannel, dataChannel)
		wg.Done()
	}()

	wg.Wait()
}
