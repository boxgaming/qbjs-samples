_Title "Gold Wave bplus 2018-03-13"
'translated from SmallBASIC: Goldwave by johnno copied and mod by bplus 2018-01-28
Import Gfx From "lib/graphics/2d.bas"
'QB64 version 2017 1106/82 (the day before they switched to version 1.2)
Const xmax = 600
Const ymax = 480
Screen _NewImage(xmax, ymax, 32)
Dim ccc As _Unsigned Long

While 1
    For t = 1 To 60 Step .1 '< changed
        Cls 'changed
        For y1 = 0 To 24
            For x1 = 0 To 24
                x = (12 * (24 - x1)) + (12 * y1)
                y = (-6 * (24 - x1)) + (6 * y1) + 300
                d = ((10 - x1) ^ 2 + (10 - y1) ^ 2) ^ .5
                h = 60 * Sin(x1 / 4 + t) + 65
                If t > 10 And t < 20 Then h = 60 * Sin(y1 / 4 + t) + 65
                If t > 20 And t < 30 Then h = 60 * Sin((x1 - y1) / 4 + t) + 65
                If t > 30 And t < 40 Then h = 30 * Sin(x1 / 2 + t) + 30 * Sin(y1 / 2 + t) + 65
                If t > 40 And t < 50 Then h = 60 * Sin((x1 + y1) / 4 + t) + 65
                If t > 50 And t < 60 Then h = 60 * Sin(d * .3 + t) + 65

                'TOP
                ccc = _RGB32(242 + .1 * h, 242 + .1 * h, h)
                Gfx.FillTriangle x, y - h, x + 10, y + 5 - h, x + 20, y - h, ccc
                Gfx.FillTriangle x, y - h, x + 10, y - 5 - h, x + 20, y - h, ccc
                'FRONT-LEFT
                ccc = _RGB(255, 80, 0)
                Gfx.FillTriangle x, y - h, x + 10, y + 5 - h, x + 10, y, ccc
                Gfx.FillTriangle x, y - h, x, y - 5, x + 10, y, ccc
                'FRONT-RIGHT
                ccc = _RGB32(255, 150, 0)
                Gfx.FillTriangle x + 10, y + 5 - h, x + 10, y, x + 20, y - 5, ccc
                Gfx.FillTriangle x + 10, y + 5 - h, x + 20, y - h, x + 20, y - 5, ccc

                If InKey$ = Chr$(27) Then End
            Next
        Next
        _Display
        _Limit 60
    Next
Wend

