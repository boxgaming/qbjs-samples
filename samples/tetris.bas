'Option _Explicit
'Randomize Timer
'DefLng A-Z

Type RotResult
    xx As Double
    yy As Double
End Type

Dim Shared As Double piece(6, 3, 1)
Dim Shared piece_color(6)
Dim Shared As Double size, sw, sh

size = 25
sw = 10
sh = 20

ReDim Shared As Double board(sw - 1, sh - 1)

piece(0, 0, 0) = 0: piece(0, 1, 0) = 1: piece(0, 2, 0) = 1: piece(0, 3, 0) = 0
piece(0, 0, 1) = 0: piece(0, 1, 1) = 1: piece(0, 2, 1) = 1: piece(0, 3, 1) = 0
piece(1, 0, 0) = 1: piece(1, 1, 0) = 1: piece(1, 2, 0) = 1: piece(1, 3, 0) = 1
piece(1, 0, 1) = 0: piece(1, 1, 1) = 0: piece(1, 2, 1) = 0: piece(1, 3, 1) = 0
piece(2, 0, 0) = 0: piece(2, 1, 0) = 0: piece(2, 2, 0) = 1: piece(2, 3, 0) = 1
piece(2, 0, 1) = 0: piece(2, 1, 1) = 1: piece(2, 2, 1) = 1: piece(2, 3, 1) = 0
piece(3, 0, 0) = 0: piece(3, 1, 0) = 1: piece(3, 2, 0) = 1: piece(3, 3, 0) = 0
piece(3, 0, 1) = 0: piece(3, 1, 1) = 0: piece(3, 2, 1) = 1: piece(3, 3, 1) = 1
piece(4, 0, 0) = 0: piece(4, 1, 0) = 1: piece(4, 2, 0) = 1: piece(4, 3, 0) = 1
piece(4, 0, 1) = 0: piece(4, 1, 1) = 0: piece(4, 2, 1) = 1: piece(4, 3, 1) = 0
piece(5, 0, 0) = 0: piece(5, 1, 0) = 1: piece(5, 2, 0) = 1: piece(5, 3, 0) = 1
piece(5, 0, 1) = 0: piece(5, 1, 1) = 1: piece(5, 2, 1) = 0: piece(5, 3, 1) = 0
piece(6, 0, 0) = 0: piece(6, 1, 0) = 1: piece(6, 2, 0) = 1: piece(6, 3, 0) = 1
piece(6, 0, 1) = 0: piece(6, 1, 1) = 0: piece(6, 2, 1) = 0: piece(6, 3, 1) = 1

Screen _NewImage(sw * size, sh * size, 32)

piece_color(0) = _RGB(0, 200, 0)
piece_color(1) = _RGB(200, 0, 0)
piece_color(2) = _RGB(156, 85, 211)
piece_color(3) = _RGB(219, 112, 147)
piece_color(4) = _RGB(0, 100, 250)
piece_color(5) = _RGB(230, 197, 92)
piece_color(6) = _RGB(0, 128, 128)

Dim t As Double

Dim As Double redraw, speed, lines, pause, putpiece, startx, pn, px, py, rot, n, y, x, k, shift, xx, yy
Dim As RotResult res
redraw = -1

speed = 3
lines = 0
pause = 0
putpiece = 0
startx = (sw - 4) / 2

pn = Int(Rnd * 7)
px = startx
py = 1
rot = 0

Dim title$
title$ = "lines=" + LTrim$(Str$(lines)) + ",speed=" + LTrim$(Str$(speed))
_Title title$

t = Timer

