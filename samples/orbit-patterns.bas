_Title "Orbit Patterns" 'b+ started 2020-02-25
'can we find speeds for disks going in  orbits around center st they form patterns

Const xmax = 700, ymax = 700, center = 350, P1 = _Pi, P2 = P1 * 2, PD2 = P1 * .5
Dim a, i, x, y, r
Screen _NewImage(xmax, ymax, 32)
_ScreenMove 300, 20
Dim rate(1 To 20)
For i = 1 To 20
    rate(i) = (21 - i) / 12
Next
While _KeyDown(27) = 0
    Cls
    For r = 10 To 200 Step 10
        Circle (center, center), r
        i = Int(r / 10)
        x = center + r * Cos(rate(i) * a)
        y = center + r * Sin(rate(i) * a)
        Circle (x, y), 5
    Next
    a = a + _Pi(2 / 120)
    _Display
    _Limit 30
Wend