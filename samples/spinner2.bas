'Option _Explicit
_Title "Spinner 2" 'b+ 2021-06-18

' 2023-09-25 convert to QBJS
' 2023-09-27 use FArc for Fat Arcs!

$If WEB Then
    Import G2D From "lib/graphics/2d.bas"
$End If

Dim As Long b, r
Dim a
Dim K As _Unsigned Long
Screen _NewImage(500, 500, 32)

While 1
    Cls
    b = b + 1
    For r = 10 To 200 Step 10 ' tsh73 suggested fix for inner most
        a = _D2R(b * r / 20)
        If Int(r / 10) Mod 2 Then K = &HFF009900 Else K = &HFF0000FF
        FArc 250, 250, r, 3, a, a + _Pi, K
    Next
    _Display
    _Limit 30 
Wend

'2023-02-04 Fill Arc draw an arc with thickness, tested in Profile Pong 3-0
' this sub needs sub FCirc(CX As Long, CY As Long, R As Long, C As _Unsigned Long) for dots
Sub FArc (x, y, r, thickness, RadianStart, RadianStop, c As _Unsigned Long)
    Dim al, a
    'x, y origin of arc, r = radius, thickness is radius of dots, c = color
    'RadianStart is first angle clockwise from due East = 0 in Radians
    ' arc will start drawing there and clockwise until RadianStop angle reached

    If RadianStop < RadianStart Then
        FArc x, y, r, thickness, RadianStart, _Pi(2), c
        FArc x, y, r, 0, thickness, RadianStop, c
    Else
        al = _Pi * r * r * (RadianStop - RadianStart) / _Pi(2)
        For a = RadianStart To RadianStop Step 1 / r
            FCirc x + r * Cos(a), y + r * Sin(a), thickness, c
        Next
    End If
End Sub

' modified for QBJS AND QB64
Sub FCirc (CX As Long, CY As Long, R As Long, C As _Unsigned Long)

    ' put this at top of QB64 to QBJS code
    '$If WEB Then
    '        import G2D From "lib/graphics/2d.bas"
    '$End If


    $If WEB Then
        G2D.FillCircle CX, CY, R, C
    $Else
        Dim Radius As Long, RadiusError As Long
        Dim X As Long, Y As Long
        Radius = Abs(R): RadiusError = -Radius: X = Radius: Y = 0
        If Radius = 0 Then PSet (CX, CY), C: Exit Sub
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
    $End If
End Sub
