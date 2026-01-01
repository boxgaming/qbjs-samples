Dim cw, ch, n, t, h, r, g, b, x, y, a, rad, r2, y2, x2

Screen _NewImage(800, 600, 32)

cw = _Width / 2: ch = _Height / 2

Do
    Cls

    For n = 1 To 4
        For t = 0 To 7.3 Step .01
            h = (Timer / 50 + t * 20) Mod 180
            r = 127 + 127 * Sin(h * _Pi / 180)
            g = 127 + 127 * Cos(h * _Pi / 180)
            b = 255 * Abs(Sin(t))
            x = cw + Cos(t + a * n) * (cw / 2 + 50 * Sin(t * 3 * n))
            y = ch + Sin(t + a + n) * (ch / 2 + 50 * Cos(t * 3 + n))
            rad = 10 + Sin(t * 4) * n
            If rad < 1 Then rad = 1
            r2 = rad * rad
            For y2 = -rad To rad
                x2 = Abs(Sqr(r2 - y2 * y2))
                Line (x - x2, y + y2)-(x + x2, y + y2), _RGBA(r, g, b, h), BF
            Next
        Next
    Next
    a = a + .02
    _Display
    _Limit 30
Loop While InKey$ <> Chr$(27)
