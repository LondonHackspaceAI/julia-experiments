
function fact(n)
    if n == 0
	1
    else
	n * fact(n-1)
    end
end

c=0

@everywhere function _fib(n, is_firstcall)
    fib_(n)= _fib(n, false)
    #global c=c+1
    if n < 2
	1
    else
        if (!(is_firstcall))
            fib_(n-1) + fib_(n-2)
        else
            a= @spawn fib_(n-1)
            b= @spawn fib_(n-2)
            fetch(a) + fetch(b)
        end
    end
end

fib(n)= _fib(n, true)

n = parse(Int,ARGS[1])
println(n)
println(fib(n))
print("c:")
println(c)

#println(@spawn fib(n))
