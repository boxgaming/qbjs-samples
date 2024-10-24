    Dim buzz, music, lose
    music = _SndOpen("https://opengameart.org/sites/default/files/newbattle.wav")
    buzz = _SndOpen("https://opengameart.org/sites/default/files/buzz_0.ogg")
    lose = _SndOpen("https://opengameart.org/sites/default/files/lose%20music%201%20-%201_0.wav")
    _SndLoop music
    Dim As Long HX, HY, i, hits, score, Stars, nEnemies, Height
    HX = 320: HY = 400: nStars = 1000: nEnemies = 50: Height = 480
    Dim EX(nEnemies), EY(nEnemies), EC(nEnemies) As _Unsigned Long ' enemy stuff
    Screen _NewImage(640, Height, 32)
    Stars = _NewImage(640, Height, 32)
    For i = 1 To nStars
        PSet (Int(Rnd * 640), Int(Rnd * 480)), _RGB32(55 + Rnd * 200, 55 + Rnd * 200, 55 + Rnd * 200)
    Next
    _PutImage , 0, Stars
    For i = 1 To nEnemies
        EX(i) = Int(Rnd * 600 + 20): EY(i) = -2 * Height * Rnd + Height: EC(i) = _RGB32(55 + Rnd * 200, 55 + Rnd * 200, 55 + Rnd * 200)
    Next
    Do
        Cls
        _PutImage , Stars, 0
        Print "Hits:"; hits, "Score:"; score
        Line (HX - 10, HY - 10)-Step(20, 20), _RGB32(255, 255, 0), BF
        For i = 1 To nEnemies ' the enemies
            Circle (EX(i), EY(i)), 10, EC(i)
            If Sqr((EX(i) - HX) ^ 2 + (EY(i) - HY) ^ 2) < 20 Then 'collision
                _SndPause music
                _SndPlay buzz
                _Delay .5
                hits = hits + 1
                EX(i) = Int(Rnd * 600 + 20): EY(i) = -Height * Rnd ' move that bad boy!
                If hits = 10 Then
                    Print "Too many hits, goodbye!"
                    _SndPlay lose
                    FadeOut
                    End
                End If
                _SndLoop music
            End If
            EY(i) = EY(i) + Int(Rnd * 5)
            If EY(i) > 470 Then EX(i) = Int(Rnd * 600 + 20): EY(i) = -Height * Rnd: score = score + 1
        Next
        If _KeyDown(20480) Then HY = HY + 3
        If _KeyDown(18432) Then HY = HY - 3
        If _KeyDown(19200) Then HX = HX - 3
        If _KeyDown(19712) Then HX = HX + 3
        If HX < 10 Then HX = 10
        If HX > 630 Then HX = 630
        If HY < 10 Then HY = 10
        If HY > 470 Then HY = 470
        _Display
        _Limit 100
    Loop Until _KeyDown(27): Sleep
    _SndStop music
                               
    Sub FadeOut
        _Delay 2
        Dim i
        For i = 1 to 100
            Line (0, 0)-(_Width, _Height), _RGBA(1, 1, 1, 5), BF
            _Limit 30
        Next i
        Locate 16, 35
        Print "Game Over"
    End Sub
     