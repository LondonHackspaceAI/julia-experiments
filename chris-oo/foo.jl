import Base.+

function +(x::Int,y::AbstractString)
    x * parse(Int,y)
end

# println(+(10,"11"));
# works as well as:

println(10+"11");

abstract Foo

type Foo1 <: Foo
    a::Integer
    b
    Foo1(m,n) = new(m,n)
end

baz(f::Foo)= bar(f) * bar(f)

bar(f::Foo)= f.a + f.b


type Foo2 <: Foo
    a::AbstractString
    b
    c
end


z= Foo1(1,2)

println(z)

println(z.a)

Foo1(x) = Foo1(x,x)
println(Foo1(10))

println(bar(z))
println(baz(z))

println(Foo2("foo2",20,false))

bsquare(f::Foo)= f.b * f.b

println(bsquare(Foo1(10)))
println(bsquare(Foo2("foo2",20,false)))

avalue(f::Foo)= f.a

println(avalue(Foo1(10)))
println(avalue(Foo2("foo2",20,false)))

cvalue(f::Foo)= f.c

# println(cvalue(Foo1(10)))  fails as expected
println(cvalue(Foo2("foo2",20,false)))

