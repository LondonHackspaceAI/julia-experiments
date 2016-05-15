import Base.+

function +(x::Int,y::AbstractString)
    x * parse(Int,y)
end

# println(+(10,"11"));
# works as well as:

println(10+"11");

type Foo
    a
    b
    Foo(m,n) = new(m,n)
end

z= Foo(1,2)

println(z)

println(z.a)

Foo(x) = Foo(x,x)
println(Foo(10))

