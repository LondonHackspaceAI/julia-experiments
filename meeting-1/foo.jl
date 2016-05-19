
function fact(n)
    if n == 0
	1
    else
	n * fact(n-1)
    end
end

c=0

@everywhere function _fib(n::Int, already_spawned::Bool)
    fib_(n::Int)= _fib(n, true)
    #global c=c+1
    if n < 2
	1
    else
        if (already_spawned)
            fib_(n-1) + fib_(n-2)
        else
            a= @spawn fib_(n-1)
            b= @spawn fib_(n-2)
            fetch(a) + fetch(b)
        end
    end
end

fib(n)= _fib(n, false)

n = parse(Int,ARGS[1])
println(n)
println(fib(n))
print("c:")
println(c)

#println(@spawn fib(n))
