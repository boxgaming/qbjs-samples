_Title "Flipping Hex Maze" ' b+ 2024-11-01
Screen _NewImage(801, 590, 32): _ScreenMove 240, 60
Type BoardType
    As Single x, y, flipped, flipping, a
End Type
Dim Shared ubX, ubY
ubX = 18: ubY = 16
Dim Shared b(ubX, ubY) As BoardType
Dim Shared cellR, xspacing!, yspacing!
cellR = 25
xspacing! = 2 * cellR * Cos(_D2R(30)): yspacing! = cellR * (1 + Sin(_D2R(30)))
Dim xoffset!
Color &HFF000000, &HFFAAAAFF
Do
    m = (m + 1) Mod ubX
    Cls
    For y = 0 To ubY
        If y Mod 2 = 0 Then xoffset! = .5 * xspacing! Else xoffset! = 0
        For x = 0 To ubX
            b(x, y).x = x * xspacing! + xoffset! + .5 * xspacing! - 20
            b(x, y).y = y * yspacing! + .5 * yspacing! - 20
            If Rnd < .002 Then b(x, y).flipping = 1
            showCell x, y
        Next
    Next
    _Display
    _Limit 60
Loop

Sub showCell (c, r)
    If b(c, r).flipping Then b(c, r).a = b(c, r).a + _Pi(1 / 90)
    If b(c, r).a >= _Pi(1 / 3) Then
        b(c, r).flipping = 0: b(c, r).a = 0
        If b(c, r).flipped Then b(c, r).flipped = 0 Else b(c, r).flipped = 1
    End If
    If b(c, r).flipped Then
        For a = _Pi(1 / 6) To _Pi(2) Step _Pi(2 / 3)
            Line (b(c, r).x, b(c, r).y)-Step(cellR * Cos(a + b(c, r).a), cellR * Sin(a + b(c, r).a))
        Next
    Else
        For a = _Pi(.5) To _Pi(2) Step _Pi(2 / 3)
            Line (b(c, r).x, b(c, r).y)-Step(cellR * Cos(a + b(c, r).a), cellR * Sin(a + b(c, r).a))
        Next
    End If
End Sub