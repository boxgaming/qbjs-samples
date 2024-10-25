Dim Shared As Single sw, sh
sw = 800
sh = 600
Dim Shared pi As Double
pi = 4 * Atn(1)

Screen _NewImage(sw, sh, 32)
   
Dim As Long n, r, mx, my, mb, omx, omy
n = 0
ReDim x(n) As Long
redim y(n) As Long

Dim As Double bx, by, t, bin

r = 5
Do
    If _Resize Then
        Dim tmp 
        tmp = _CopyImage(0)
        Screen _NewImage(_ResizeWidth - 5, _ResizeHeight - 5)
        _PutImage (0, 0), tmp
        
    End If


    mx = _MouseX
    my = _MouseY
    mb = -_MouseButton(1)


    If mb = 1 Then
        n = 1
        ReDim _Preserve As Long x(n)
        ReDim _Preserve As Long y(n)

        mx = _MouseX
        my = _MouseY
    
        x(0) = mx - _Width / 2
        y(0) = _Height / 2 - my

        PSet (mx, my)
        Do While mb = 1

            mx = _MouseX
            my = _MouseY
            mb = -_MouseButton(1)


            Line -(mx, my), _RGB(30, 30, 30)

            If (mx - omx) ^ 2 + (my - omy) ^ 2 > r ^ 2 Then
                circlef mx, my, 3, _RGB(30, 30, 30)
                omx = mx
                omy = my

                x(n) = mx - _Width / 2
                y(n) = _Height / 2 - my
                n = n + 1
                ReDim _Preserve As Long x(n)
                ReDim _Preserve As Long y(n)
            End If

           
            _Limit 50
        Loop

        'close the contour
        'x(n) = x(0)
        'y(n) = y(0)
        'n = n + 1
        'ReDim _Preserve x(n)
        'ReDim _Preserve y(n)

        'redraw spline
        'pset (sw/2 + x(0), sh/2 - y(0))
        'for i=0 to n
        'line -(sw/2 + x(i), sh/2 - y(i)), _rgb(255,0,0)
        'circlef sw/2 + x(i), sh/2 - y(i), 3, _rgb(255,0,0)
        'next

        PSet (_Width / 2 + x(0), _Height / 2 - y(0))
        For t = 0 To 1 Step 0.001
            bx = 0
            by = 0

            For i = 0 To n
                bin = 1
                For j = 1 To i
                    bin = bin * (n - j) / j
                Next

                bx = bx + bin * ((1 - t) ^ (n - 1 - i)) * (t ^ i) * x(i)
                by = by + bin * ((1 - t) ^ (n - 1 - i)) * (t ^ i) * y(i)
            Next

            Line -(_Width / 2 + bx, _Height / 2 - by), _RGB(255, 0, 0)
        Next
    End If

    _Limit 50
Loop 'until _keyhit = 27


Sub circlef (x As Long, y As Long, r As Long, c As Long)
    Dim As Long x0, y0, e
    x0 = r
    y0 = 0
    e = -r
 
    Do While y0 < x0
        If e <= 0 Then
            y0 = y0 + 1
            Line (x - x0, y + y0)-(x + x0, y + y0), c, BF
            Line (x - x0, y - y0)-(x + x0, y - y0), c, BF
            e = e + 2 * y0
        Else
            Line (x - y0, y - x0)-(x + y0, y - x0), c, BF
            Line (x - y0, y + x0)-(x + y0, y + x0), c, BF
            x0 = x0 - 1
            e = e - 2 * x0
        End If
    Loop
    Line (x - r, y)-(x + r, y), c, BF
End Sub
