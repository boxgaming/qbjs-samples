Import Dom From "lib/web/dom.bas"

Dim Shared tool, cp, btnUndo
CreateToolbar

Dim fimage, cimage
fimage = _NewImage(_Width, _Height)
cimage = _NewImage(_Width, _Height)

Dim drawing, lastX, lastY, startX, startY, radius
Do
    If _Resize Then
        Dim tmp 
        tmp = fimage
        Screen _NewImage(_ResizeWidth - 2, _ResizeHeight - 42)
        fimage = _NewImage(_ResizeWidth - 2, _ResizeHeight - 42)
        _PutImage (0, 0), tmp, fimage
    End If

    If _MouseButton(1) Then
        If Not drawing Then
            _PutImage (0, 0), cimage, fimage
            _FreeImage cimage
            cimage = _NewImage(_Width, _Height)
            lastX = _MouseX
            lastY = _MouseY
            startX = lastX
            startY = lastY
            drawing = -1
            btnUndo.disabled = false
        Else
            If tool.value = "Freehand" Then
                _Dest cimage
                Line (lastX, lastY)-(_MouseX, _MouseY), SelectedColor
                lastX = _MouseX
                lastY = _MouseY
                _Dest 0
                
            ElseIf tool.value = "Line" Then
                PrepDrawDest
                Line (startX, startY)-(_MouseX, _MouseY), SelectedColor
                _Dest 0

            ElseIf tool.value = "Rectangle" Then
                PrepDrawDest
                Line (startX, startY)-(_MouseX, _MouseY), SelectedColor, B
                _Dest 0

            ElseIf tool.value = "Filled Rectangle" Then
                PrepDrawDest
                Line (startX, startY)-(_MouseX, _MouseY), SelectedColor, BF
                _Dest 0

            ElseIf tool.value = "Circle" Then
                PrepDrawDest
                If Abs(_MouseX - startX) > Abs(_MouseY - startY) Then
                    radius = Abs(_MouseX - startX)
                Else
                    radius = Abs(_MouseY - startY)
                End If
                Circle (startX, startY), radius, SelectedColor
                _Dest 0

            ElseIf tool.value = "Filled Circle" Then
                PrepDrawDest
                If Abs(_MouseX - startX) > Abs(_MouseY - startY) Then
                    radius = Abs(_MouseX - startX)
                Else
                    radius = Abs(_MouseY - startY)
                End If
                Dim r
                For r = 0 To radius Step .3
                    Circle (startX, startY), r, SelectedColor
                Next r
                _Dest 0
            End If
        End If
    Else 
        drawing = 0
    End If
    Cls
    _PutImage (0, 0), fimage
    _PutImage (0, 0), cimage
    _Limit 30
Loop  

Sub PrepDrawDest
    _FreeImage cimage
    cimage = _NewImage(_Width, _Height)
    _Dest cimage
End Sub

Sub OnBtnUndo
    _FreeImage cimage
    cimage = _NewImage(640, 400)
    btnUndo.disabled = true
End Sub

Sub CreateToolbar
    Dom.GetImage(0).style.cursor = "crosshair"
    Dom.GetImage(0).style.position = "absolute"
    Dom.GetImage(0).style.border = "0"
    Dom.GetImage(0).style.margin = "0"
    Dom.GetImage(0).style.top = "1px"
    Dom.GetImage(0).style.left = "1px"
    
    Dim panel
    panel = Dom.Create("div")
    Dom.Create "span", panel, "Tool: "
    tool = Dom.Create("select", panel)
    Dom.Create "span", panel, "Color: "
    cp = Dom.Create("input", panel)
    cp.type = "color"
    cp.value = "#ffffff"
    
    btnUndo = Dom.Create("button", panel, "Undo")
    btnUndo.style.float = "right"
    btnUndo.style.padding = "5px 10px"
    btnUndo.disabled = true
    Dom.Event btnUndo, "click", sub_OnBtnUndo

    panel.style.textAlign = "left"
    panel.style.position = "absolute"
    panel.style.bottom = "2px"
    panel.style.left = "2px"
    panel.style.right = "2px"
    panel.style.padding = "5px"
    panel.style.fontFamily = "Arial, helvetica, sans-serif"
    panel.style.fontSize = ".85em"
    panel.style.border = "1px solid #666"
    panel.style.backgroundColor = "#333"
    panel.style.verticalAlign = "middle"

    InitToolList
End Sub
    
Sub InitToolList
    tool.style.marginRight = "15px"
    tool.style.padding = "5px"
    tool.style.verticalAlign = "top"
    Dom.Create "option", tool, "Freehand"
    Dom.Create "option", tool, "Line"
    Dom.Create "option", tool, "Rectangle"
    Dom.Create "option", tool, "Filled Rectangle"
    Dom.Create "option", tool, "Circle"
    Dom.Create "option", tool, "Filled Circle"
End Sub
    
Function SelectedColor    
    Dim r, g, b, c
    c = cp.value

    $If Javascript
        r = parseInt(c.substr(1,2), 16)
        g = parseInt(c.substr(3,2), 16)
        b = parseInt(c.substr(5,2), 16)
    $End If
        
    SelectedColor = _RGB(r, g, b)
End Function