'Option _Explicit
_Title "Rotating Star Mouse Chaser" 'b+ 2022-07-19 trans from:
'Rotating Stars Mouse Chaser.bas for SmallBASIC 0.12.0 2015-11-09 MGA/B+
'code is based on code: mouse chaser by tsh73
'for the Just Basic contest, November 2008, I am 7 years later

Const nPoints = 20, xMax = 1280, yMax = 700, pi = _Pi
Screen _NewImage(xMax, yMax, 32)
_FullScreen
Dim Shared x(nPoints), y(nPoints), i, twist

Dim As Long mx, my
Dim As Single dx, dy, v, r, dxN, dyN

For i = 1 To nPoints
    x(i) = xMax
    y(i) = yMax 'set it offscreen
Next

While _KeyDown(27) = 0
    Cls
    twist = twist + .05
    While _MouseInput: Wend
    mx = _MouseX: my = _MouseY
    For i = 1 To nPoints
        If i = 1 Then 'first sees mouse
            dx = mx - x(i)
            dy = my - y(i)
            v = 4
        Else 'others see previous
            dx = x(i - 1) - x(i)
            dy = y(i - 1) - y(i)
            v = 0.6 * v + 0.2 * 3 * (2 - i / nPoints) 'use 0.8 v of previous, to pick up speed
        End If
        r = Sqr(dx ^ 2 + dy ^ 2)
        dxN = dx / r
        dyN = dy / r
        x(i) = x(i) + v * dxN
        y(i) = y(i) + v * dyN
        drawstar
    Next i
    _Display
    _Limit 60
Wend

Sub drawstar ()
    Dim sp, s, t, u, j, b, v, w
    sp = (nPoints + 1 - i) * 2 + 3 'star points when i is low, points are high
    s = 5 * (50 ^ (1 / nPoints)) ^ (nPoints + 1 - i)
    t = x(i) + s * Cos(0 + twist)
    u = y(i) + s * Sin(0 + twist)
    For j = 1 To sp
        b = b + Int(sp / 2) * 2 * pi / sp
        v = x(i) + s * Cos(b + twist)
        w = y(i) + s * Sin(b + twist)
        Line (t, u)-(v, w), _RGB32(255, 255, 100)
        t = v: u = w
    Next
End Sub
