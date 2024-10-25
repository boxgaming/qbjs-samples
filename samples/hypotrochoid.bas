Import Gfx From "lib/graphics/2d.bas"
_Title "The Hypotrochoid Show" 'for QB64 B+ 2019-07-18
Const xmax = 700, ymax = 700
Screen _NewImage(xmax, ymax, 32)
Dim As _Unsigned Long c2
Dim xc, yc, r, st, n, m, a, xReturn, yreturn
c2~& = &HFFBB0000
xc = xmax / 2: yc = ymax / 2: r = yc * .5: st = 1 / (2 * _Pi * r)
n = 0: m = 3
While _KeyDown(27) = 0
    m = m + 1
    For n = 5 To 30 Step .05
        Cls
        For a = 0 To 2 * _Pi Step st
            xReturn = xc + r * (Cos(a) + Cos(n * a) / 3 + Sin(m * a) / 2)
            yreturn = yc + r * (Sin(a) + Sin(n * a) / 3 + Cos(m * a) / 2)
            Gfx.FillCircle xReturn, yReturn, 10, _RGB32(0, 200, 0, n)
            Gfx.FillCircle xReturn, yReturn, 4, c2~&
        Next
        Print "m = "; m; "  n = "; n
        _Display
        _limit 100
    Next
Wend
