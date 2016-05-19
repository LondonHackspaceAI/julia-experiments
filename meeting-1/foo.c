#include <assert.h>
#include <stdio.h>
#include <unistd.h>

typedef process_t pid_t;
// #define SPAWN(e) 
// or just:
process_t spawn ()

int64_t _fib (int64_t n, int level) {
    if (n < 2) {
	return 1;
    } else {
	if (level<6) {
	    process_t a= spawn(fib_, n-1);
	    int64_t b= fib_(n-2);
	    return FETCH(a) + b;
	} else {
	    return fib(n-1) + fib(n-2);
	}
    }
}

