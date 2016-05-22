package main

import (
	"os"
	"strconv"
	"fmt"
)

func fib (n int) int {
	return fib(n-1) + fib(n-2)
}

func main () {
	n, err := strconv.Atoi(os.Args[1])
	fmt.Println("fib(", n, ") = ", fib(n))
}
