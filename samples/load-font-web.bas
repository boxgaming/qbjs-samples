Import Gfx From "lib/graphics/2d.bas"

Dim f As Long
f = _LoadFont("Arial, Helvetica, sans-serif", 60)
_Font f

Dim img As Long
img = _NewImage(_PrintWidth("Hello World!"), _FontHeight)
_Dest img
Color 15
_PrintMode _KeepBackground
_PrintString (0, 0), "Hello World!"
_Dest 0

Dim As Integer a, x, y
x = _Width / 2
y = _Height / 2
Do
    Line (1, 1)-(_Width, _Height), _RGBA(0, 0, 0, 70), BF
    Gfx.RotoZoom x, y, img, 1, 1, a
    a = a + 3
    If a > 359 Then a = 0
    _Limit 60
Loop