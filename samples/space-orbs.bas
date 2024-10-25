
'=============
'SpaceOrbs2.bas
'=============
'Screesaver of Orbs pulsating in space
'Coded by Dav for QB64-PE, AUGUST/2023

'v2 - added scrolling stars background
'  - orbs get new x/y position after shrinking away
'  - had to change alpha values of plasma cloud and orbs,
'    because of scrolling stars background.  It's different.
'  - Uses _PUTIMAGE screen trick to blur final _DISPLAY
'Option _Explicit
Dim orbs, OrbSizeMin, OrbSizeMax, i, x, y, back&, backx, t, b, y2, x2, clr, r, g, tmpback&

Randomize Timer

Screen _NewImage(1000, 640, 32)


'=== orb settings

orbs = 60 'number of orbs on screen
OrbSizeMin = 5 'smallest size an orb can get
OrbSizeMax = 60 'largest size an orb can get

Dim OrbX(orbs), OrbY(orbs), OrbSize(orbs), OrbGrowth(orbs), OrbDir(orbs)


'=== generate some random orb values

For i = 1 To orbs
    OrbX(i) = Rnd * _Width 'x pos
    OrbY(i) = Rnd * _Height 'y pos
    OrbSize(i) = OrbSizeMin + (Rnd * (OrbSizeMax - OrbSizeMin)) 'orb size
    OrbGrowth(i) = Int(Rnd * 2) 'way orb is changing, 0=shrinking, 1=growing
    OrbDir(i) = Int(Rnd * 4) 'random direction orb can drift (4 different ways)
Next


'=== make a space background image

For i = 1 To 100000
    PSet (Rnd * _Width, Rnd * _Height), _RGBA(0, 0, Rnd * 255, Rnd * 225)
Next
For i = 1 To 1000
    x = Rnd * _Width: y = Rnd * _Height
    Line (x, y)-(x + Rnd * 3, y + Rnd * 3), _RGBA(192, 192, 255, Rnd * 175), BF
Next


'=== grab screen image for repeated use

back& = _CopyImage(_Display)

backx = 0

Do

    '=== scroll starry background first
    _PutImage (backx, 0)-(backx + _Width, _Height), back&
    _PutImage (backx - _Width, 0)-(backx, _Height), back&
    backx = backx + 4
    If backx >= _Width Then backx = 0


    '=== draw moving plasma curtain next

    t = Timer
    For x = 0 To _Width Step 3
        For y = 0 To _Height Step 3
            b = Sin(x / (_Width / 2) + t + y / (_Height / 2))
            b = b * (Sin(1.1 * t) * (_Height / 2) - y + (_Height / 2))
            Line (x, y)-Step(2, 2), _RGBA(b / 3, 0, b, 50), BF
        Next
        t = t + .085
    Next


    '=== now process all the orbs

    For i = 1 To orbs

        '=== draw orb on screen

        For y2 = OrbY(i) - OrbSize(i) To OrbY(i) + OrbSize(i) Step 3
            For x2 = OrbX(i) - OrbSize(i) To OrbX(i) + OrbSize(i) Step 3
                'make gradient plasma color
                If Sqr((x2 - OrbX(i)) ^ 2 + (y2 - OrbY(i)) ^ 2) <= OrbSize(i) Then
                    clr = (OrbSize(i) - (Sqr((x2 - OrbX(i)) * (x2 - OrbX(i)) + (y2 - OrbY(i)) * (y2 - OrbY(i))))) / OrbSize(i)
                    r = Sin(6.005 * t) * OrbSize(i) - y2 + OrbSize(i) + 255
                    g = Sin(3.001 * t) * OrbSize(i) - x2 + OrbSize(i) + 255
                    b = Sin(2.001 * x2 / OrbSize(i) + t + y2 / OrbSize(i)) * r + 255
                    Line (x2, y2)-Step(2, 2), _RGBA(clr * r, clr * g, clr * b, 30 + Rnd * 25), BF
                End If
            Next
        Next

        '=== change orb values

        'if orb is shrinking, subtract from size, else add to it
        If OrbGrowth(i) = 0 Then OrbSize(i) = OrbSize(i) - 1 Else OrbSize(i) = OrbSize(i) + 1
        'if orb reaches maximum size, switch growth value to 0 to start shrinking now
        If OrbSize(i) >= OrbSizeMax Then OrbGrowth(i) = 0
        'if orb reaches minimum size, switch growth value to 1 to start growing now
        'and reset x/y pos
        If OrbSize(i) <= OrbSizeMin Then
            OrbGrowth(i) = 1
            OrbX(i) = Rnd * _Width
            OrbY(i) = Rnd * _Height
        End If
        'creates the shakiness. randomly adjust x/y positions by +/-3 each
        If Int(Rnd * 2) = 0 Then OrbX(i) = OrbX(i) + 3 Else OrbX(i) = OrbX(i) - 3
        If Int(Rnd * 2) = 0 Then OrbY(i) = OrbY(i) + 3 Else OrbY(i) = OrbY(i) - 3

        'drift orb in  1 of 4 directions we generated, and +x,-x,+y,-y to it.
        If OrbDir(i) = 0 Then OrbX(i) = OrbX(i) + 2 'drift right
        If OrbDir(i) = 1 Then OrbX(i) = OrbX(i) - 2 'drift left
        If OrbDir(i) = 2 Then OrbY(i) = OrbY(i) + 2 'drift down
        If OrbDir(i) = 3 Then OrbY(i) = OrbY(i) - 2 'drift up

        'below handles if ball goes off screen, let it dissapear completely
        If OrbX(i) > _Width + OrbSize(i) Then OrbX(i) = -OrbSize(i)
        If OrbX(i) < -OrbSize(i) Then OrbX(i) = _Width + OrbSize(i)
        If OrbY(i) > _Height + OrbSize(i) Then OrbY(i) = -OrbSize(i)
        If OrbY(i) < -OrbSize(i) Then OrbY(i) = _Height + OrbSize(i)

    Next

    '== screen blur trick to make it more misty looking

    tmpback& = _CopyImage(_Display)
    '_SetAlpha 50, , tmpback&
    _PutImage (-1, 0), tmpback&: _PutImage (1, 0), tmpback&
    _PutImage (0, -1), tmpback&: _PutImage (0, 1), tmpback&
    _PutImage (-1, -1), tmpback&: _PutImage (1, -1), tmpback&
    _FreeImage tmpback&

    _Display

    _Limit 15

Loop Until InKey$ <> ""

