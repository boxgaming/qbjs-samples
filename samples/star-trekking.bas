'Option _Explicit ' try for QBJS 2023-08-26
_Title "Starfield Simulation" ' a mod of a codehunter post

Dim Shared Width As Integer
Dim Shared Height As Integer
Dim Shared CenterX As Integer
Dim Shared CenterY As Integer

CreateCanvas 600, 600
Window (-Width, -Height)-(Width, Height)

' Translate the Star Class into a UDT (User Defined Type)
Type newStar
    x As Single
    y As Single
    z As Single
    pz As Single
End Type

' Define how many Stars
Dim Shared starCount As Integer
Dim As Integer i, done
Dim sx, sy, px, py

starCount = 800

' Setup the Stars
Dim Shared Stars(starCount) As newStar

For i = 1 To starCount
    Stars(i).x = p5random(-Width, Width)
    Stars(i).y = p5random(-Height, Height)
    Stars(i).z = p5random(0, Width)
    Stars(i).pz = Stars(i).z
Next

Dim Shared Speed As Integer
Speed = 5

Do
    _Limit 60

    Line (-_Width, -_Height)-(Width - 1, Height - 1), _RGBA32(0, 0, 0, 30), BF

    For i = 1 To starCount
        Stars(i).z = Stars(i).z - Speed

        If Stars(i).z < 1 Then
            Stars(i).x = p5random(-Width, Width)
            Stars(i).y = p5random(-Width, Height)

            Stars(i).z = Width
            Stars(i).pz = Stars(i).z
        End If

        sx = map(Stars(i).x / Stars(i).z, 0, 1, 0, Width)
        sy = map(Stars(i).y / Stars(i).z, 0, 1, 0, Height)
        Circle (sx, sy), map(Stars(i).z, 0, Width, 2, 0)

        px = map(Stars(i).x / Stars(i).pz, 0, 1, 0, Width)
        py = map(Stars(i).y / Stars(i).pz, 0, 1, 0, Height)
        Stars(i).pz = Stars(i).z
        Line (px, py)-(sx, sy)
    Next

    _Display
Loop Until done

' p5.js Functions
Function map (value, minRange, maxRange, newMinRange, newMaxRange)
    map = ((value - minRange) / (maxRange - minRange)) * (newMaxRange - newMinRange) + newMinRange
End Function

Function p5random (mn, mx)
    If mn > mx Then
        Swap mn, mx
    End If

    p5random = Rnd * (mx - mn) + mn
End Function

Sub CreateCanvas (x As Integer, y As Integer)
    ' Define the screen
    Width = x
    Height = y

    ' Center of the screen
    CenterX = x \ 2
    CenterY = y \ 2

    ' Create the screen
    Screen _NewImage(Width, Height, 32)
End Sub
