'Pongy - by SierraKen
'Made on October 30, 2024

'Thanks to the QB64 Phoenix Forum for the inspiration and past help.
'Thanks also to Chat GPT for the math code.

'How to play: Use Mouse to bounce the white ball and try to aim it toward the moving goal slot above without having the white ball hit the red ball.
'You start out with 5 balls. Feel free to change the variable ball number below to your needs.


Do
    Dim score As Single
    Dim ball As Single
    Dim boxRight As Single
    Dim boxLeft As Single
    Dim BoxTop As Single
    Dim BoxBottom As Single
    Dim a As String
    Dim ag As String
    Dim mousex As Single
    Dim mousey As Single
    score = 0
    ball = 5

    ' Set box boundaries
    boxLeft = 25
    boxRight = 775
    BoxTop = 25
    BoxBottom = 575


    Cls
    Screen _NewImage(800, 600, 32)
    ' Ball properties
    Dim As Integer ballX, ballY, ballx2, bally2
    Dim As Single angle, angle2
    Dim As Integer speedX, speedY, speedx2, speedy2
    ballX = (boxRight + boxLeft) / 2 ' Start in the center
    ballY = (BoxTop + BoxBottom) / 2
    angle = 45 ' Starting angle in degrees

    ballx2 = (boxRight + boxLeft) / 2 ' Start in the center
    bally2 = (BoxTop + BoxBottom) / 2 + 100
    angle2 = 45 ' Starting angle in degrees


    ' Convert angle to radians
    Dim As Single radAngle
    radAngle = angle * 3.14159265 / 180

    Dim As Single radAngle2
    radAngle2 = angle2 * 3.14159265 / 180

    Dim goalx As Single
    Dim goaly As Single
    Dim goaldir As Single
    Dim redballout As Single
    Dim starx As Single
    Dim stary As Single


    ' Set speed based on angle
    speedX = Cos(radAngle) * 5
    speedY = Sin(radAngle) * 5

    speedx2 = Cos(radAngle2) * 5
    speedy2 = Sin(radAngle2) * 5

    goalx = 325: goaly = 20
    goaldir = 1
    redballout = 5


    _Title "Pongy - by SierraKen"

    Randomize Timer

    Do
        Cls
        a = InKey$
        If a = Chr$(27) Then End
        ' Draw box boundaries
        Line (boxLeft - 5, BoxTop - 5)-(boxRight + 5, BoxBottom + 5), _RGB32(255, 255, 255), B
        Line (goalx, goaly)-(goalx + 100, goaly), _RGB32(1, 1, 1)
        goalx = goalx + goaldir
        If goalx = 680 And goaldir = 1 Then goaldir = -1
        If goalx = 20 And goaldir = -1 Then goaldir = 1
        ' Draw the ball
        fillCircle ballX, ballY, 10, _RGB32(255, 255, 255)
        If redballout = 0 Then fillCircle ballx2, bally2, 20, _RGB32(255, 0, 0)

        While _MouseInput: Wend
        mousex = _MouseX
        mousey = _MouseY
        fillCircle mousex, mousey, 20, _RGB32(0, 255, 0)

        ' Update ball position
        ballX = ballX + speedX
        ballY = ballY + speedY
        If redballout = 0 Then
            ballx2 = ballx2 + speedx2
            bally2 = bally2 + speedy2
        End If
        If ballX > goalx And ballX < goalx + 100 And ballY < 26 Then
            score = score + 1: ballX = 375: ballY = 275: speedY = -speedY
            'For snd = 300 To 900 Step 50
                'Sound snd, .5
            'Next snd
        End If

        Locate 1, 20: Print "Score: "; score
        Locate 1, 70: Print "Balls: "; ball

        ' Check for collision with box boundaries
        If ballX <= boxLeft Or ballX >= boxRight Then
            speedX = -speedX ' Reflect on the X axis
            If redballout > 0 Then redballout = redballout - 1
            'Sound 600, .5
        End If
        If ballY <= BoxTop Or ballY >= BoxBottom Then
            speedY = -speedY ' Reflect on the Y axis
            If redballout > 0 Then redballout = redballout - 1
            'Sound 600, .5
        End If
        If ballY > BoxBottom + .4 Then ballY = BoxBottom - 7
        If ballY < BoxTop - .4 Then ballY = BoxTop + 7
        If ballX > boxRight + .4 Then ballX = boxRight - 7
        If ballX < boxLeft - .4 Then ballX = boxLeft + 7
        'If redballout > 0 Then GoTo skip:
        If (ballx2 <= boxLeft Or ballx2 >= boxRight) And redballout = 0 Then
            speedx2 = -speedx2 ' Reflect on the X axis
            'Sound 600, .5
        End If
        If (bally2 <= BoxTop Or bally2 >= BoxBottom) And redballout = 0 Then
            speedy2 = -speedy2 ' Reflect on the Y axis
            'Sound 600, .5
        End If
        If bally2 > BoxBottom + .4 And redballout = 0 Then bally2 = BoxBottom - 7
        If bally2 < BoxTop - .4 And redballout = 0 Then bally2 = BoxTop + 7
        If ballx2 > boxRight + .4 And redballout = 0 Then ballx2 = boxRight - 7
        If ballx2 < boxLeft - .4 And redballout = 0 Then ballx2 = boxLeft + 7
        'skip:

        ' Check for collision with mouse position
        If Sqr((mousex - ballX) ^ 2 + (mousey - ballY) ^ 2) < 40 Then
            ' Calculate deflection angle
            radAngle = _Atan2(ballY - mousey, ballX - mousex) ' * 180 / 3.14159265
            'radAngle = angle * 3.14159265 / 180
            speedX = Cos(radAngle) * 5
            speedY = Sin(radAngle) * 5
            ballX = ballX + speedX
            ballY = ballY + speedY
            'Sound 600, .5
        End If

        ' Check for collision between red ball and white ball.
        'If redballout > 0 Then GoTo skip2:
        If Sqr((ballx2 - ballX) ^ 2 + (bally2 - ballY) ^ 2) < 50 And redballout = 0 Then
            fillCircle ballX, ballY, 20, _RGB32(0, 0, 0)
            snd = 300
            _AutoDisplay
            starx = ballX: stary = ballY
            For t = 1 To 25
                fillCircle starx, stary, t * 5, _RGB32(255, 255, 255)
                'Sound snd - t, .5
            Next t
            redballout = 5
            Locate 1, 70: ball = ball - 1: Print "Balls: "; ball
            If ball = 0 Then
                _AutoDisplay
                Locate 20, 40: Print "G A M E  O V E R":
                Locate 25, 40
                Print "Again (Y/N)?"
                Do
                    ag = InKey$
                    If ag = "y" Or ag = "Y" Then Exit Do
                    If ag = "n" Or ag = "N" Then End
                Loop
                Exit Do
            End If
            'Sound 600, .5
        End If
        'skip2:

        _Display
        _Limit 60 ' Limit the speed of the loop to 60 FPS
    Loop
Loop

'from Steve Gold standard
Sub fillCircle (CX As Integer, CY As Integer, R As Integer, C As _Unsigned Long)
    Dim Radius As Integer, RadiusError As Integer
    Dim X As Integer, Y As Integer
    Radius = Abs(R): RadiusError = -Radius: X = Radius: Y = 0
    If Radius = 0 Then PSet (CX, CY), C: Exit Sub
    Line (CX - X, CY)-(CX + X, CY), C, BF
    While X > Y
        RadiusError = RadiusError + Y * 2 + 1
        If RadiusError >= 0 Then
            If X <> Y + 1 Then
                Line (CX - Y, CY - X)-(CX + Y, CY - X), C, BF
                Line (CX - Y, CY + X)-(CX + Y, CY + X), C, BF
            End If
            X = X - 1
            RadiusError = RadiusError - X * 2
        End If
        Y = Y + 1
        Line (CX - X, CY - Y)-(CX + X, CY - Y), C, BF
        Line (CX - X, CY + Y)-(CX + X, CY + Y), C, BF
    Wend
End Sub





