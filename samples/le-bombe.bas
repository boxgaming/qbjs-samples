'Option _Explicit  'edit for QBJS 2023-09-08
_Title "le bombe"
'QB64 X 64 version 1.2 20180228/86  from git b301f92

'2018-07-28 translated from
'bomb.bas for SmallBASIC 0.12.2 [B+=MGA] 2016-05-09
'from explosion study

Const xmax = 800
Const ymax = 600
Screen _NewImage(xmax, ymax, 32)
'_ScreenMove 360, 60
Const max_particles = 1000
Const gravity = .25
Const air_resistance = .95
Type particle
    x As Single
    y As Single
    dx As Single
    dy As Single
    size As Single
    kolor As Long
    tf As Integer
End Type
Dim Shared dots(max_particles) As particle
Dim As Long i, rounds, loop_count
'main
While Not _KeyDown(27)
    For i = 1 To 100
        NewDot i
    Next
    rounds = 100
    For i = 12 To 0 Step -1
        If _KeyDown(27) Then End
        Cls
        DrawSky
        DrawGround
        DrawBomb
        DrawFuse i
        _Display
        If i = 0 Then _Delay Rnd * 3 Else _Delay .100
    Next
    Line (0, 0)-(xmax, ymax), _RGB32(255, 255, 255), BF
    _Display
    _Delay .02
    For loop_count = 0 To 150
        If _KeyDown(27) Then End
        DrawSky
        DrawGround
        If loop_count < 4 Then
            Color _RGB(64 - 8 * loop_count, 40 - 4 * loop_count, 32 - 4 * loop_count)
            If loop_count < 8 Then fcirc xmax / 2, ymax / 2, 30 * (1 - loop_count * .25)
        End If
        For i = 1 To rounds
            dots(i).x = dots(i).x + dots(i).dx
            dots(i).y = dots(i).y + dots(i).dy
            If Rnd < .2 And rounds > 10 And dots(i).y > ymax / 2 Then dots(i).dx = 0: dots(i).dy = 0
            dots(i).dx = dots(i).dx * air_resistance
            If dots(i).dy <> 0 Then dots(i).dy = air_resistance * dots(i).dy + .4 'air resistance and gravity
            If dots(i).tf Then
                Line (dots(i).x, dots(i).y)-Step(dots(i).size, dots(i).size), dots(i).kolor, BF
            Else
                Color dots(i).kolor
                fcirc dots(i).x, dots(i).y, dots(i).size / 2
            End If
        Next
        If rounds < max_particles Then
            For i = 1 To 100
                NewDot (rounds + i)
            Next
            rounds = rounds + 100
        End If
        Color _RGB32(255, 255, 255), _RGB32(0, 0, 255)
        Locate 1, 1: Print loop_count
        _Display
        _Limit 60
    Next
Wend

Sub NewDot (i)
    Dim angle, r
    angle = _Pi(Rnd * 2)
    dots(i).x = xmax / 2 + Rnd * 30 * Cos(angle)
    dots(i).y = ymax / 2 + Rnd * 30 * Sin(angle)
    r = Rnd 'STxAxTIC recommended for rounder spreads
    dots(i).dx = r * 45 * Cos(angle)
    dots(i).dy = r * 45 * Sin(angle)
    dots(i).size = Rnd * 7
    dots(i).kolor = _RGB32(10 + Rnd * 100, 5 + Rnd * 50, 3 + Rnd * 25)
    dots(i).tf = (Rnd * 2) \ 1
End Sub

Sub DrawSky
    Dim i
    For i = 0 To ymax / 2
        Line (0, i)-Step(xmax, 0), _RGB32(0, 0, 95 * i \ (ymax / 2) + 160)
    Next
End Sub

Sub DrawBomb
    Dim cx, cy, radius, angle, rad_angle, x1, y1
    Dim As Long i
    cx = xmax / 2: cy = ymax / 2 - 70: radius = 10
    For i = 60 To 0 Step -1 'main body
        Color _RGB32(240 - 4 * i, 180 - 3 * i, 120 - 2 * i)
        fcirc cx, ymax / 2, i
    Next

    For angle = 0 To 180 'fuse shaft
        rad_angle = _D2R(angle)
        x1 = cx + radius * Cos(rad_angle)
        y1 = cy + radius * .25 * Sin(rad_angle)
        Line (x1, y1)-Step(0, 20), _RGB32(127 + 127 * Cos(rad_angle), 127 + 127 * Cos(rad_angle), 127 + 127 * Cos(rad_angle))
    Next
    Color _RGB32(0, 0, 0)
    fEllipse cx, cy, radius, .25 * radius
End Sub

Sub DrawFuse (length)
    Dim cx, cy, rn, rad_angle, x1, y1, x2, y2
    Dim As Long i
    cx = xmax / 2: cy = ymax / 2 - 70
    If length <= 0 Then Exit Sub
    Color _RGB32(255, 255, 0)
    Line (cx, cy - (5 + 2 * length))-Step(2, 5), , BF
    fcirc cx, cy - (1 + 2 * length), 2
    rn = (Rnd * 5) \ 1 + 3
    For i = 1 To rn
        rad_angle = _Pi(Rnd) + _Pi
        x1 = cx + 7 * Cos(rad_angle): x2 = cx + 14 * Cos(rad_angle)
        y1 = cy - (1 + 2 * length) + 9 * Sin(rad_angle): y2 = cy - (1 + 2 * length) + (Rnd * 13 + 9) * Sin(rad_angle)
        Line (x1, y1)-(x2, y2), _RGB32(255, 255, 255)
    Next
    For i = 1 To length
        rad_angle = _Pi(Rnd * 2)
        x1 = 3 * Cos(rad_angle)
        y1 = 3 * .25 * Sin(rad_angle)
        Line (cx, cy - 2 * i)-Step(x1, y1), _RGB32(Rnd * 65 + 190, Rnd * 65 + 190, Rnd * 20 + 235), BF
    Next
End Sub

Sub DrawGround
    Dim As Long i
    For i = ymax / 2 To ymax
        Line (0, i)-Step(xmax, 0), _RGB32(0, 160 - 96 * (i - ymax / 2) \ (ymax / 2), 0)
    Next
End Sub

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
