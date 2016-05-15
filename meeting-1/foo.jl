
function fact(n)
    if n == 0
	1
    else
	n * fact(n-1)
    end
end

function fib(n)
    if n < 2
	1
    else
	fib(n-1) + fib(n-2)
    end
end

n = parse(Int,ARGS[1])
println(n)
println(fib(n))

#println(@spawn fib(n))
