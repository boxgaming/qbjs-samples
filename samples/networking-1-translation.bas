'Option _Explicit
_Title "Networking 1 translation" 'by B+ started 2018-11-13 mod 2022-05-29
Randomize Timer
Const xmax = 800, ymax = 600, nP = 500, rD = 35
Screen _NewImage(xmax, ymax, 32)
_ScreenMove 200, 60
Dim x(nP), y(nP), dx(nP), dy(nP), c(nP) As _Unsigned Long
Dim As Long i, j, k
'initialize points
For i = 0 To nP
    x(i) = Rnd * xmax: y(i) = Rnd * ymax
    If Rnd < .5 Then dx(i) = -3 * Rnd - .5 Else dx(i) = 3 * Rnd + .5
    If Rnd < .5 Then dy(i) = -3 * Rnd - .5 Else dy(i) = 3 * Rnd + .5
    c(i) = _RGB32(Rnd * 200 + 55, Rnd * 200 + 55, Rnd * 200 + 55)
Next
While _KeyDown(27) = 0
    Cls
    For i = 0 To nP 'big show of points and triangle
        Color c(i)
        Line (x(i), y(i))-Step(1, 1), c(i), BF
        For j = i + 1 To nP 'search for triangle points within 100 pixels
            If distance(x(i), y(i), x(j), y(j)) < rD Then
                For k = j + 1 To nP
                    If distance(x(k), y(k), x(j), y(j)) < rD Then
                        If distance(x(k), y(k), x(i), y(i)) < rD Then
                            'draw 3 lines of triangle
                            Line (x(i), y(i))-(x(j), y(j)), c(i)
                            Line (x(k), y(k))-(x(j), y(j)), c(i)
                            Line (x(i), y(i))-(x(k), y(k)), c(i)
                            c(j) = c(i): c(k) = c(i)
                        End If
                    End If
                Next
            End If
        Next
        'update points
        x(i) = x(i) + dx(i)
        y(i) = y(i) + dy(i)
        If x(i) < 0 Then x(i) = xmax + x(i)
        If x(i) > xmax Then x(i) = x(i) - xmax
        If y(i) < 0 Then y(i) = 0: dy(i) = dy(i) * -1
        If y(i) > ymax Then y(i) = ymax: dy(i) = dy(i) * -1
    Next
    _Display
    _Limit 200
Wend

Function distance (x1, y1, x2, y2)
    distance = ((x1 - x2) ^ 2 + (y1 - y2) ^ 2) ^ .5
End Function
