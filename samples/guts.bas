_Title "Guts" 'passed down through ages, I first encountered it through Richard Russel author BBC 4 Windows
' 2019-04-05 B+ translation to QB64 from: Guts.bas SmallBASIC 0.12.0 2015-11-17 MGA/B+
'modified  > GUTS  Original ARM BBC BASIC version by Jan Vibe, 800x600 ?

Randomize Timer
Const xmax = 800
Const ymax = 600
Screen _NewImage(xmax, ymax, 32)
_ScreenMove 200, 60

Dim bX(15), bY(15), bZ(15), COLR(15) As _Unsigned Long
bX(1) = -100: A = 0
For N = 1 To 15
    COLR(16 - N) = _RGB32(7 * N + 150, 14 * N + 45, 14 * N + 45)
Next

X1 = Rnd * xmax: Y1 = Rnd * ymax: DX1 = (Rnd * 16 + 1) * (Rnd - .5): DY1 = (Rnd * 16 + 1) * (Rnd - .5)
X2 = Rnd * xmax: Y2 = Rnd * ymax: DX2 = (Rnd * 16 + 1) * (Rnd - .5): DY2 = (Rnd * 16 + 1) * (Rnd - .5)
While _KeyDown(27) = 0
    H = X1 + DX1: If H < 0 Or H > xmax Then DX1 = (Rnd * 16 + 1) * -Sgn(DX1)
    H = Y1 + DY1: If H < 0 Or H > ymax Then DY1 = (Rnd * 16 + 1) * -Sgn(DY1)
    X1 = X1 + DX1: Y1 = Y1 + DY1
    If X2 < X1 And DX2 < 24 Then DX2 = DX2 + 1
    If X2 > X1 And DX2 > -24 Then DX2 = DX2 - 1
    If Y2 < Y1 And DY2 < 24 Then DY2 = DY2 + 1
    If Y2 > Y1 And DY2 > -24 Then DY2 = DY2 - 1
    X2 = X2 + DX2: Y2 = Y2 + DY2: A = (A + 10) Mod 360: Z = (Sin(_D2R(A) + 1)) + 2
    For N = 2 To 15
        bX(N - 1) = bX(N): bY(N - 1) = bY(N): bZ(N - 1) = bZ(N)
    Next
    bX(15) = X2: bY(15) = Y2: bZ(15) = Z
    For N = 1 To 15: fcirc bX(N), bY(N), N * bZ(N) + 5, COLR(N): Next
    _Display
    _Limit 60
Wend
Sleep

'from Steve Gold standard
Sub fcirc (CX As Integer, CY As Integer, R As Integer, C As _Unsigned Long)
    Dim Radius As Integer, RadiusError As Integer
    Dim X As Integer, Y As Integer

    Radius = Abs(R)
    RadiusError = -Radius
    X = Radius
    Y = 0

    If Radius = 0 Then PSet (CX, CY), C: Exit Sub

    ' Draw the middle span here so we don't draw it twice in the main loop,
    ' which would be a problem with blending turned on.
    Line (CX - X, CY)-(CX + X, CY), C, BF

    While X > Y
        RadiusError = RadiusError + Y * 2 + 1
        If RadiusError >= 0 Then
            If X <> Y + 1 Then
                Line (CX - Y, CY - X)-(CX + Y, CY - X), C, BF
                Line (CX - Y, CY + X)-(CX + Y, CY + X), C, BF
            End If
            X = X - 1
            RadiusError = RadiusError - X * 2
        End If
        Y = Y + 1
        Line (CX - X, CY - Y)-(CX + X, CY - Y), C, BF
        Line (CX - X, CY + Y)-(CX + X, CY + Y), C, BF
    Wend
End Sub