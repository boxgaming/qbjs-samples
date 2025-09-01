Import Dom From "lib/web/dom.bas"
Import Gfx From "lib/graphics/2d.bas"
Option Explicit

Dim Shared As Object tool, cp, btnUndo, chkFilled, chkRounded, grpFilled, grpRounded, grpRadius, txtRadius
CreateToolbar

Dim Shared fimage, cimage
fimage = _NewImage(_Width, _Height, 32)
cimage = _NewImage(_Width, _Height, 32)

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
                If chkRounded.checked Then
                    If chkFilled.checked Then
                        Gfx.FillRoundRect startX, startY, _MouseX-startX, _MouseY-startY, txtRadius.value, SelectedColor
                    Else
                        Gfx.RoundRect startX, startY, _MouseX-startX, _MouseY-startY, txtRadius.value, SelectedColor
                    End If
                Else
                    If chkFilled.checked Then
                        Line (startX, startY)-(_MouseX, _MouseY), SelectedColor, BF
                    Else
                        Line (startX, startY)-(_MouseX, _MouseY), SelectedColor, B
                    End If
                End If
                _Dest 0
            
            ElseIf tool.value = "Circle" Then
                PrepDrawDest
                If Abs(_MouseX - startX) > Abs(_MouseY - startY) Then
                    radius = Abs(_MouseX - startX)
                Else
                    radius = Abs(_MouseY - startY)
                End If
                If chkFilled.checked Then
                    Gfx.FillCircle startX, startY, radius, SelectedColor
                Else
                    Circle (startX, startY), radius, SelectedColor
                End If
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
    cimage = _NewImage(_Width, _Height, 32)
    _Dest cimage
End Sub

Sub OnBtnUndo
    _FreeImage cimage
    cimage = _NewImage(640, 400, 32)
    btnUndo.disabled = true
End Sub

Sub OnToolChange
    If tool.value = "Circle" Or tool.value = "Rectangle" Then
        grpFilled.style.display = "inline-block"
    Else
        grpFilled.style.display = "none"
    End If
    If tool.value = "Rectangle" Then
        grpRounded.style.display = "inline-block"
        If chkRounded.checked Then
            grpRadius.style.display = "inline-block"
        Else
            grpRadius.style.display = "none"
        End If
    Else
        grpRounded.style.display = "none"
    End If
End Sub

Sub CreateToolbar
    Dim As Object parent, panel, canvas
    parent = Dom.Create("div")
    parent.style.display = "grid"
    parent.style.gridTemplateColumns = "1fr"
    parent.style.gridTemplateRows = "auto 42px"
    
    canvas = Dom.GetImage(0)
    Dom.Add canvas, parent
    
    canvas.style.cursor = "crosshair"
    canvas.style.border = "0"
    canvas.style.margin = "0"
    
    panel = Dom.Create("div", parent)
    Dom.Create "span", panel, "Tool: "
    tool = Dom.Create("select", panel)
    Dom.Create "span", panel, "Color: "
    cp = Dom.Create("input", panel)
    cp.type = "color"
    cp.value = "#ffffff"
    Dom.Event tool, "change", @OnToolChange
    
    grpFilled = Dom.Create("div", panel)
    grpFilled.style.display = "none"
    grpFilled.style.marginLeft = "10px"
    Dom.Create "span", grpFilled, "Filled: "
    chkFilled = Dom.Create("input", grpFilled)
    chkFilled.type = "checkbox"

    grpRounded = Dom.Create("div", panel)
    grpRounded.style.display = "none"
    grpRounded.style.marginLeft = "10px"
    Dom.Create "span", grpRounded, "Rounded: "
    chkRounded = Dom.Create("input", grpRounded)
    chkRounded.type = "checkbox"
    Dom.Event chkRounded, "change", @OnToolChange
    grpRadius = Dom.Create("div", grpRounded)
    grpRadius.style.display = "inline-block"
    grpRadius.style.marginLeft = "10px"
    Dom.Create "span", grpRadius, "Radius: "
    txtRadius = Dom.Create("input", grpRadius, "10")
    txtRadius.type = "number"
    txtRadius.min = 1
    txtRadius.max = 100
    txtRadius.style.width = "40px"


    btnUndo = Dom.Create("button", panel, "Undo")
    btnUndo.style.float = "right"
    btnUndo.style.padding = "5px 10px"
    btnUndo.disabled = true
    Dom.Event btnUndo, "click", @OnBtnUndo

    panel.style.textAlign = "left"
    panel.style.padding = "5px"
    panel.style.fontFamily = "Arial, helvetica, sans-serif"
    panel.style.fontSize = ".85em"
    panel.style.borderTop = "1px solid #666"
    panel.style.margin = "0"
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
    Dom.Create "option", tool, "Circle"
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