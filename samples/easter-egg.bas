Randomize Timer
Const xmax = 800
Const ymax = 600
'Common Shared mixer
Dim Shared mixer

Type ColorType: As Integer r, g, b, a: End Type

Screen _NewImage(xmax, ymax, 32)
_Title "Recursive Fill on Egg Shape 2 lighted"

seedSpacer = 16
'seedColor~& = _RGB(Rnd * 100 + 155, Rnd * 100 + 155, Rnd * 100 + 155)
seedColor~& = F_RGB(Rnd * 100 + 155, Rnd * 100 + 155, Rnd * 100 + 155)
img& = _NewImage(513, 513, 32)
Do
    Cls
    _Source img&
    _Dest img&
    For y = 0 To 512 Step seedSpacer
        For x = 0 To 512 Step seedSpacer
            PSet (x, y), seedColor~&
        Next
    Next
    mixer = Rnd * 10
    rfill 0, 0, 512, 512
    _Dest 0
    _PutImage , img&, 0
    '_Delay 2
    _Limit 60
    projectImagetoSphere img&, xmax / 2, ymax / 2, 350
    Print "Press escape to quit, any other = another..."
    _Display
    Sleep
Loop Until _KeyDown(27)

Sub rfill (l, t, r, b)
    'If Fix(Timer) Mod 4 = 0 Then _Limit 200 ' prevent browser lockup

    If l < r - 2 And t < b - 2 Then
        mx = Int((r - l) / 2) + l: my = Int((b - t) / 2) + t
        $If WEB Then
         pc~& = Int((FPoint(l, t) + FPoint(r, t) + FPoint(l, b) + FPoint(r, b)) * mixer)
        $Else
            pc~& = Int((Point(l, t) + Point(r, t) + Point(l, b) + Point(r, b)) * mixer)
        $End If
        If _Red32(pc~&) / 255 < .25 Then
            cr% = 0
        ElseIf _Red32(pc~&) / 255 < .5 Then
            cr% = 128
        ElseIf _Red(pc~&) / 255 < .75 Then
            cr% = 192
        Else
            cr% = 255
        End If
        If _Green32(pc~&) / 255 < .25 Then
            cg% = 0
        ElseIf _Green32(pc~&) / 255 < .5 Then
            cg% = 128
        ElseIf _Green32(pc~&) / 255 < .75 Then
            cg% = 192
        Else
            cg% = 255
        End If
        If _Blue32(pc~&) / 255 < .5 Then
            cb% = 0
        ElseIf _Blue32(pc~&) / 255 < .5 Then
            cb% = 128
        ElseIf _Blue32(pc~&) / 255 < .75 Then
            cb% = 192
        Else
            cb% = 255
        End If
        $If WEB Then
            clr& = _RGB32(cr%, cg%, cb%)
            For py = my - 1 To my + 1
                For px = mx - 1 To mx + 1
                    PSet (px, py), clr&
                Next px
            Next py
        $Else
            Line (mx - 1, my - 1)-(mx + 1, my + 1), _RGB32(cr%, cg%, cb%), BF
        $End If
        rfill l, t, mx, my
        rfill mx, t, r, my
        rfill l, my, mx, b
        rfill mx, my, r, b
    Else
        Exit Sub
    End If
End Sub

Sub projectImagetoSphere (image&, x0, y0, sr)
    Dim ct As ColorType
    r = _Height(image&) / 2
    iW = _Width(image&)
    iH = _Height(image&)
    scale = sr / r
    For y = -r To r
        x1 = Sqr(r * r - y * y) - .2 * sr
        tv = (_Asin(y / r) + 1.57) / 3.15
        xx = 0
        For x = -x1 + 1 To x1
            xx = xx + 1
            tu = (_Asin(x / x1) + 3.15) / 6.283
            _Source image&
            'pc~& = Point((tu * iW), tv * iH)
            pc~& = FPoint((tu * iW), tv * iH)
            cAnalysis pc~&, ct 'red, grn, blu, alp
            d = Sqr((x * scale + .2 * sr) ^ 2 + (y * scale + .6 * sr) ^ 2)
            cf = 200 * (sr - d) / sr
            'pc~& = _RGB32(red + cf, grn + cf, blu + cf)
            pc~& = F_RGB(ct.r + cf, ct.g + cf, ct.b + cf)
            _Dest 0
            f = .55 + .35 * (xx / (2 * r))
            'f = 1
            $If WEB Then
                Circle (x * scale + x0, f * y * scale + y0), 1, pc~&
            $Else
                Circle (x * scale + x0, f * y * scale + y0), 2, pc~&
            $End If
            'PSet (x * scale + x0, f * y * scale + y0), pc~&
        Next x
    Next y
End Sub

Sub cAnalysis (c As _Unsigned Long, ct As ColorType) 'outRed, outGrn, outBlu, outAlp)
    'outRed = _Red32(c): outGrn = _Green32(c): outBlu = _Blue32(c): outAlp = _Alpha32(c)
    ct.r = _Red32(c): ct.g = _Green32(c): ct.b = _Blue32(c): ct.a = _Alpha32(c)
End Sub

Function F_RGB~& (r, g, b)
    F_RGB = _RGB32(Int(r), Int(g), Int(b))
End Function

Function FPoint~& (x, y)
    $If WEB Then
        FPoint = Val(Point(Int(x), Int(y)))
    $Else
        FPoint = Point(x, y)
    $End If
End Function
