_Title "Mouse down, drag ball, release...  Boing" 'B+ 2019-01-08 from
'boing.bas for SmallBASIC 2015-07-25 MGA/B+
'coloring mods

Const xmax = 1200
Const ymax = 700
Screen _NewImage(xmax, ymax, 32)
_ScreenMove 80, 20

Dim oldtx, oldty, boingx, boingy, tx, ty, mb, corner, s1x, s1y, x, y, sx, sy

Dim s(1 To 4, 1 To 2)
s(1, 1) = 0: s(1, 2) = 50
s(2, 1) = 0: s(2, 2) = ymax - 50
s(3, 1) = xmax + 30: s(3, 2) = 50
s(4, 1) = xmax + 30: s(4, 2) = ymax - 50
oldtx = 0: oldtyty = 0: da = .03
boingx = 0: boingy = 0
While 1
    While _MouseInput: Wend
    mb = _MouseButton(1)
    If mb Then
        tx = _MouseX + 20
        ty = _MouseY
    Else
        tx = xmax / 2
        ty = ymax / 2
        If tx <> oldtx Or ty <> oldty Then
            boingx = 3 * (tx - oldtx) / 4
            boingy = 3 * (ty - oldty) / 4
        Else
            boingx = -3 * boingx / 4
            boingy = -3 * boingy / 4
        End If
        tx = tx + boingx
        ty = ty + boingy
    End If
    a = 0
    oldtx = tx
    oldty = ty
    Cls
    For corner = 1 To 4
        s1x = s(corner, 1)
        s1y = s(corner, 2)
        dx = (tx - s1x) / 2000
        dy = (ty - s1y) / 2000
        x = tx - 20
        y = ty
        For i = 1 To 2000
            sx = 20 * Cos(a) + x
            sy = 20 * Sin(a) + y
            Line (sx, sy + 5)-(sx + 4, sy + 5), _RGB32(118, 118, 118), BF
            Line (sx, sy + 4)-(sx + 4, sy + 4), _RGB32(148, 148, 148), BF
            Line (sx, sy + 3)-(sx + 4, sy + 3), _RGB32(238, 238, 238), BF
            Line (sx, sy + 2)-(sx + 4, sy + 3), _RGB32(208, 208, 208), BF
            Line (sx, sy + 1)-(sx + 4, sy + 1), _RGB32(168, 168, 168), BF
            Line (sx, sy)-(sx + 4, sy), _RGB32(108, 108, 108), BF
            Line (sx, sy - 1)-(sx + 4, sy - 1), _RGB32(68, 68, 68), BF
            x = x - dx: y = y - dy
            a = a + da
        Next
    Next
    For r = 50 To 1 Step -1
        g = (50 - r) * 5 + 5
        Color _RGB32(g, g, g)
        fcirc tx - 20, ty, r
    Next
    _Display
    _Limit 15
Wend

'Steve McNeil's  copied from his forum   note: Radius is too common a name
Sub fcirc (CX As Long, CY As Long, R As Long)
    Dim subRadius As Long, RadiusError As Long
    Dim X As Long, Y As Long

    subRadius = Abs(R)
    RadiusError = -subRadius
    X = subRadius
    Y = 0

    If subRadius = 0 Then PSet (CX, CY): Exit Sub

    ' Draw the middle span here so we don't draw it twice in the main loop,
    ' which would be a problem with blending turned on.
    Line (CX - X, CY)-(CX + X, CY), , BF

    While X > Y
        RadiusError = RadiusError + Y * 2 + 1
        If RadiusError >= 0 Then
            If X <> Y + 1 Then
                Line (CX - Y, CY - X)-(CX + Y, CY - X), , BF
                Line (CX - Y, CY + X)-(CX + Y, CY + X), , BF
            End If
            X = X - 1
            RadiusError = RadiusError - X * 2
        End If
        Y = Y + 1
        Line (CX - X, CY - Y)-(CX + X, CY - Y), , BF
        Line (CX - X, CY + Y)-(CX + X, CY + Y), , BF
    Wend
End Sub