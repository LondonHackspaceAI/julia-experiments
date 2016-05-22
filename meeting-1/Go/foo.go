package main

import (
	"os"
	"fmt"
)

func fib (n int) {
	return (fib(n-1) + fib(n-2))
}

func main () {
	fmt.Println("My first argument is", os.Args[1])
}
