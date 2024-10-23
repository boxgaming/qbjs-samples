Screen 12
Randomize Timer
Color _RGB(Rnd * 255, Rnd * 255, Rnd * 255)
Dim As Single X, Y, xx, yy
Dim as Integer n, i
For i = 1 TO 100000
    n = RND * 100
    If n < 1 Then
        Xp = 0
        Yp = .16 * Y
    ElseIf n >= 1 And n <= 8 Then
        Xp = .2 * X - .26 * Y
        Yp = .23 * X + .22 * Y + 1.6
    ElseIf n >= 8 And n <= 15 Then
        Xp = -.15 * X + .28 * Y
        Yp = .26 * X + .24 * Y + .44
    Else
        Xp = .85 * X + .04 * Y
        Yp = -.04 * X + .85 * Y + 1.6
    End If
    X = Xp
    Y = Yp
    xx = X * 45
    yy = Y * 45 - 225
    PSet (xx + 320, -yy + 240)
Next i