program foo
integer :: a
integer :: aa
! a = 30
! aa= fib(a)
! print *, aa
print *, fib(30)
end program foo

recursive function fib(n) result(res)
  integer :: n
  integer :: res
  if (n < 2) then
     res= 1
  else
     res= fib(n-1) + fib(n-2)
  end if
end function fib
