Import Gfx From "lib/graphics/2d.bas"
_Title "Diamond Spaceship" 'b+ 2022-07-23
' 2022-7-24 fixed panel problems and added PolyFill routine for rise and fall glowing

'spinning diamond mini-micro script in micro(A)
' from Aurel Micro A trans:  http://basic4all.epizy.com/index.php?topic=199.new#new

Screen _NewImage(800, 600, 32)
Dim pi, p6, t, m, dir, glow, i, x, a, y, b, lx, ly, la, lb
Dim ao
pi = _Pi
p6 = pi / 6
t = 0
m = 400
dir = 1
glow = 50
Color _RGB32(200, 200, 240), _RGB32(0, 0, 0)
Dim As _Unsigned Long colr, edge
Dim poly(25)
edge = &H99AAAAFF
Do Until _KeyDown(27)
    Cls
    t = (t + 0.01)
    i = 0
    While i <= 12
        r = Cos(p6 * i + t + ao)
        x = m - 300 * r
        a = m - 250 * r
        y = 400 - 40 * Cos(p6 * (i - 3) + t + ao) - 140 + glow ' y
        b = y + 50
        Color _RGB32(200, 200, 240)
        Line (m, 100 - 140 + glow)-(x, y), edge
        Line (x, y)-(a, b), edge
        If i Mod 2 Then colr = &H220000FF Else colr = &H2200FFFF
        If i > 0 Then
            Line (a, b)-(la, lb), edge ' bottom disk
            Line (x, y)-(lx, ly), edge ' top disk
            Gfx.FillTriangle lx, ly, x, y, a, b, colr
            Gfx.FillTriangle a, b, la, lb, lx, ly, colr
            Gfx.FillTriangle m, 100 - 140 + glow, lx, ly, x, y, colr
        End If
        poly(2 * i) = a
        poly(2 * i + 1) = b
        lx = x: ly = y
        la = a: lb = b
        i = i + 1
    Wend
    glow = glow + dir
    If glow >= 256 Then dir = -dir: glow = 255
    If glow <= 49 Then dir = -dir: glow = 50
    PolyFill m, 450 - 140 + glow, poly(), _RGB32(200, 200, 255, glow)
    _Display
    _Limit 30
Loop


Sub PolyFill (xc, yc, poly(), K As _Unsigned Long) ' closed poly the last point repeats the first to close loop
    Dim i
    For i = LBound(poly) + 2 To UBound(poly) Step 2
        Gfx.FillTriangle xc, yc, poly(i - 2), poly(i - 1), poly(i), poly(i + 1), K
    Next
End Sub