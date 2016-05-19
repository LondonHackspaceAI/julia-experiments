
function fact(n)
    if n == 0
	1
    else
	n * fact(n-1)
    end
end

c=0

@everywhere function _fib(n::Int, level::Int)
    fib_(n::Int)= _fib(n, level+1)
    #global c=c+1
    if n < 2
	1
    else
        if (level<6) # 2**6==64 cores
            fib_(n-1) + fib_(n-2)
        else
            a= @spawn fib_(n-1)
            b= @spawn fib_(n-2)
            fetch(a) + fetch(b)
        end
    end
end

fib(n)= _fib(n, 0)

n = parse(Int,ARGS[1])
println(n)
println(fib(n))
print("c:")
println(c)

#println(@spawn fib(n))
