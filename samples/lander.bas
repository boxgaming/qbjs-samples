Screen _NewImage(800, 640, 32) ' b+ Lander 30 LOC (double parking cheat) 2020-11-13
Dim gi&, kh&, h, dx, x, y
gi& = _NewImage(800, 640, 32)
ReDim g(-100 To 200)
Do
    Cls: _KeyClear
    h = 30: dx = 1: x = 3: y = 2
    For i = -10 To 110
        If Rnd < .5 Then h = h + Int(Rnd * 3) - 1 Else h = h
        If h > 39 Then h = 39
        If h < 25 Then h = 25
        Line (i * 8, h * 16)-(i * 8 + 8, _Height), _RGB32(128), BF
        g(i) = h
        _PutImage , 0, gi&
    Next
    While 1
        _PutImage , gi&, 0
        Circle (x * 8 + 4, y * 16 + 8), 4, &HFF00FFFF
        Circle (x * 8, y * 16 + 16), 4, &HFFFFFF00, 0, _Pi
        Circle (x * 8 + 8, y * 16 + 16), 4, &HFFFFFF00, 0, _Pi
        If y >= g(x - 1) Or y >= g(x + 1) Or y >= g(x) Or y >= 40 Or x < -5 Or x > 105 Then _PrintString (46 * 8, 2 * 16), "Crash": Exit While
        If y = g(x - 1) - 1 And y = g(x + 1) - 1 Then _PrintString (46 * 8, 2 * 16), "Landed": Exit While
        kh& = _KeyHit
        If kh& = 19200 Or kh& = 97 Then dx = dx - 1
        If kh& = 19712 Or kh& = 100 Then dx = dx + 1
        If kh& = 18432 Or kh& = 119 Then y = y - 5
        x = x + dx: y = y + 1
        _Limit 2
    Wend
    _Delay 2
Loop
' 2020-11-15 fix off-sides x, add alternate keys: a=left d=right w=up  so now arrow keys or WAD system works