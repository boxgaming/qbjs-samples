TestScreenMode 0
TestScreenMode 1
TestScreenMode 2
TestScreenMode 7
TestScreenMode 8
TestScreenMode 9
TestScreenMode 10
TestScreenMode 11
TestScreenMode 12
TestScreenMode 13
Print " Test Complete";


Sub TestScreenMode (mode As Integer)
    Dim As Integer tcols, trows
    Screen mode
    If mode = 0 Then
        tcols = _Width
        trows = _Height
    Else
        tcols = _Width \ _FontWidth
        trows = _Height \ _FontHeight
    End If
    Print "Screen"; mode
    Print "────────────────────────"
    Print "Width:       "; _Width
    Print "Height:      "; _Height
    Print "Text Columns:"; tcols
    Print "Text Rows:   "; trows
    Print "Font:        "; _Font
    Print
    Print "01234567890123456789"
    
    For i = 1 To tcols
        Locate 10, i
        Print LTrim$(RTrim$(Str$(i Mod 10)))
    Next i
    Locate 1, tcols: Print "X";
    Locate trows, tcols: Print "X";
    Locate trows, 1: Print "Press any key...";
    Sleep
End Sub