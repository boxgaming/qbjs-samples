'====--============
'UNEXPLODEIMAGE.BAS
'==================
'Reverse explodes an image onto the screen (Assemble it).
'It does this loading all image pixel data into arrays,
'and changing the x/y position of pixels on the screen.
'Tested & Working under QBJS, Windows & Linux QB64-PE 3.8.
'Coded by Dav, SEP/2023


Randomize Timer
Screen _NewImage(800, 600, 32)

Dim x, y, randimage&, c, r, g, b, s, size 'For QBJS to use

'draw a background to use
Cls
For x = 1 To _Width Step 20
    For y = 1 To _Height Step 20
        Line (x, y)-Step(20, 20), _RGBA(Rnd * 32, Rnd * 64, Rnd * 255, 50), BF
    Next
Next

scr& = _CopyImage(_Display)

Do

    '===============================================
    'Make an image just for this demo to use
    '===============================================
    randimage& = _NewImage(192, 192, 32)
    _Dest randimage& 'point to it
    'draw circles
    For c = 1 To 15
        r = Rnd * 255: g = Rnd * 255: b = Rnd * 255
        x = 20 + (Rnd * 152): y = 20 + (Rnd * 152)
        size = Rnd * 20
        For s = 1 To size Step .36
            Circle (x, y), s, _RGB(r, g, b)
        Next
    Next
    _Dest 0 'point to main screen now
    '===============================================


    UnExplodeImage Rnd * _Width, Rnd * _Height, randimage&


    _FreeImage randimage& 'free demo image used

Loop


Sub UnExplodeImage (x, y, image&)

    Dim back&, pixels&, pix&, x2, y2, alloff&, loopcount, a 'For QBJS to use

    back& = _CopyImage(_Display)

    pixels& = _Width(image&) * _Height(image&)
    ReDim PixX(pixels&), PixY(pixels&)
    ReDim PixXDir(pixels&), PixYDir(pixels&)
    ReDim PixClr&(pixels&)
    'Read all pixels from image& into arrays,
    'and generate x/y movement values
    _Source image&
    pix& = 0
    For x2 = 0 To _Width(image&) - 1
        For y2 = 0 To _Height(image&) - 1
            PixClr&(pix&) = Point(x2, y2) 'pixel color
            PixX(pix&) = x + x2 'pixel x pos
            PixY(pix&) = y + y2 'pixel y pos
            'generate random x/y dir movement values
            Do
                'assign a random x/y dir value (from range -8 to 8)
                PixXDir(pix&) = Rnd * 8 - Rnd * 8 'go random +/- x pixels
                PixYDir(pix&) = Rnd * 8 - Rnd * 8 'go random +/- y pixels
                'Keep looping until both directions have non-zero values
                If PixXDir(pix&) <> 0 And PixYDir(pix&) <> 0 Then Exit Do
            Loop
            pix& = pix& + 1 'goto next pixels
        Next
    Next
    _Source 0

    'compute putting all pixels off screen
    alloff& = 0
    loopcont = 0
    Do
        For pix& = 0 To pixels& - 1
            PixX(pix&) = PixX(pix&) + PixXDir(pix&)
            PixY(pix&) = PixY(pix&) + PixYDir(pix&)
            If PixY(pix&) < 0 Or PixY(pix&) > _Height Then
                If PixX(pix&) < 0 Or PixX(pix&) > _Width Then
                    alloff& = alloff& + 1
                End If
            End If
        Next
        If alloff& > pixels& - 1 Then Exit Do
        loopcount = loopcount + 1
    Loop

    'Now do the visual assemble of pixels

    For a = 0 To loopcount
        _PutImage (0, 0), back&
        'display all pixels
        For pix& = pixels& - 1 To 0 Step -1
            'pixel x pos, +/- dir value
            PixX(pix&) = PixX(pix&) - PixXDir(pix&)
            'pixel y pos, +/- dir value
            PixY(pix&) = PixY(pix&) - PixYDir(pix&)
            '===============================================================================
            'PSet (PixX(pix&), PixY(pix&)), PixClr&(pix&) 'can use this instead of LINE below
            Line (PixX(pix&), PixY(pix&))-Step(3, 3), PixClr&(pix&), BF
            '=================================================================================
        Next
        _Limit 30
        _Display
    Next

End Sub
