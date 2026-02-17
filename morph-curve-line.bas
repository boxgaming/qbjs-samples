_Title "Morph Curve Line" 'b+ mod 2026-02-16 from 2022-07-19 trans from
' Morph Curve on Plasma.bas  SmallBASIC 0.12.8 [B+=MGA] 2017-04-11
'from SpecBAS version Paul Dunn Dec 2, 2015
'https://www.youtube.com/watch?v=j2rmBRLEVms

Const xmax = 1200, ymax = 700, pts = 240, interps = 30, pi = _Pi
Dim Shared ShadeGrey, GreyN
Randomize Timer
Screen _NewImage(xmax, ymax, 32)
_FullScreen

Dim p(pts + 1, 1), q(pts + 1, 1), s(pts + 1, 1), i(interps)
Dim As Long L, c, j
Dim As Single cx, cy, sc, st, n, m, t, lastx, lasty
L = 0: cx = xmax / 2: cy = ymax / 2: sc = cy * .5: st = 2 * pi / pts
For n = 1 To interps
    i(n) = Sin(n / interps * (pi / 2))
Next
Color , &HFF330000: Cls
While _KeyDown(27) = 0
    ResetGrey
    n = Int(Rnd * 75) + 2: m = Int(Rnd * 500) - 250: c = 0
    For t = 0 To 2 * pi Step st
        If _KeyDown(27) Then System
        q(c, 0) = cx + sc * (Cos(t) + Cos(n * t) / 2 + Sin(m * t) / 3)
        q(c, 1) = cy + sc * (Sin(t) + Sin(n * t) / 2 + Cos(m * t) / 3)
        SetGrey
        If t > 0 Then Line (lastx, lasty)-(q(c, 0), q(c, 1))
        lastx = q(c, 0): lasty = q(c, 1)
        c = c + 1
    Next
    q(c, 0) = q(0, 0): q(c, 1) = q(0, 1)
    If L = 0 Then
        L = 1
        _Display
        _Limit 15
    Else
        For t = 1 To interps
            Cls
            For n = 0 To pts
                If _KeyDown(27) Then System
                s(n, 0) = q(n, 0) * i(t) + p(n, 0) * (1 - i(t))
                s(n, 1) = q(n, 1) * i(t) + p(n, 1) * (1 - i(t))
                SetGrey
                If n > 0 Then Line (lastx, lasty)-(s(n, 0), s(n, 1))
                lastx = s(n, 0): lasty = s(n, 1)
            Next
            s(n, 0) = s(0, 0)
            s(n, 1) = s(0, 1)
            _Display
            _Limit 15
        Next
    End If
    For j = 0 To pts + 1 'copy q into p
        If _KeyDown(27) Then System
        p(j, 0) = q(j, 0)
        p(j, 1) = q(j, 1)
    Next
    _Display
    _Delay 1
Wend

Sub ResetGrey () 'all globals
    ShadeGrey = Rnd ^ 2: GreyN = 0
End Sub

Sub SetGrey () 'all globals
    GreyN = GreyN + _Pi(1 / 6)
    Color _RGB32(170 + 84 * Sin(ShadeGrey * GreyN))
End Sub

