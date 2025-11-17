'SinCosPlay2.bas
'Dav, NOV/2025
 
$If WEB Then
    Screen NewImage(ResizeWidth-5, ResizeHeight-5, 32)
$Else
    Screen _NewImage(Int(_DesktopHeight * .75), Int(_DesktopHeight * .75), 32)
$End If

Do
    Cls
    For a = 0 To 360 Step .3
        rad = a / 180 * _Pi
        r1 = 100 + Sin(rad * 3 + t) * 80 + Sin(rad * 5 + t * 1.2) * 50 + Sin(t * .5) * 125
        r2 = 50 + Cos(rad * 4 + t * 1.5) * 40 + Cos(rad * 6 + t * 1.3) * 30 + Sin(t * .5) * 75
        r3 = 70 + Sin(rad * 2 + t * .8) * 60 + Sin(rad * 7 + t * 1.4) * 40 + Sin(t * .5) * 50
        For s = 0 To 8
            sa = rad + s * (_Pi / 4.5)
            x1 = _Width / 2 + Cos(sa) * r1
            y1 = _Height / 2 + Sin(sa) * r1
            x2 = _Width / 2 + Cos(sa + .17) * r2
            y2 = _Height / 2 + Sin(sa + .17) * r2
            x3 = _Width / 2 + Cos(sa + .35) * r3
            y3 = _Height / 2 + Sin(sa + .35) * r3
            r = 128 + 127 * Sin(t + s)
            g = 128 + 127 * Sin(t + s + _Pi / 4)
            b = 128 + 127 * Sin(t + s + _Pi / 2)
            Line (x1, y1)-(x2, y2), _RGBA(r, g, b, 25)
            Line (x1, y1)-(x3, y3), _RGBA(r, g, b, 25)
        Next
    Next
    t = t + .1
    _Display
    _Limit 15
Loop
