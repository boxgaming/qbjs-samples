Randomize Timer: ' xonixdig.bas Danilin Russia 
b = Int(Rnd*10+15): a = Int(Rnd*10+15): ' _Font 17 
N = Int(Rnd*3+5): Dim dx(N), dy(N), y(N), x(N), c(N) 

For i = 1 To N
    dx(i) = 1+Int(Rnd-.5)*2
    dy(i) = 1+Int(Rnd-.5)*2
    y(i) = Int(Rnd*(b-3)+2): x(i) = Int(Rnd*(a-3)+2)
    c(i) = Int(Rnd*5+1)
Next

For i = 1 To a: Print "#";: Next: Print ' area
For j = 1 To b-2: Print "#";: For k = 1 To a-2: Print ".";: Next: Print "#": Next
For i = 1 To a: Print "#";: Next

For q = 1 To 1000: _Delay .08
    For i = 1 To N: Locate y(i), x(i): Print "  "

        If y(i)+dy(i) < 2 Or y(i)+dy(i) > b-1 Then dy(i) = -dy(i)
        y(i) = y(i)+dy(i)
        If x(i)+dx(i) < 2 Or x(i)+dx(i) > a-3 Then dx(i) = -dx(i)
        x(i) = x(i)+dx(i)

        For k = 1 To N-1: For m = k+1 To N
            If y(k) = y(m) And x(k) = x(m) Then c(k) = Int(Rnd*5+1): c(m) = Int(Rnd*5+1)
        Next: Next
        Locate y(i), x(i): Color c(i): Print c(i)
Next: Next
