recursive function fib(n) result(res)
  integer :: n,res,a,b
  if (n < 2) then
     res=1
  else
     a= fib(n-1)
     b= fib(n-2)
     res= a+b
  end if
end function fib

program foo
integer :: a,aa
a = 30
aa= fib(a)
print *, aa
end program foo