Do
    If (Timer - t) > (1 / speed) And Not pause Then
        If valid(pn, px, py + 1, rot) Then
            py = py + 1
        Else
            putpiece = -1
        End If

        t = Timer
        redraw = -1
    End If

    If putpiece Then
        If valid(pn, px, py, rot) Then
            n = place(pn, px, py, rot)
            If n Then
                lines = lines + n
                title$ = "lines=" + LTrim$(Str$(lines)) + ",speed=" + LTrim$(Str$(speed))
                _Title title$
            End If
        End If

        pn = Int(Rnd * 7)
        px = startx
        py = 0
        rot = 0

        putpiece = 0
        redraw = -1

        If Not valid(pn, px, py, rot) Then
            For y = 0 To sh - 1
                For x = 0 To sw - 1
                    board(x, y) = 0
                Next
            Next
            lines = 0
            title$ = "lines=" + LTrim$(Str$(lines)) + ",speed=" + LTrim$(Str$(speed))
            _Title title$
        End If
    End If

    If redraw Then
        Line (0, 0)-(sw * size, sh * size), _RGB(0, 0, 0), BF
        For y = 0 To sh - 1
            For x = 0 To sw - 1
                If board(x, y) <> 0 Then
                    Line (x * size, y * size)-Step(size - 2, size - 2), piece_color(board(x, y) - 1), BF
                Else
                    Line (x * size, y * size)-Step(size - 2, size - 2), _RGB(50, 50, 50), B
                End If
            Next
        Next

        For y = 0 To 1
            For x = 0 To 3
                'rotate xx, yy, x, y, pn, rot
                rotate res, x, y, pn, rot
                If piece(pn, x, y) Then Line ((px + res.xx) * size, (py + res.yy) * size)-Step(size - 2, size - 2), piece_color(pn), BF
            Next
        Next

        _Display
        redraw = 0
    End If

    k = _KeyHit
    If k Then
        shift = _KeyDown(100304) Or _KeyDown(100303)
        Select Case k
            Case 18432 'up
                If valid(pn, px, py, (rot + 1) Mod 4) Then rot = (rot + 1) Mod 4
                pause = 0
            Case 19200 'left
                If shift Then
                    For xx = 0 To sw - 1
                        If Not valid(pn, px - xx, py, rot) Then Exit For
                    Next
                    px = px - xx + 1
                Else
                    If valid(pn, px - 1, py, rot) Then px = px - 1
                End If
                pause = 0
            Case 19712 'right
                If shift Then
                    For xx = px To sw - 1
                        If Not valid(pn, xx, py, rot) Then Exit For
                    Next
                    px = xx - 1
                Else
                    If valid(pn, px + 1, py, rot) Then px = px + 1
                End If
                pause = 0
            Case 20480, 32 'down
                If shift Or k = 32 Then
                    For yy = py To sh - 1
                        If Not valid(pn, px, yy, rot) Then Exit For
                    Next
                    py = yy - 1
                    putpiece = -1
                Else
                    If valid(pn, px, py + 1, rot) Then py = py + 1
                End If
                pause = 0
            Case 112 'p
                pause = Not pause
            Case 13 'enter
                For y = 0 To sh - 1
                    For x = 0 To sw - 1
                        board(x, y) = 0
                    Next
                Next
                pn = Int(Rnd * 7)
                px = startx
                py = 0
                rot = 0
                putpiece = 0
                lines = 0
                title$ = "lines=" + LTrim$(Str$(lines)) + ",speed=" + LTrim$(Str$(speed))
                _Title title$
            Case 43, 61 'plus
                If speed < 100 Then
                    speed = speed + 1
                    title$ = "lines=" + LTrim$(Str$(lines)) + ",speed=" + LTrim$(Str$(speed))
                    _Title title$
                End If
            Case 95, 45
                If speed > 1 Then
                    speed = speed - 1
                    title$ = "lines=" + LTrim$(Str$(lines)) + ",speed=" + LTrim$(Str$(speed))
                    _Title title$
                End If
            Case 27
                Exit Do
        End Select

        redraw = -1
    End If
    _Limit 60
Loop
System

Sub rotate (res As RotResult, x, y, pn, rot)
    Dim rot_new As Double
    If pn = 0 Then
        rot_new = 0
    ElseIf pn >= 4 Then
        rot_new = rot
    Else
        rot_new = rot Mod 2
    End If

    Select Case rot_new
        Case 0
            res.xx = x
            res.yy = y
        Case 1
            res.xx = y + 2
            res.yy = 2 - x
        Case 2
            res.xx = 4 - x
            res.yy = 1 - y
        Case 3
            res.xx = 2 - y
            res.yy = x - 1
    End Select
End Sub

'Sub rotate (xx, yy, x, y, pn, rot)
'    Select Case pn
'        Case 0
'            rot_new = 0
'        Case 1 TO 3
'            rot_new = rot Mod 2
'        Case 4 TO 6
'            rot_new = rot
'    End Select

'    Select Case rot_new
'        Case 0
'            xx = x
'            yy = y
'        Case 1
'            xx = y + 2
'            yy = 2 - x
'        Case 2
'            xx = 4 - x
'            yy = 1 - y
'        Case 3
'            xx = 2 - y
'            yy = x - 1
'    End Select
'End Sub

Function valid (pn, px, py, rot)
    Dim As Double x, y
    Dim res As RotResult
    For y = 0 To 1
        For x = 0 To 3
            rotate res, x, y, pn, rot
            If py + res.yy >= 0 Then
                If piece(pn, x, y) Then
                    If (px + res.xx >= sw) Or (px + res.xx < 0) Then
                        valid = 0
                        Exit Function
                    End If
                    If (py + res.yy >= sh) Then
                        valid = 0
                        Exit Function
                    End If
                    If (py >= 0) Then
                        If board(px + res.xx, py + res.yy) Then
                            valid = 0
                            Exit Function
                        End If
                    End If
                End If
            End If
        Next
    Next

    valid = -1
End Function

Function place (pn, px, py, rot)
    Dim As Double lines, x, y
    Dim As RotResult res
    lines = 0

    For y = 0 To 1
        For x = 0 To 3
            rotate res, x, y, pn, rot
            If py + res.yy >= 0 Then
                If piece(pn, x, y) Then board(px + res.xx, py + res.yy) = pn + 1
            End If
        Next
    Next

    'clear lines
    Dim clr As Double
    For y = py - 1 To py + 2
        If y >= 0 And y < sh Then
            clr = -1
            For x = 0 To sw - 1
                If board(x, y) = 0 Then
                    clr = 0
                    Exit For
                End If
            Next

            If clr Then
                lines = lines + 1
                For res.yy = y To 1 Step -1
                    For x = 0 To sw - 1
                        board(x, res.yy) = board(x, res.yy - 1)
                    Next
                Next
            End If
        End If
    Next

    place = lines
End Function
