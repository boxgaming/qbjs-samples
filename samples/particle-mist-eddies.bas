_Title "Particle Mist Eddies Mod, go ahead and try a keypress" ' b+ mod issues37 QBJS post at Discord
Type Particle
    x As Single
    y As Single
    angle As Single
    speed As Single
End Type

Const nParticles = 20000
Const Pi = _Pi
Dim p(1 To nParticles) As Particle
Dim t As Single, i As Long, c As _Unsigned Long

Screen _NewImage(800, 600, 32): _ScreenMove 280, 60
Randomize Timer
For i = 1 To nParticles
    p(i).x = Rnd * 800
    p(i).y = Rnd * 600
    p(i).speed = 0.5 + Rnd * 1.5
    p(i).angle = Rnd * Pi * 2
Next

Do
    t = t + 0.03
    For i = 1 To nParticles
        fieldAngle = SIN(p(i).x / 101 + t) * COS(p(i).y / 103) + _
                     COS(p(i).x / 157 - t * .5) * SIN(p(i).y / 127) + _
                     SIN(p(i).x / 83 + t * .7) * SIN(p(i).y / 79 + t)

        fieldAngle = fieldAngle + (Rnd - 0.5) * 0.1

        p(i).angle = p(i).angle * 0.98 + fieldAngle * 1.0007 '.02
        p(i).speed = 0.5 + Abs(Sin(p(i).x / 200 + t)) * 1.5
        p(i).x = p(i).x + Cos(p(i).angle) * p(i).speed
        p(i).y = p(i).y + Sin(p(i).angle) * p(i).speed

        If p(i).x < 0 Then
            p(i).x = 800
            p(i).y = p(i).y + (Rnd - 0.5) * 20
        End If
        If p(i).x > 800 Then
            p(i).x = 0
            p(i).y = p(i).y + (Rnd - 0.5) * 20
        End If
        If p(i).y < 0 Then
            p(i).y = 600
            p(i).x = p(i).x + (Rnd - 0.5) * 20
        End If
        If p(i).y > 600 Then
            p(i).y = 0
            p(i).x = p(i).x + (Rnd - 0.5) * 20
        End If
        c = _RGB32(127 + 127 * Sin(p(i).x / 200 + t * .5), _
            127 + 127 * Cos(p(i).y / 180 + t * 0.35), _
            127 + 127 * Sin((p(i).x + p(i).y) / 300 + t * .25))

        PSet (p(i).x, p(i).y), c
    Next
    _Limit 60
    _Display
    Cls
Loop
