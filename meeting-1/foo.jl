c=0

@everywhere function _fib(n::Int, level::Int)
    fib_(n::Int)= _fib(n, level+1)
    #global c=c+1
    if n < 2
	1
    else
        if (level<6) # 2**6==64 cores
            a= @spawn fib_(n-1)
            b= fib_(n-2)
            fetch(a) + b
        else
            fib_(n-1) + fib_(n-2)
        end
    end
end

function simple_fib(n::Int)
    #global c=c+1
    if n < 2
	1
    else
        simple_fib(n-1) + simple_fib(n-2)
    end
end

#fib(n)= _fib(n, 0)
fib(n)= simple_fib(n)

n = parse(Int,ARGS[1])
println(n)
println(fib(n))
print("c:")
println(c)

#println(@spawn fib(n))
