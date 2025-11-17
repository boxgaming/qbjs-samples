'==================
'EXPLODEPLANET2.BAS
'==================
'Explodes a small planet on the screen, fading out screen.
'It does this loading all image pixel data into arrays,
'and changing the x/y position of pixels on the screen.
'Alpha transparecy is used for screen fading effect.
'Tested & Working under QBJS & Windows/Linux QB64-PE 3.8.
'Coded by Dav, SEP/2023

'v2 - Inspired by James great version I added: keeping stars showing,
'     debris flickers and wobbles as it fades out.  Flash boom effect.

Randomize Timer

Screen _NewImage(800, 600, 32)

Dim planet&, x, y, x2, y2, r, g, b, a, c, n '<-- for qbjs to use
Dim pixels&, pix&, back&, alpha, flashalpha

Dim sndExplode As Long
sndExplode = _SndOpen("https://opengameart.org/sites/default/files/explosion1.ogg")


'make a planet image
planet& = _NewImage(200, 200, 32): _Dest planet&
x = 100: y = 100: r = 200: g = 100: b = 100: a = 255
For y2 = y - 100 To y + 100
    For x2 = x - 100 To x + 100
        If Sqr((x2 - x) ^ 2 + (y2 - y) ^ 2) <= 100 Then
            c = (100 - (Sqr((x2 - x) * (x2 - x) + (y2 - y) * (y2 - y)))) / 100
            n = 20 * Sin((x2 + y2) / 30) + 10 * Sin((x2 + y2) / 10)
            PSet (x2, y2), _RGBA(c * r - n, c * g - n, c * b - n, a)
        End If
    Next
Next

Line (-1, -1)-(0, 0), _RGB(0, 0, 0) 'a qbjs fix

_Dest 0

'show some stars
Cls
For x = 1 To 1000
    c = Rnd * 4
    Line (Rnd * _Width, Rnd * _Height)-Step(c, c), _RGBA(200, 200, 200, 25 + Rnd * 200), BF
Next

back& = _CopyImage(_Display)

'compute center spot for placing image on screen
x = _Width / 2 - (_Width(planet&) / 2) 'x center image on screen
y = _Height / 2 - (_Height(planet&) / 2) 'y center image on screen


'====================================================================
_PutImage (x, y), planet& '<<-- why won't this show in qbjs?
'====================================================================

Print "Press any key to Explode the planet..."
_Display
Sleep 3
_SndPlay sndExplode

pixels& = _Width(planet&) * _Height(planet&)
Dim PixX(pixels&), PixY(pixels&)
Dim PixXDir(pixels&), PixYDir(pixels&)
Dim PixClr&(pixels&), PixGro(pixels&)

'Read all pixels from image into arrays,
'and generate x/y movement values
_Source planet&
pix& = 0
For x2 = 0 To _Width(planet&) - 1
    For y2 = 0 To _Height(planet&) - 1
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
        'make some pixels get larger as they explode (3d effect)
        If Int(Rnd * 200) = 2 Then
            PixGro(pix&) = 2
        Else
            PixGro(pix&) = 1
        End If
        pix& = pix& + 1 'goto next pixels
    Next
Next
_Source 0


alpha = 255
flashalpha = 125

'Explode image and Fade out screen
Do 'display all pixels
    _PutImage (0, 0), back&
    'flash screen briefly
    If alpha = 255 Then
        Line (0, 0)-(_Width, _Height), _RGBA(255, 255, 255, flashalpha), BF
        _Display: _Delay .05
        Line (0, 0)-(_Width, _Height), _RGBA(255, 255, 100, flashalpha), BF
        _Display: _Delay .08
        Line (0, 0)-(_Width, _Height), _RGBA(255, 255, 255, flashalpha), BF
        _Display: _Delay .05
        _PutImage (0, 0), back&
    End If

    For pix& = 0 To pixels& - 1 Step 6
        'pixel x pos, +/- dir value
        PixX(pix&) = PixX(pix&) + PixXDir(pix&)
        'pixel y pos, +/- dir value
        PixY(pix&) = PixY(pix&) + PixYDir(pix&)
        If PixX(pix&) > 0 And PixX(pix&) < _Width Then
            If PixY(pix&) > 0 And PixY(pix&) < _Height Then
                If Int(Rnd * 4) <> 1 Then 'flicker hack
                    wob = (Rnd * 3) - (Rnd * 3) 'a little wobble
                    Line (PixX(pix&) + wob, PixY(pix&) + wob)-Step(PixGro(pix&), PixGro(pix&)), PixClr&(pix&), BF
                End If
            End If
        End If
        'adjust pixels alpha value
        r = _Red32(PixClr&(pix&))
        g = _Green32(PixClr&(pix&))
        b = _Blue32(PixClr&(pix&))
        PixClr&(pix&) = _RGBA(r, g, b, alpha)

        If PixGro(pix&) > 1 Then
            PixGro(pix&) = PixGro(pix&) + .05
            If PixGro(pix&) > 10 Then PixGro(pix&) = 10
        End If

    Next
    alpha = alpha - .8
    If alpha <= 0 Then Exit Do

    'simmer down the flash boom effect
    If flashalpha > 0 Then
        Line (0, 0)-(_Width, _Height), _RGBA(255, 255, 255, flashalpha), BF
    End If
    flashalpha = flashalpha - 3

    _Limit 30
    _Display
Loop

End
