'SinCosPlay.bas
'By Dav for QB64PE, NOV/2025

$If WEB Then
    Screen NewImage(ResizeWidth-5, ResizeHeight-5, 32)
$Else
    Screen _NewImage(Int(_DesktopHeight * .75), Int(_DesktopHeight * .75), 32)
$End If

Do
    Cls
    For i = 0 To 360 Step .03
        r = i / 180 * _Pi
        x = (_Width / 2) + Cos(r * 3 + t) * ((_Width / 4) + Sin(r * 4 + t * 3) * (_Width / 8))
        y = (_Height / 2) + Sin(r * 2 + t) * ((_Height / 4) + Cos(r * 3 + t * 4) * (_Height / 8))
        Circle (x, y), (_Height / 50) + i Mod (_Height / 50), _RGBA(i / 2, i / 3, 255, 25)
    Next
    t = t + .1
    _Display
    _Limit 15
Loop
