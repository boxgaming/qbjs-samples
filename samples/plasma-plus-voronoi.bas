$If WEB Then
        Import G2D From "lib/graphics/2d.bas"
$End If

'Option _Explicit
_Title "Real Plasma and Voronoi, press key for new scheme" '2023-10-19  b+ overhaul of
'fake-voronoi-plasma.bas Dav, OCT/2023

Screen _NewImage(600, 600, 32)
'_ScreenMove 290, 40
Randomize Timer


' cap all shared variables
Dim Shared As Long CX, CY, Radius
' modified by Setup
Dim Shared As Single Rd, Gn, Bl ' plasma colorsfor RGB
Dim Shared As Long NP ' voronoi pt count mod in setup
Dim Shared As Single Angle ' mod in setup
Dim Shared As Long Direction ' mod random turning clockwise or counter

' local
Dim As Long x, y ' from screen
ReDim As Single px(1 To NP), py(1 To NP) ' voronoi points hopefully a spinning polygon
Dim As Single px, py, d, dist ' Voronoi calcs point and distance
Dim As Single da ' is polygon animating index
Dim As Long i, t ' indexes i a regular one and t for plasma color
Dim k$ ' polling keypresses
Dim c As _Unsigned Long ' plasma color line is soooooo long! save it in c container

'once and for all time
CX = _Width / 2: CY = _Height / 2: Radius = _Height / 3

Setup
Do
    For y = 0 To _Height - 1 Step 4
        For x = 0 To _Width - 1 Step 4
            d = 100000 ' too big!
            For i = 1 To NP
                px = CX + Radius * Cos(i * Angle + da)
                py = CY + Radius * Sin(i * Angle + da)
                dist = Sqr(((x - px) ^ 2) + ((y - py) ^ 2))
                If dist < d Then d = dist
            Next
            d = d + t
            c = _RGB32(127 + 127 * Sin(Rd * d), 127 + 127 * Sin(Gn * d), 127 + 127 * Sin(Bl * d))
            FCirc x, y, 3, c
        Next
    Next

    'animate!
    t = t + 2: da = da + _Pi(2 / 90) * Direction
    k$ = InKey$
    If Len(k$) Then
        'If Asc(k$) = 27 Then
            'End
        'Else 'reset plasma
            Setup: t = 0
        'End If
    End If
    _Display
    _Limit 30 'ha!
'Loop Until InKey$ = Chr$(27)
Loop Until _Keydown(27)

Sub Setup ' reset shared
    'setup plasma for RGB color
    Rd = Rnd * Rnd: Gn = Rnd * Rnd: Bl = Rnd * Rnd

    'setup voronoi variables for calcs
    NP = Int(Rnd * 10) + 3 ' 9 + 3 max    number of poly points
    Angle = _Pi(2 / NP) ' angle between
    Direction = 2 * Int(Rnd * 2) - 1 ' turn clockwise or the other wise
End Sub

' this sub for circle fill so can use code in QBJS wo mod
Sub FCirc (CX As Long, CY As Long, R As Long, C As _Unsigned Long)
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
