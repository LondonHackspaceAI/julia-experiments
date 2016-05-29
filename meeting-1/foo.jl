@everywhere function single_fib(n::Int)
    _fib=single_fib
    n < 2 ? 1 : _fib(n-1) + _fib(n-2)
end

@everywhere function _parallel_fib(n::Int, level::Int)
    if n < 2
	1
    else
        # 2**6==64 already, but not all of them run long enough.
        if (level<11)
            a= @spawn _parallel_fib(n-1,level+1)
            b= _parallel_fib(n-2,level+1)
            fetch(a) + b
        else
            #_fib(n-1) + _fib(n-2)
            _parallel_fib(n-1,level+1) + _parallel_fib(n-2,level+1)
            #single_fib(n)
        end
    end
end

parallel_fib(n)= _parallel_fib(n, 0)

fib=parallel_fib

n = parse(Int,ARGS[1])
println(n)
println(fib(n))
