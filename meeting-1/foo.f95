subroutine fib(n,res)
  integer :: n,res,a,b
  call fib(n-1, a)
  call fib(n-2, b)
  res=a+b
end subroutine fib

program foo
integer :: a,aa
a = 30
call fib(a,aa)
print *, aa
end program foo
