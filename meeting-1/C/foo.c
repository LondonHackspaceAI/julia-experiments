#include <assert.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
/* #include <sys/stat.h> */
/* #include <fcntl.h> */
#include <sys/wait.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>

struct process {
    pid_t pid;
    int rd;
};

typedef struct process *process_t;

union buf_int64 {
    char buf[8];
    int64_t val;
};

#define DIE(msg, ...) {  fprintf(stderr, msg "\n", __VA_ARGS__); _exit(1); }
/* exit or _exit? in children, _exit ? */

int64_t fetch_int64 (process_t p) {
    int status;
    pid_t pid= waitpid(p->pid, &status, 0);
    if (pid<0) {
	DIE("fetch_int64: waitpid: %s", strerror(errno));
    } else {
	if (status != 0) {
	    DIE("fetch_int64: process with pid %i exited with status %i",
		p->pid, status);
	} else {
	    assert(pid == p->pid);
	    union buf_int64 input;
	    ssize_t nread= read(p->rd, input.buf, 8);
	    if (nread<0) {
		DIE("fetch_int64: reading from process with pid %i: %s",
		    p->pid, strerror(errno));
	    } else {
		if (nread!=8) {
		    DIE("fetch_int64: reading from process with pid %i: "
			"expected 8 bytes, got %ld",
			p->pid, nread);
		} else {
		    return input.val;
		}
	    }
	}
    }
}

#define SPAWN_int64(var, expr)						\
    struct process var;							\
    {									\
	int rw[2];							\
	int res= pipe(rw);						\
	if (res<0) {							\
	    DIE("SPAWN: pipe: %s", strerror(errno));			\
	} else {							\
	    var.pid= fork();						\
	    if (var.pid < 0) {						\
		DIE("SPAWN: could not fork: %s", strerror(errno));	\
	    } else {							\
		if (var.pid) {						\
		    var.rd= rw[0];					\
		    assert(close(rw[1])==0);				\
		} else {						\
		    assert(close(rw[0])==0);				\
		    union buf_int64 output;				\
		    output.val= (expr);					\
		    res= write(rw[1], output.buf, 8);			\
		    assert(res==8);	/* getting tired */		\
		    assert(close(rw[1])==0);				\
		    _exit(0);						\
		}							\
	    }								\
	}								\
    }


int64_t single_fib (int64_t n) {
    if (n < 2) {
	return 1;
    } else {
	return single_fib(n-1) + single_fib(n-2);
    }
}

int64_t _fib (int64_t n, int level) {
#define fib_(n) _fib(n, level+1)
    if (level<11) {
        SPAWN_int64(a, fib_(n-1));
        int64_t b= fib_(n-2);
        return fetch_int64(&a) + b;
    } else {
        return single_fib (n);
    }
}

int64_t fib (int64_t n) {
    return _fib(n, 0);
}

int main (int argc, char**argv) {
    assert(argc==2);
    char*p;
    long int n= strtol(argv[1], &p, 10);
    assert((p-argv[1]) == strlen(argv[1]));
    printf("n=%ld\n", n);
    printf("fib(n)=%ld\n", fib(n));
    return 0;
}
