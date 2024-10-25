'Option _Explicit
'_Title "Plasma Laser Cannon Pointer" ' for QBJS b+ 2023-09-21
' start mod from Plasma Laser Canon demo prep for GUI 2020-11-11

Screen _NewImage(1200, 600, 32)
Randomize Timer
Dim Shared As Long ShipLights
Dim Shared As _Unsigned Long ShipColor
Dim As Long cx, cy, mx, my, mb, sx, sy
Dim As Single ma, md, dx, dy
cy = _Height / 2: cx = _Width / 2
ShipColor = &HFF3366AA
'  _MouseHide '??? not supported and bad idea anyway
Do
    Cls
    While _MouseInput: Wend
    mx = _MouseX: my = _MouseY: mb = _MouseButton(1)
    dx = mx - cx ' ship avoids collision with mouse
    dy = my - cy
    ma = _Atan2(dy, dx)
    md = Sqr(dy * dy + dx * dx)
    If md < 80 Then md = 80
    sx = cx + md * Cos(ma + 3.1415)
    sy = cy + md * Sin(ma + 3.1415)
    drawShip sx, sy, ShipColor
    If mb Then
        PLC sx, sy, mx, my, 10 ' Fire!
        ShipColor = _RGB32(Int(Rnd * 256), Int(Rnd * 136) + 120, Int(Rnd * 156) + 100)
    End If
    _Display
    _Limit 60
Loop Until _KeyDown(27)

Sub PLC (baseX, baseY, targetX, targetY, targetR) ' PLC for PlasmaLaserCannon
    Dim r, g, b, hp, ta, dist, dr, x, y, c, rr
    r = Rnd ^ 2 * Rnd: g = Rnd ^ 2 * Rnd: b = Rnd ^ 2 * Rnd: hp = _Pi(.5) ' red, green, blue, half pi
    ta = _Atan2(targetY - baseY, targetX - baseX) ' angle of target to cannon base
    dist = _Hypot(targetY - baseY, targetX - baseX) ' distance cannon to target
    dr = targetR / dist
    For r = 0 To dist Step .25
        x = baseX + r * Cos(ta)
        y = baseY + r * Sin(ta)
        c = c + .3
        Color _RGB32(128 + 127 * Sin(r * c), 128 + 127 * Sin(g * c), 128 + 127 * Sin(b * c))
        fcirc x, y, dr * r
    Next
    For rr = dr * r To 0 Step -.5
        c = c + 1
        Color _RGB32(128 + 127 * Sin(r * c), 128 + 127 * Sin(g * c), 128 + 127 * Sin(b * c))
        fcirc x, y, rr
    Next
End Sub

Sub drawShip (x, y, colr As _Unsigned Long) 'shipType     collisions same as circle x, y radius = 30
    ' shared here ShipLights

    Dim light As Long, r As Long, g As Long, b As Long
    r = _Red32(colr): g = _Green32(colr): b = _Blue32(colr)
    Color _RGB32(r, g - 120, b - 100)
    fEllipse x, y, 6, 15
    Color _RGB32(r, g - 60, b - 50)
    fEllipse x, y, 18, 11
    Color _RGB32(r, g, b)
    fEllipse x, y, 30, 7
    For light = 0 To 5
        Color _RGB32(ShipLights * 50, ShipLights * 50, ShipLights * 50)
        fcirc x - 30 + 11 * light + ShipLights, y, 1
    Next
    ShipLights = ShipLights + 1
    If ShipLights > 5 Then ShipLights = 0
End Sub

' these do work in QBJS without mod see le bombe
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

Sub fEllipse (CX As Long, CY As Long, xRadius As Long, yRadius As Long)
    Dim scale As Single, x As Long, y As Long
    scale = yRadius / xRadius
    Line (CX, CY - yRadius)-(CX, CY + yRadius), , BF
    For x = 1 To xRadius
        y = scale * Sqr(xRadius * xRadius - x * x)
        Line (CX + x, CY - y)-(CX + x, CY + y), , BF
        Line (CX - x, CY - y)-(CX - x, CY + y), , BF
    Next
End Sub
