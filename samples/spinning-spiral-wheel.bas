'Dav, SEP/2023

Screen _NewImage(800, 600, 32)

Dim points, i, a, b, clr&, w 'for qbjs to use

'generate starting values
points = 9 + Int(Rnd * 10) 'num of points to use
ReDim px(points), py(points) 'x/y pos of points
clr& = _RGB(Rnd * 255, Rnd * 255, Rnd * 255) 'make random color

Do
    Cls
    'compute x/y pos
    For i = 0 To points
        px(i) = (_Width / 2) + (Sin((Timer * .5) * (i / points)) * _Height / 2)
        py(i) = (_Height / 2) + (Cos((Timer * .5) * (i / points)) * _Height / 2)
    Next

    'do the points
    For a = 0 To points
        For b = 0 To points
            Line (px(a), py(a))-(px(b), py(b)), clr&
            For w = 1 To (points / 2) Step .36
                Circle (px(a), py(a)), w, clr&
            Next
        Next
    Next

    Locate 1, 1: Print "ENTER for new wheel";
    Locate 2, 1: Print points; " points";

    _Limit 60
    _Display

    If InKey$ <> "" Then
        points = 9 + Int(Rnd * 10) 'num of points to use
        ReDim px(points), py(points) 'x/y pos of points
        clr& = _RGB(Rnd * 255, Rnd * 255, Rnd * 255) 'random color
    End If
    
Loop Until _KeyHit = 27


