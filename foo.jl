
function fact(n)
	if n == 0
		1
	else
		n * fact(n-1)
	end
end

println(fact(parse(Int,ARGS[1])))



