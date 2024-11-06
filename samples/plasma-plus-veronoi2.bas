'$If WEB Then
'        Import G2D From "lib/graphics/2d.bas"
'$End If
Screen _NewImage(400, 300, 32)
Dim Shared As Single Rd, Gn, Bl
Dim Shared As Long NP
ReDim Shared As Long Px(1 To NP), Py(1 To NP)
Dim As Long x, y
Dim As Single d, dist
Dim As Long i
Dim As Single t
Dim k$
Dim c As _Unsigned Long
Setup
Do
    For y = 0 To _Height - 1 Step 4
        For x = 0 To _Width - 1 Step 4
            d = 10000
            For i = 1 To NP
                dist = _Hypot(x - Px(i), y - Py(i))
                If dist < d Then d = dist
            Next
            d = d + t
            c = _RGB32(127 + 127 * Sin(Rd * d), 127 + 127 * Sin(Gn * d), 127 + 127 * Sin(Bl * d))
            Line (x, y)-Step(4, 4), c, BF
        Next
    Next
    t = t + 1
    k$ = InKey$
    If Len(k$) Then
        Setup: t = 0
    End If
    _Display
    _Limit 30 'ha!
Loop Until _KeyDown(27)

Sub Setup
    Dim As Long i
    Rd = Rnd * Rnd: Gn = Rnd * Rnd: Bl = Rnd * Rnd
    NP = Int(Rnd * 50) + 3
    ReDim As Long Px(1 To NP), Py(1 To NP)
    For i = 1 To NP
        Px(i) = Int(Rnd * _Width)
        Py(i) = Int(Rnd * _Height)
    Next
End Sub
