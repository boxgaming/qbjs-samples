Import Gfx From "lib/graphics/2d.bas"

_Title "Easy Spiral" 'b+ 2022-04? from Easy Lang site very Interesting!  https://easylang.online
' this one inspired Johnno to post at RCBasic,  https://rcbasic.freeforums.net  , also an interesting site!
Screen _NewImage(700, 700, 32)

Dim tick, pi, s, c, h, x, y
pi = _Pi: s = 7
Do
    Cls
    For c = 1 To 3000 '1320
        h = c + tick
        x = Sin(6 * h / pi) + Sin(3 * h)
        h = c + tick * 2
        y = Cos(6 * h / pi) + Cos(3 * h)
        Gfx.FillCircle s * (20 * x + 50), s * (20 * y + 50), 2, &HFFFFFFFF
    Next
    _Display
    _Limit 60
    tick = tick + .001
Loop Until _KeyDown(27)
