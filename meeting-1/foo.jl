
function fact(n)
    if n == 0
	1
    else
	n * fact(n-1)
    end
end

c=0

@everywhere function fib(n)
    #global c=c+1
    if n < 2
	1
    else
        if (1==0)
            fib(n-1) + fib(n-2)
        else
            a= @spawn fib(n-1)
            b= @spawn fib(n-2)
            fetch(a) + fetch(b)
        end
    end
end

n = parse(Int,ARGS[1])
println(n)
println(fib(n))
print("c:")
println(c)

#println(@spawn fib(n))
