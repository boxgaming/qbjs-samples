If Not _FullScreen Then _FullScreen

Print "This is a fullscreen test"
Print "It only works if your browser supports it"
Print
Print "Click anywhere to draw a circle"
Print "Press any key to quit"


Circle (200, 200), 100, 10
Paint (200, 200), 1, 10

Dim drawing As Integer
drawing = 0

While Not _KeyHIt
    If _MouseButton(1) Then
        If Not drawing Then
            drawing = -1
            Circle (_MouseX, _MouseY), Rnd * 30 + 10, Rnd * 14 + 1
        End If
    Else
        drawing = 0
        End If
    _Limit 30
Wend

If _FullScreen Then
    Locate 24, 1
    Print "Press any key to exit fullscreen"
    Sleep
    _FullScreen _OFF
End If