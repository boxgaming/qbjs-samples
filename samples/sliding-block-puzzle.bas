'Option _Explicit
_Title "Sliding Blocks Puzzle"
Randomize Timer
Dim As Long s, q, r, c, c0, r0, i, update, solved, mc, test, mb, mx, my, bx, by
Dim As Double t
Dim flash$

Do ' get from user the desired board size = s
    Locate 1, 3: Input "(0 quits) Enter your number of blocks per side 3 - 9 you want > ", s
    If s = 0 Then End
Loop Until s > 2 And s < 10

' screen setup: based on the square blocks q pixels a sides
q = 540 / s 'square size, shoot for 540 x 540 pixel board display
Screen _NewImage(q * s + 1, q * s + 1, 32) ': _ScreenMove 360, 60

'initialize board = solution
Dim board(s, s)
For r = 1 To s
    For c = 1 To s
        board(c, r) = c + (r - 1) * s
    Next
Next
board(s, s) = 0: c0 = s: r0 = s
Do
    For i = 0 To s ^ 5 ' mix up blocks
        Select Case Int(Rnd * 4) + 1
            Case 1: If c0 < s Then board(c0, r0) = board(c0 + 1, r0): board(c0 + 1, r0) = 0: c0 = c0 + 1
            Case 2: If c0 > 1 Then board(c0, r0) = board(c0 - 1, r0): board(c0 - 1, r0) = 0: c0 = c0 - 1
            Case 3: If r0 < s Then board(c0, r0) = board(c0, r0 + 1): board(c0, r0 + 1) = 0: r0 = r0 + 1
            Case 4: If r0 > 1 Then board(c0, r0) = board(c0, r0 - 1): board(c0, r0 - 1) = 0: r0 = r0 - 1
        End Select
    Next
    t = Timer: mc = 0: update = -1 'OK user here you go!
    Do
        If update Then 'display status and determine if solved
            solved = -1: update = 0
            For r = 1 To s
                For c = 1 To s
                    If board(c, r) Then
                        If board(c, r) <> (r - 1) * s + c Then solved = 0
                        Color _RGB32(255, 255, 255), _RGB32(0, 0, 255)
                        Line ((c - 1) * q + 1, (r - 1) * q + 2)-(c * q - 2, r * q - 2), _RGB32(0, 0, 255), BF
                        _PrintString ((c - 1) * q + .4 * q, (r - 1) * q + .4 * q), Right$(" " + Str$(board(c, r)), 2)
                    Else
                        If board(s, s) <> 0 Then solved = 0
                        Color _RGB32(0, 0, 0), _RGB32(0, 0, 0)
                        Line ((c - 1) * q, (r - 1) * q)-(c * q, r * q), , BF
                    End If
                Next
            Next
            If solved Then 'flash the Solved Report then restart
                flash$ = "Solved!  " + Str$(mc) + " Moves in " + _Trim$(Str$(Int(Timer - t))) + " secs."
                For i = 1 To 30: _Title flash$: _Delay .1: _Title "  ": _Delay .1: Next
                Exit Do
            Else
                _Title Str$(mc) + " Moves in " + _Trim$(Str$(Int(Timer - t))) + " secs."
            End If
        End If
        While _MouseInput: Wend
        mb = _MouseButton(1): mx = _MouseX: my = _MouseY
        If mb And solved = 0 Then
            _Delay .25 ' for user to release mb
            'convert mouse position to board array (x, y) are we near empty space?
            bx = Int(mx / q) + 1: by = Int(my / q) + 1: update = -1
            If bx = c0 + 1 And by = r0 Then
                board(c0, r0) = board(c0 + 1, r0): board(c0 + 1, r0) = 0: c0 = c0 + 1: mc = mc + 1
            ElseIf bx = c0 - 1 And by = r0 Then
                board(c0, r0) = board(c0 - 1, r0): board(c0 - 1, r0) = 0: c0 = c0 - 1: mc = mc + 1
            ElseIf bx = c0 And by = r0 + 1 Then
                board(c0, r0) = board(c0, r0 + 1): board(c0, r0 + 1) = 0: r0 = r0 + 1: mc = mc + 1
            ElseIf bx = c0 And by = r0 - 1 Then
                board(c0, r0) = board(c0, r0 - 1): board(c0, r0 - 1) = 0: r0 = r0 - 1: mc = mc + 1
            End If
        End If
        _Limit 60
    Loop
Loop
