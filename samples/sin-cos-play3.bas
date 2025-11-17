'SinCosPlay3.bas
'Dav, NOV/2025

$If WEB Then
    Screen NewImage(350, 350)
$Else
    Screen _NewImage(Int(_DesktopHeight * .75), Int(_DesktopHeight * .75), 32)
$End If

Do
    Cls
 
    'background plasma
    For y = 0 To _Height - 1 Step 2
        For x = 0 To _Width - 1 Step 2
            v = Sin(x * .15 + t * .5) + Sin(y * .2 + t * .7) + Sin((x + y) * .1 + t)
            r1 = 128 + 127 * Sin(v / 2 * _Pi + t * .3)
            g1 = 128 + 127 * Sin(v / 3 * _Pi + t * .5 + _Pi / 4)
            b1 = 128 + 127 * Sin(v / 4 * _Pi + t * .7 + _Pi / 2)
            Line (x, y)-Step(3, 3), _RGBA(r1, g1, b1, 150)
        Next
    Next
 
    'spirals on top
    For s = 0 To 15
        For r = 0 To _Width / 2
            a = r * .1 + (s * (_Pi * 2 / 16) + t * .5) + Sin(r * .05 + t) * 2
            x = _Width / 2 + Cos(a) * r
            y = _Height / 2 + Sin(a) * r
            r1 = 128 + 127 * Sin(r * .1 + t + s)
            g1 = 128 + 127 * Sin(r * .1 + t + s + _Pi / 3)
            b1 = 128 + 127 * Sin(r * .1 + t + s + _Pi * 2 / 3)
            Line (x + Cos(a) * 3, y + Sin(a) * 3)-Step(2, 2), _RGBA(r1, g1, b1, 255), BF
        Next
    Next
 
    t = t + .1
 
    _Display
    _Limit 30
Loop
