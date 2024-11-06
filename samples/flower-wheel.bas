_Title "Flower Wheel" ' b+ 2022-04?
Screen 12
Dim o
Do
    Cls
    o = o + _Pi / 180
    drawc _Width / 2, _Height / 2, _Width / 5, .25, 4, o
    _Display
    _Limit 30
Loop

Sub drawc (x, y, r, a, n, o)
    Dim t, xx, yy
    If n > 0 Then
        For t = 0 To _Pi(2) Step _Pi(1 / 3)
            xx = x + r * Cos(t + o)
            yy = y + r * Sin(t + o)
            Circle (xx, yy), r
            drawc xx, yy, a * r, a, n - 1, -o - n * _Pi / 180
        Next
    End If
End Sub