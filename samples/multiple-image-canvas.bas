Import Dom From "lib/web/dom.bas"

Dim Shared c, ccount, speed, cimg
Dim i

InitControls

Do
    Cls , 15
    For i = 1 To ccount.value
        Circle (Rnd * 620, Rnd * 380), 5 + Rnd * 50, 1 + Rnd * 14
    Next i
    _Limit speed.value
Loop

Color 0, 15
Locate 13, 36
Print "Game Over"

Sub OnAddSquare
    Dim x, y, size
    x = Rnd * 180
    y = Rnd * 80
    size = 5 + Rnd * 50
    _Dest cimg
    Line (x, y)-(x+size, y+size), Rnd * 14, B
    _Dest 0
End Sub

Sub InitControls
    Dim main, container
    main = Dom.GetImage(0)
    main.style.border = "1px solid #ccc"
    container = Dom.Container
    container.style.overflow = "scroll"
    container.style.textAlign = "left"
    container.style.backgroundColor = "#fff"
    
    c = Dom.Create("div")
    c.style.padding = "20px"
    c.style.color = "#333"
    
    Dom.Create "div", c, "This is the main screen canvas:"
    Dom.Add main, c
    Dom.Create "br", c
    
    Dom.Create "span", c, "Circles: "
    ccount = Dom.Create("input", c)
    ccount.type = "range"
    ccount.min = 1
    ccount.max = 300
    ccount.style.width = "250px"
    ccount.style.verticalAlign = "middle"
    
    Dim s
    s = Dom.Create("span", c, "Speed: ")
    s.style.marginLeft = "20px"
    speed = Dom.Create("input", c)
    speed.type = "range"
    speed.style.verticalAlign = "middle"
    speed.style.width = "250px"  
    speed.min = 1
    speed.max = 60
    speed.value = 10

    Dom.Create "br", c
    Dom.Create "br", c
    Dom.Create "div", c, "This is a second image:"
    cimg = _NewImage(200, 100)
    Dim dimg
    dimg = Dom.GetImage(cimg)
    dimg.style.border = "1px solid #ccc"
    dimg.style.backgroundColor = "#efefef"
    dimg.style.marginBottom = "5px"
    Dom.Add dimg, c
    Dom.Create "br", c
    Dim btn
    btn = Dom.Create("button", c, "Add Square")
    btn.onclick = sub_OnAddSquare
End Sub