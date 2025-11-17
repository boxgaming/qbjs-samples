'SinCosPlay4.bas
'Dav, Nov/2025
 
$If WEB Then
    Screen NewImage(ResizeWidth-5, ResizeHeight-5, 32)
$Else
    Screen _NewImage(_DesktopHeight, Int(_DesktopHeight * .75), 32)
$End If

Do
    Cls , _RGB(32, 32, 64)
    For i = 0 To 359 Step .1
        x = (_Width / 2) + i * Sin((t * Sin(t * 0.14)) * i * _Pi(2) / 360 + (t * 3))
        y = (_Height / 2) + i * Cos((t * Cos(t * 0.13)) * i * _Pi(2) / 360)
        r = 127 + 127 * Sin(i * _Pi / 45 + t * 4)
        clr& = _RGBA(r, r * 2, r * 3, 25)
        Line (x, y)-Step(6, 6), clr&, BF
    Next
    t = t + .01
    _Display
    _Limit 30
Loop Until _KeyHit
