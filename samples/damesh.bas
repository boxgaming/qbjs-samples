Randomize Timer ' damesh.bas Danilin from Russia
Screen 12 ' 1! 2 3? 4 5! 6 7? 8 9!
n=8: u=256: Dim x(n,9),y(n,9)

For i=1 To n
    x(i,1)=Int(Rnd*u+3): y(i,1)=Int(Rnd*u+3)
    x(i,9)=Int(Rnd*u+3): y(i,9)=Int(Rnd*u+3)
Next

Data -5,1,9,-3,1,5,-2,1,3,-4,3,5,-7,5,9,-6,5,7,-8,7,9

For g=1 To 9 - 2: Read d,a,v
    For i=1 To n: x(i,-d)=(x(i,a) +x(i,v))/2: y(i,-d)=(y(i,a) +y(i,v))/2: Next
Next

For g=1 To 10: For k=1 To 9: _Delay .1: Cls
    For i=1 To n: For j=1 To n: Circle (x(i,k),y(i,k)),2: Next: Next

        For i=1 To n - 1: For j=i To n
            Line (x(i,k),y(i,k))-(x(j,k),y(j,k)),i
           'Line (x(i,k),y(i,k))-(x(i+1,k),y(i+1,k)),i
    Next: Next: Next

    For k=8 To 2 Step -1: _Delay .1: Cls

For p=1 To 9
    For i=1 To n: For j=1 To n: Circle (x(i,p),y(i,p)),2,i: Next: Next
Next
    For i=1 To n - 1: For j=i To n
       Line (x(i,k),y(i,k))-(x(j,k),y(j,k)),i
      'Line (x(i,k),y(i,k))-(x(i+1,k),y(i+1,k)),i
    Next: Next: Next
Next