_Title "Dav 'Pulse' Plasma Blend: press 'a' to change angle style, any other key for random, esc to quit"
' 2024-10-02 Dav      Hey, bplus, I thought you may like like this little proggie since you have shared some really great plasmas here.  I wondered what it would look like to show more than one plasma effect using a pulse factor to blend them.  Here's a little example of that.
' 2024-10-02 b+       thank you Dav for nice blended plasma effect, now I play with it :D
' 2024-10-03 Dav      Hey, bplus, I really like your mod.   Played around with the angles today, to come up with a few variations,  Replace the original angle (a) line with one of these to see the different effects achieved manipulating the angle.
' 2024-10-03 Dav      Here's a few more, that's about all I think.
' 2024-10-07 madscijr added press A to cycle through formulas

Const FALSE = 0
Const TRUE = Not FALSE
Dim bFinished As Integer
Dim bRestart As Integer
Dim bChange As Integer
Dim iLastKey As Integer
Dim iAngleFn As Integer
Dim iMaxAngleFn As Integer
Dim cx As Integer
Dim cy As Integer
Dim m1 As Integer
Dim m2 As Integer
Dim m3 As Integer

Screen _NewImage(800, 600, 32)
_ScreenMove 250, 60

bFinished = FALSE
bRestart = TRUE
iAngleFn = 0
iMaxAngleFn = 11

Do
    If bRestart = TRUE Then
        ' Init values
        cx = _Width / 2
        cy = _Height / 2
        m1 = 9
        m2 = 27
        m3 = 3

        ' Choose a new formula
        'iAngleFn = RandomNumber%(1, iMaxAngleFn)
        iAngleFn = iAngleFn + 1: If iAngleFn > iMaxAngleFn Then iAngleFn = 1

        '' Display in title bar
        '_Title "Dav 'Pulse' Plasma Blend: angle style " + _Trim$(Str$(iAngleFn)) + " (press a to change, any other key for random, esc to quit)"

        ' Don't run again until user presses "a" again
        bRestart = FALSE
    ElseIf bChange = TRUE Then
        ' Randomize values
        m3 = Int(Rnd * 12)
        m = Int(Rnd * 3) + 2
        m1 = m * m3
        m2 = m * m1

        ' Don't run again until user presses "b"
        bChange = FALSE
    End If

    T = T + .01 ' mod
    pulse = Sin(T) * .8 'pulse factor

    For y = 0 To _Height Step 3
        For x = 0 To _Width Step 3

            ' --------------------------------------------------------------------------------
            ' case 1
            ' bplus
            ' 10-02-2024, 04:45 PM (This post was last modified: 10-02-2024, 04:47 PM by bplus.)
            ' #207 OK here is a mod Smile
            ' --------------------------------------------------------------------------------
            ' Case 2-7
            ' Dav
            ' 10-03-2024, 03:31 PM
            ' #210: Hey, bplus, I really like your mod.
            ' Played around with the angles today, to come up with a few variations,
            ' Replace the original angle (a) line with one of these
            ' to see the different effects achieved manipulating the angle.
            ' --------------------------------------------------------------------------------
            ' case 8-11
            ' Dav
            ' 10-03-2024, 07:04 PM
            ' #212 Here's a few more, that's about all I think.
            ' --------------------------------------------------------------------------------

            Select Case iAngleFn
                Case 1:
                    a = _Atan2(y - cy, x - cx) + T 'original
                Case 2:
                    a = _Atan2(y - cy, x - cx) + Sin(rad * 2 + T) 'spiral twist
                Case 3:
                    a = _Atan2(y - cy, x - cx) + Sin(T) * 4 'churning using sin
                Case 4:
                    a = _Atan2(y - cy, x - cx) + Cos(T) * 4 'churning using cos
                Case 5:
                    a = _Atan2(y - cy, x - cx) + Sin(T) * rad 'spiral (radius)
                Case 6:
                    a = _Atan2(y - cy, x - cx) + Sin(T * 4 + (x / _Width)) * .5 'edge wave
                Case 7:
                    a = _Atan2(y - cy, x - cx) + (x / _Width) * Sin(T) * 5 'distort
                Case 8:
                    a = _Atan2(y - cy, x - cx) + Cos(T) * 3 + Sin(x / _Width + T * 3) 'better wave
                Case 9:
                    a = _Atan2(y - cy, x - cx) + Sin(T * 2) * Cos(rad * 2) 'double twist!
                Case 10:
                    a = _Atan2(y - cy, x - cx) + Sin(rad * 1.5 + T * 4) 'inward spiral
                Case 11:
                    a = _Atan2(y - cy, x - cx) + Sin(x * .01 + T) * Cos(y * .01 + T) 'mumps!
            End Select

            rad = Sqr((x - cx) ^ 2 + (y - cy) ^ 2) / 100

            '1st plasma colors
            r1 = (Sin(rad * m3 + T) + Sin(a * m1 + T)) * 127 '+ 128
            g1 = (Sin(rad * m3 + T + 1) + Sin(a * m1 + T + 1)) * 127 '+ 128
            b1 = (Sin(rad * m3 + T + 2) + Sin(a * m1 + T + 2)) * 127 ' + 128

            '2nd plasma colors
            r2 = (Sin(rad * 3 + T) + Sin(a * 3 + T + 1)) * 127 + 128
            g2 = (Sin(rad * 3 + T + 2) + Sin(a * m2 + T + 3)) * 127 + 128
            b2 = (Sin(rad * 3 + T + 4) + Sin(a * m2 + T + 4)) * 127 + 128

            'Blend plasma colors using pulse factor
            r = r1 * (1 - pulse) + r2 * pulse
            g = g1 * (1 - pulse) + g2 * pulse
            b = b1 * (1 - pulse) + b2 * pulse

            Line (x, y)-Step(2, 2), _RGB(r, g, b), BF

        Next x
    Next y

    Locate 1, 1: Print _Trim$(Str$(iAngleFn))

    _Display
    _Limit 30

    If _KeyDown(27) Then
        bFinished = TRUE
    ElseIf _KeyDown(Asc("a")) Then
        If iLastKey <> Asc("a") Then ' don't let user hold down "a" key
            bRestart = TRUE
            iLastKey = Asc("a")
        End If
    Else
        iLastKey = 0
        If InKey$ <> "" Then
            bChange = TRUE
        End If
    End If
Loop Until bFinished = TRUE ' _KeyDown(27)

End

' /////////////////////////////////////////////////////////////////////////////
' Generate random value between Min and Max inclusive.

Function RandomNumber% (Min%, Max%)
    Dim NumSpread%

    ' SET RANDOM SEED
    'Randomize ' Initialize random-number generator.
    Randomize Timer

    ' GET RANDOM # Min%-Max%
    'RandomNumber = Int((Max * Rnd) + Min) ' generate number

    NumSpread% = (Max% - Min%) + 1

    RandomNumber% = Int(Rnd * NumSpread%) + Min% ' GET RANDOM # BETWEEN Max% AND Min%
End Function ' RandomNumber%