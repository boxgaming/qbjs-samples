Dim drawing As Integer
Do
    If _MouseButton(1) Then
        If Not drawing Then
            PSet (_MouseX, _MouseY)
            drawing = -1
        Else
            Line -(_MouseX, _MouseY)
        End If
    Else 
        drawing = 0
    End If
    _Limit 30
Loop