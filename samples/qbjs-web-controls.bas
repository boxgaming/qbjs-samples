Import Dom From "lib/web/dom.bas"

Dom.Container().style.overflow = "scroll"
Dom.Container().style.textAlign = "left"
Dom.Container().style.backgroundColor = "#fff"
Dom.GetImage(0).style.display = "none"
Dim c
c = Dom.Create("div")
c.style.padding = "20px"
c.style.color = "#333"
Dom.Create("a", c, "Link").href = "#"
AddInput "button"
AddInput "checkbox"
AddInput "color"
AddInput "date"
AddInput "datetime-local"
AddInput "email"
AddInput "file"
AddInput "hidden"
AddInput "image"
AddInput "month"
AddInput "number"
AddInput "password"
AddInput "radio"
AddInput "range"
AddInput "reset"
AddInput "search"
AddInput "submit"
AddInput "tel"
AddInput "text"
AddInput "time"
AddInput "url"
AddInput "week"
Dim e
e = AddControl("button", "I'm a Button, Push Me!")
e = AddControl("textarea", "I'm a Text Area, you can type in here!")
e = AddControl("select")
Dom.Create "option", e, "Option 1"
Dom.Create "option", e, "Option 2"
Dom.Create "option", e, "Option 3"

Function AddControl (t, text)
    Dim d, s, ctrl
    d = Dom.Create("div")
    Dom.Add d, c
    d.style.padding = "3px"
    s = Dom.Create("span", d, t)
    s.style.display = "inline-block"
    s.style.width = "150px"
    ctrl = Dom.Create(t, d, text)
    AddControl = ctrl
End Function

Sub AddInput (t)
    Dim d, s
    d = Dom.Create("div")
    Dom.Add d, c
    d.style.padding = "3px"
    s = Dom.Create("span", d, "input:" + t)
    s.style.display = "inline-block"
    s.style.width = "150px"
    i = Dom.Create("input", d)
    i.type = t
    Dom.Event i, "change", sub_OnInputChange
    If t = "button" Then i.value = "I'm an Input Button, Push Me!"
End Sub
    
Sub OnInputChange (e)
    Dom.Alert e.target.type + " changed: [" + e.target.value + "]"
End Sub
