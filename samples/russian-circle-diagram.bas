Screen 12: Randomize Timer 'diagram.bas  Russian Circle Diagram
N = 12: s = 0: Dim d(N+5),r(N+1+5):
For i = 1 To N: d(i) = Int(Rnd * 90+9): s = s+d(i): Print d(i): Next: Print "SUM= "; s
For i = 2 To N: r(i) = r(i-1)+d(i) * 2 * 3.1416 / s: Next: r(N+1) = r(1)
 
For i = 2 To N+1: For j = 1 To 100: Circle (150,100),j,i,r(i-1),r(i)
    Circle (149,99),j,i,r(i-1),r(i): Circle (151,99),j,i,r(i-1),r(i)
_Delay .002: Next: Next
 
For j = 1 To 100: For i = 2 To N+1: Circle (350,100),j,i,r(i-1),r(i)
    Circle (349,100),j,i,r(i-1),r(i): Circle (351,99),j,i,r(i-1),r(i)
Next: _Delay .01: Next

_Delay 1: Cls 'Screen 12: Randomize Timer diagout.bas  Russian Circle Diagram
N = 16: s = 0 ': Dim d(N),r(N+1):
For i = 1 To N: d(i) = Int(Rnd * 90+9): s = s+d(i): Print d(i): Next: Print "SUM= "; s
For i = 2 To N: r(i) = r(i-1)+d(i) * 2 * 3.1416 / s: Next: r(N+1) = r(1)

For i = 2 To N+1 Step 2: For j = 1 To 100: Circle (150,100),j,i,r(i-1),r(i)
    Circle (149,99),j,i,r(i-1),r(i): Circle (151,99),j,i,r(i-1),r(i)
_Delay .002: Next: Next

For i = 3 To N+1 Step 2: For j = 100 To 1 Step -1: Circle (150,100),j,i,r(i-1),r(i)
    Circle (149,99),j,i,r(i-1),r(i): Circle (151,99),j,i,r(i-1),r(i)
_Delay .002: Next: Next

For j = 1 To 100: For i = 2 To N+1
    If (i Mod 2) = 0 Then Circle (350,100),j,i,r(i-1),r(i): Circle (349,99),j,i,r(i-1),r(i): Circle (351,99),j,i,r(i-1),r(i)
        If (i Mod 2) = 1 Then Circle (350,100),100-j,i,r(i-1),r(i): Circle (349,99),100-j,i,r(i-1),r(i): Circle (351,99),100-j,i,r(i-1),r(i)
Next: _Delay .01: Next: End