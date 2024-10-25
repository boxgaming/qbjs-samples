'Option _Explicit
_Title "Particle Fountain"
Const nP = 30000
Type particle
    x As Single
    y As Single
    dx As Single
    dy As Single
    r As Single
    c As _Unsigned Long
End Type
Dim Shared p(nP) As particle
Screen _NewImage(800, 600, 32)
Dim As Long i, lp
For i = 0 To nP
    new i
Next
Do
    Cls
    If lp < nP Then
        lp = lp + 10
    End If
    For i = 0 To lp
        p(i).dy = p(i).dy + .1
        p(i).x = p(i).x + p(i).dx
        p(i).y = p(i).y + p(i).dy
        If p(i).x < 0 Or p(i).x > _Width Then
            new i
        End If
        If p(i).y > _Height And p(i).dy > 0 Then
            p(i).dy = -.75 * p(i).dy
            p(i).y = _Height - 5
        End If
        'Circle (p(i).x, p(i).y), p(i).r, p(i).c
        PSet (p(i).x, p(i).y), p(i).c
    Next
    _Limit 100
Loop

Sub new (i)
    p(i).x = _Width / 2 + Rnd * 20 - 10
    p(i).y = _Height + Rnd * 5
    p(i).dx = Rnd * 1 - .5
    p(i).dy = -10
    p(i).r = Rnd * 3
    p(i).c = _RGB32(100 * Rnd + 155, 100 * Rnd + 155, 200 + Rnd * 55)
End Sub

