Import Dom From "lib/web/dom.bas"
Import Gfx From "lib/graphics/2d.bas"
Import Stx From "lib/lang/string.bas"
Import FS From "lib/io/fs.bas"
Option Explicit

Dim Shared As Object selTool, cp, btnUndo, btnSave, chkFilled, chkRounded
Dim Shared As Object grpFilled, grpRounded, grpRadius, grpLineWidth, grpLineStyle, grpColor
Dim Shared As Object txtRadius, txtLineWidth, selLineStyle
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
            btnSave.disabled = false
        Else
            Gfx.LineWidth txtLineWidth.value
            If selTool.value = "Freehand" Then
                _Dest cimage
                Gfx.LineCap Gfx.ROUND
                Gfx.LineDashOff
                Line (lastX, lastY)-(_MouseX, _MouseY), SelectedColor
                lastX = _MouseX
                lastY = _MouseY
                _Dest 0
                
            ElseIf selTool.value = "Line" Then
                PrepDrawDest
                Line (startX, startY)-(_MouseX, _MouseY), SelectedColor
                _Dest 0

            ElseIf selTool.value = "Rectangle" Then
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

            ElseIf selTool.value = "Invert Rectangle" Then
                PrepDrawDest
                _PutImage , fimage, cimage
                Gfx.InvertRect startX, startY, _MouseX-startX, _MouseY-startY, chkFilled.checked
                _Dest 0
            
            ElseIf selTool.value = "Circle" Then
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

            ElseIf selTool.value = "Ellipse" Then
                Dim xradius, yradius
                PrepDrawDest
                xradius = Abs(_MouseX - startX)
                yradius = Abs(_MouseY - startY)
                If chkFilled.checked Then
                    Gfx.FillEllipse startX, startY, xradius, yradius, 1, SelectedColor
                Else
                    Gfx.Ellipse startX, startY, xradius, yradius, 1, SelectedColor
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
    Gfx.LineCap Gfx.DEFAULT
    SetLineStyle
End Sub

Sub SetLineStyle
    Dim w As Integer
    If selLineStyle.value = "Solid" Then
        Gfx.LineDashOff
    ElseIf selLineStyle.value = "Dotted" Then
        w = txtLineWidth.value
        Gfx.LineDash w, w
    ElseIf selLineStyle.value = "Dashed" Then
        w = txtLineWidth.value * 4
        Gfx.LineDash w, w
    End If
End Sub

Sub OnUndo
    _FreeImage cimage
    cimage = _NewImage(640, 400, 32)
    btnUndo.disabled = true
End Sub

Sub OnToolChange
    If selTool.value = "Circle" Or selTool.value = "Ellipse" Or _
       selTool.value = "Rectangle" Or selTool.value = "Invert Rectangle" Then
        grpFilled.style.display = "inline-block"
        If chkFilled.checked Then
            grpLineWidth.style.display = "none"
            grpLineStyle.style.display = "none"
        Else
            grpLineWidth.style.display = "inline-block"
            grpLineStyle.style.display = "inline-block"
        End If
    Else
        grpFilled.style.display = "none"
        chkFilled.checked = false
    End If
    If selTool.value = "Rectangle" Then
        grpRounded.style.display = "inline-block"
        If chkRounded.checked Then
            grpRadius.style.display = "inline-block"
        Else
            grpRadius.style.display = "none"
        End If
    Else
        grpRounded.style.display = "none"
        chkRounded.checked = false
    End If
    If selTool.value = "Freehand" Then
        grpLineWidth.style.display = "inline-block"
        grpLineStyle.style.display = "none"
    ElseIf selTool.value = "Line" Then
        grpLineStyle.style.display = "inline-block"
    End If
 
    If selTool.value = "Invert Rectangle" Then
        grpColor.style.display = "none"
    Else
        grpColor.style.display = "inline-block"
    End If
End Sub

Sub OnSave
    Gfx.SaveImage 0, "masterpiece.png"
    FS.DownloadFile "masterpiece.png"
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
    
    Dim grpTool As Object
    panel = Dom.Create("div", parent)
    grpTool = CreateControlGroup("Tool", panel)
    grpTool.style.display = "inline-block"
    selTool = Dom.Create("select", grpTool)
    selTool.style.verticalAlign = "middle"
    InitList selTool, "Freehand,Line,Rectangle,Invert Rectangle,Circle"
    Dom.Create "option", selTool, "Ellipse"
    Dom.Event selTool, "change", @OnToolChange

    ' Fill settings
    grpFilled = CreateControlGroup("Filled", panel)
    chkFilled = Dom.Create("input", grpFilled)
    chkFilled.type = "checkbox"
    Dom.Event chkFilled, "change", @OnToolChange

    ' Rounded settings
    grpRounded = CreateControlGroup("Rounded", panel)
    chkRounded = Dom.Create("input", grpRounded)
    chkRounded.type = "checkbox"
    Dom.Event chkRounded, "change", @OnToolChange
    grpRadius = CreateControlGroup("Radius", grpRounded)
    txtRadius = Dom.Create("input", grpRadius, "10")
    txtRadius.type = "number"
    txtRadius.min = 1
    txtRadius.max = 100
    txtRadius.style.width = "40px"
    txtRadius.style.height = "20px"

    ' Line Width
    grpLineWidth = CreateControlGroup("Line Width", panel)
    txtLineWidth = Dom.Create("input", grpLineWidth, "2")
    txtLineWidth.type = "number"
    txtLineWidth.min = 1
    txtLineWidth.max = 100
    txtLineWidth.style.width = "40px"
    txtLineWidth.style.height = "20px"
    
    'Line Style
    grpLineStyle = CreateControlGroup("Style", panel)
    selLineStyle = Dom.Create("select", grpLineStyle)
    InitList selLineStyle, "Solid,Dotted,Dashed" 

    ' Color Picker
    grpColor = CreateControlGroup("Color", panel)
    cp = Dom.Create("input", grpColor)
    cp.type = "color"
    cp.value = "#ffffff"

    ' Save Button
    btnSave = Dom.Create("button", panel, "Save")
    btnSave.style.float = "right"
    btnSave.style.padding = "5px 10px"
    btnSave.style.marginLeft = "5px"
    btnSave.disabled = true
    Dom.Event btnSave, "click", @OnSave

    ' Undo Button
    btnUndo = Dom.Create("button", panel, "Undo")
    btnUndo.style.float = "right"
    btnUndo.style.padding = "5px 10px"
    btnUndo.disabled = true
    Dom.Event btnUndo, "click", @OnUndo

    panel.style.textAlign = "left"
    panel.style.padding = "5px"
    panel.style.borderTop = "1px solid #666"
    panel.style.margin = "0"
    panel.style.backgroundColor = "#333"
    panel.style.verticalAlign = "middle"

    'InitToolList
    OnToolChange
End Sub

Function CreateControlGroup(labelText As String, parent As Object)
    Dim grp As Object
    grp = Dom.Create("div", parent)
    grp.style.display = "none"
    grp.style.marginRight = "10px"
    grp.style.verticalAlign = "middle"
    Dom.Create "span", grp, labelText + ": "
    CreateControlGroup = grp
End Function

Sub InitList (sel As Object, options As String)
    sel.style.padding = "4px"
    ReDim opts(0) As String
    Stx.Split options, ",", opts
    Dim i As Integer
    For i = 1 To UBound(opts)
        Dom.Create "option", sel, opts(i)
    Next i
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