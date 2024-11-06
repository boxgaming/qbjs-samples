'Option _Explicit
'_Title "Horse Race 3" ' b+ 2023-09-12
' fix so the the list of horse is shown in order they came in at

' 2023-09-24
' Finally got this to work what a frustrating afternoon.

Const track = 100
Const nHorses = 10
Type horse
    col As Single
    loops As Integer
    colr As Integer
End Type

Screen _NewImage(120 * 8, (nHorses * 3 + 4) * 16, 12) ' 16 colors
Randomize Timer

Dim stillRunning, i
Dim horses(1 To nHorses) As horse
For i = 1 To nHorses 'load color/id number for after sort
    horses(i).colr = i
Next

stillRunning = 1
While stillRunning = 1
    stillRunning = 0 ' clear flag
    For i = 1 To nHorses
        If horses(i).col <= track Then
            horses(i).loops = horses(i).loops + 1
            stillRunning = 1 'set flag
            horses(i).col = horses(i).col + Rnd * .25
        End If
    Next
    Cls
    Print
    For i = 1 To nHorses
        Color i
        _PrintString (Int(horses(i).col) * 8, (2 * horses(i).colr) * 16), _Trim$(Str$(horses(i).loops))
        Print
    Next
    Color 15
    Locate 1, 1
    For i = 1 To nHorses
        _PrintString (100 * 8, (2 * i - 1) * 16), "|"
        Print
    Next
    _Limit 60
Wend
Color 15
_PrintString (48 * 8, 22 * 16), "And the results are in:"
QuickSort 1, nHorses, horses()
For i = 1 To nHorses
    Color horses(i).colr
    _PrintString (57 * 8, (22 + i) * 16), Str$(horses(i).colr) + " - " + Str$(horses(i).loops)
Next

Sub QuickSort (start As Long, finish As Long, array() As horse)
    Dim Hi As Long, Lo As Long, Middle As Single
    Hi = finish: Lo = start
    Middle = array(Int((Lo + Hi) / 2)).loops 'find middle of array
    Do
        Do While array(Lo).loops < Middle: Lo = Lo + 1: Loop
        Do While array(Hi).loops > Middle: Hi = Hi - 1: Loop
        If Lo <= Hi Then
            Swap array(Lo), array(Hi)
            Lo = Lo + 1: Hi = Hi - 1
        End If
    Loop Until Lo > Hi
    If Hi > start Then Call QuickSort(start, Hi, array())
    If Lo < finish Then Call QuickSort(Lo, finish, array())
End Sub