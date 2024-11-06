Dim Shared As Integer board(4, 4)
Dim Shared As Integer r0, c0, d
Dim As Integer r, c, i, solved
Dim As String b, k
For r = 1 To 4
    For c = 1 To 4
        board(c, r) = c + (r - 1) * 4
    Next
Next
board(4, 4) = 0
c0 = 4
r0 = 4
Cls
For i = 0 To 50 * 4 * 4
    d = Val(Mid$("0358", Int(Rnd * 4) + 1, 1))
    handle
Next
While 1
    Locate 1, 1
    b = ""
    solved = 1
    For r = 1 To 4
        For c = 1 To 4
            If board(c, r) Then
                If board(c, r) <> c + (r - 1) * 4 Then
                    solved = 0
                End If
                b = b + Right$("   " + Str$(board(c, r)), 3) + " "
            Else
                b = b + "    "
            End If
        Next
        Print b
        b = ""
    Next
    Print
    If solved Then
        Locate 4 + 2, 2
        Print "Solved!"
        _Delay 5
        'End
    End If
    k = InKey$
    If Len(k) = 2 Then
        d = (Asc(Right$(k, 1)) - 72)
        handle
    End If
    _Limit 30
Wend

Sub handle
    Select Case d
        Case 3
            If c0 < 4 Then
                board(c0, r0) = board(c0 + 1, r0)
                board(c0 + 1, r0) = 0
                c0 = c0 + 1
            End If
        Case 5
            If c0 > 1 Then
                board(c0, r0) = board(c0 - 1, r0)
                board(c0 - 1, r0) = 0
                c0 = c0 - 1
            End If
        Case 0
            If r0 < 4 Then
                board(c0, r0) = board(c0, r0 + 1)
                board(c0, r0 + 1) = 0
                r0 = r0 + 1
            End If
        Case 8
            If r0 > 1 Then
                board(c0, r0) = board(c0, r0 - 1)
                board(c0, r0 - 1) = 0
                r0 = r0 - 1
            End If
    End Select
End Sub