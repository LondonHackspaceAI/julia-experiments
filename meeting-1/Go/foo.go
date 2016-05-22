package main

import (
	"os"
	"fmt"
)

func fib (n int) int {
	return fib(n-1) + fib(n-2)
}

func main () {
	n := int (os.Args[1])
	fmt.Println("fib(", n, ") = ", fib(n))
}
