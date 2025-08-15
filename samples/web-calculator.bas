Import Dom From "lib/web/dom.bas"

Const False = 0
Const True = Not False

Dim Shared currentOp As String
Dim Shared lastNum As Double
Dim Shared opLabel As Object
Dim Shared btnPanel As Object
Dim Shared output As Object
Dim Shared newNum As Integer

_Title "Simple Web Calculator"

InitUI


Sub DoMath (n1, op, n2)
    Dim result As Double
    
    If op = "+" Then
        result = n1 + n2
        
    ElseIf op = "-" Then
        result = n1 - n2
        
    ElseIf op = "*" Then
        result = n1 * n2
    
    ElseIf op = "/" Then
        result = n1 / n2
    End If
    
    SetOutput result
End Sub

' Event handling methods

Sub OnOperation (event)
    If currentOp <> "" Then
        DoMath lastNum, currentOp, GetOutput * 1
    End If

    Dim op As String
    op = event.target.val
    
    If op = "=" Then
        lastNum = ""
        SetOp ""
    Else
        lastNum = GetOutput * 1
        SetOp op
    End If
    newNum = True
End Sub

Sub OnNumber (event)
    Dim num As String
    num = event.target.val
    If GetOutput = "0" Or newNum Then
        SetOutput num
        newNum = False
    Else
        SetOutput GetOutput + num
    End If
End Sub

Sub OnPeriod
    Dim ostr As String
    ostr = GetOutput
    
    If newNum Then
        SetOutput "0."
        newNum = False
        Exit Sub
    End If
    
    If InStr(ostr, ".") Then Exit Sub
    
    SetOutput ostr + "."
End Sub

Sub OnNegate
    Dim ostr As String
    ostr = GetOutput
    If ostr = "0" Then Exit Sub
    
    If InStr(ostr, "-") Then
        SetOutput Right(ostr, Len(ostr)-2)
    Else
        SetOutput "-" + ostr
    End If
End Sub

Sub OnClear
    SetOutput "0"
    SetOp ""
    newNum = True
End Sub

Sub OnBackspace
    If GetOutput = "0" Or newNum Then Exit Sub
    
    Dim numstr As String
    Dim l As Integer
    numstr = GetOutput
    l = Len(numstr)
    If l < 2 Then
        SetOutput "0"
    Else
        SetOutput Left$(numstr, l-1)
    End If
End Sub

Sub OnBlank
    If Dom.Confirm("I had room for an extra button!" + Chr$(10) + "Want to change the background color?") Then
        Dim As Integer r, g, b
        r = Fix(Rnd * 255)
        g = Fix(Rnd * 255)
        b = Fix(Rnd * 255)
        Dom.Container().style.backgroundColor = "#" + Hex$(r) + Hex$(g) + Hex$(b)
    End If
End Sub

' UI Helper methods

Function GetOutput
    GetOutput = output.innerText
End Function

Sub SetOutput (value As String)
    output.innerHTML = value
End Sub

Sub SetOp (op As String)
    If op = "" Then
        opLabel.innerHTML = "&nbsp;"
        currentOp = ""
    Else
        opLabel.innerHTML = lastNum + " " + op
        currentOp = op
    End If
End Sub


Sub InitUI
    'Hide the screen output
    Dim mainScreen As Object
    mainScreen = Dom.GetImage(0)
    mainScreen.style.display = "none"

    ' Style the page container
    Dim container As Object
    container = Dom.Container
    container.style.backgroundColor = "#ccc"

    Dim panel As Object
    panel = Dom.Create("div")
    panel.style.margin = "auto"
    panel.style.width = "500px"
    panel.style.border = "1px solid #999"
    panel.style.backgroundColor = "#ddd"

    ' create the current operation label
    opLabel = Dom.Create("div", panel)
    opLabel.style.textAlign = "right"
    opLabel.style.padding = "10px 20px 0px 0px"
    opLabel.innerHTML = "&nbsp;"

    ' create the output display
    output = Dom.Create("div", panel)
    output.style.padding = "0px 20px 20px 20px"
    output.style.textAlign = "right"
    output.style.fontSize = "50px"
    output.style.color = "#000"
    output.style.overflow = "auto"
    output.innerHTML = "0"

    ' create the button grid
    btnPanel = Dom.Create("div", panel)
    btnPanel.style.display = "grid"
    btnPanel.style.gridTemplateColumns = "auto auto auto auto"

    Dim btn As Object
    btn = CreateButton("C", @OnClear)
    btn = CreateButton("<", @OnBackspace)
    btn = CreateButton("",  @OnBlank)
    btn = CreateButton("/", @OnOperation)
    btn = CreateButton("9", @OnNumber)
    btn = CreateButton("8", @OnNumber)
    btn = CreateButton("7", @OnNumber)
    btn = CreateButton("*", @OnOperation)
    btn = CreateButton("6", @OnNumber)
    btn = CreateButton("5", @OnNumber)
    btn = CreateButton("4", @OnNumber)
    btn = CreateButton("-", @OnOperation)
    btn = CreateButton("3", @OnNumber)
    btn = CreateButton("2", @OnNumber)
    btn = CreateButton("1", @OnNumber)
    btn = CreateButton("+", @OnOperation)
    btn = CreateButton("+/-", @OnNegate)
    btn = CreateButton("0", @OnNumber)
    btn = CreateButton(".", @OnPeriod)
    btn = CreateButton("=", @OnOperation)
    
    OnClear
End Sub

Function CreateButton (label, callback As Sub)
    Dim btn As Object
    btn = Dom.Create("button" , btnPanel)
    btn.innerText = label
    btn.style.padding = "20px"
    btn.style.textAlign = "center"
    btn.style.fontSize = "20px"
    btn.style.margin = "1px"
    btn.val = label
    Dom.Event btn, "click", callback
    CreateButton = btn
End Function