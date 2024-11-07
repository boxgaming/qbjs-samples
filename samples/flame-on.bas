_Title "Flame on by bplus 2017-11-23"
' flame on.bas SmallBASIC 0.12.9 (B+=MGA) 2017-11-22

Const xmax = 800
Const ymax = 550

Screen _NewImage(xmax, ymax, 32)
'_ScreenMove 360, 60 'adjust as needed _MIDDLE needs a delay .5 or more for me

Dim xxmax, yymax, xstep, ystep, i, fr, x, r, y

xxmax = 200: yymax = 75 'pixels too slow
xstep = xmax / xxmax: ystep = ymax / yymax
Dim p&(300) 'pallette
For i = 1 To 100
    fr = Round(240 * i / 100 + 15)
    p&(i) = _RGB(fr, 0, 0)
    p&(i + 100) = _RGB(255, fr, 0)
    p&(i + 200) = _RGB(255, 255, fr)
Next
Dim f(xxmax, yymax + 2) 'fire array and seed
For x = 0 To xxmax
    f(x, yymax + 1) = Round(Int(Rnd * 2) * 300)
    f(x, yymax + 2) = 300
Next
'Color , &HFF4444DD
While 1 'main fire
    Cls
    For x = 1 To xxmax - 1 'shift fire seed a bit
        r = Rnd
        If r < .15 Then
            f(x, yymax + 1) = f(x - 1, yymax + 1)
        ElseIf r < .3 Then
            f(x, yymax + 1) = f(x + 1, yymax + 1)
        ElseIf r < .35 Then
            f(x, yymax + 1) = Int(Rnd * 2) * 300
        End If
    Next
    For y = 0 To yymax 'fire based literally on 4 pixels below it like cellular automata
        For x = 1 To xxmax - 1
            f(x, y) = Round(max((f(x - 1, y + 1) + f(x, y + 1) + f(x + 1, y + 1) + f(x - 1, y + 2)) / 4 - 5, 0))
            Line (x * xstep, y * ystep)-Step(xstep, ystep), p&(f(x, y)), BF
        Next
    Next
    _Limit 60
    _Display
Wend
Function max (a, b)
    If a > b Then max = a Else max = b
End Function
