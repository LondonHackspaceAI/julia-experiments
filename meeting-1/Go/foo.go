package main

import (
	"os"
	"strconv"
	"log"
	"fmt"
)

func fib (n uint) int {
	return fib(n-1) + fib(n-2)
}

func main () {
	n, err := strconv.Atoi(os.Args[1])
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println("fib(", n, ") = ", fib(uint(n)))
}
