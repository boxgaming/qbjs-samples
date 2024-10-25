Import Dom From "lib/web/dom.bas"

Dom.Container().style.overflow = "scroll"
Dom.Container().style.textAlign = "left"
Dom.Container().style.backgroundColor = "#fff"
Dom.GetImage(0).style.display = "none"
Dim Shared c
c = Dom.Create("div")
c.style.padding = "20px"
c.style.color = "#333"
c.style.float = "left"

Dom.Create "h1", c, "Heading 1"
Dom.Create "h2", c, "Heading 2"
Dom.Create "h3", c, "Heading 3"
Dom.Create "h4", c, "Heading 4"
Dom.Create "h5", c, "Heading 5"
Dom.Create "h6", c, "Heading 6"

Dom.Create "p", c, "This is content in a paragraph (p) tag."
Dom.Create "b", c, "Bold content": LineBreak 2
Dom.Create "strong", c, "Strong content": LineBreak 2
Dom.Create "i", c, "Italic text": LineBreak 2
Dom.Create "em", c, "Emphasis text": LineBreak 2
Dom.Create "u", c, "Underlined text": LineBreak 2
Dom.Create "q", c, "This is a quote": LineBreak 2
Dom.Create "div", c, "This content is in a div"
Dom.Create "pre", c, "This is preformatted text. " + Chr(10) + "It respects newlines."

c = Dom.Create("div")
c.style.padding = "20px"
c.style.color = "#333"
c.style.float = "left"

Dom.Create "div", c, "Here's an image:"
Dim img
img = Dom.Create("img", c)
img.src = "https://github.com/boxgaming/gx/raw/main/project/boxgaming.png"
img.width = 200
LineBreak 3

Dom.Create "div", c, "Here's an audio control:"
Dim a
a = Dom.Create("audio", c)
a.controls = "controls"
Dim asource
asource = Dom.Create("source", a)
asource.src = "https://github.com/boxgaming/gx/raw/main/samples/santa/snd/intro.mp3"
LineBreak 2

Dom.Create "div", c, "Here's a video control:"
Dim v
v = Dom.Create("video", c)
v.controls = "controls"
v.width = 360
v.height = 240
Dim vsource
vsource = Dom.Create("source", v)
vsource.src = "https://sample-videos.com/video321/mp4/240/big_buck_bunny_240p_1mb.mp4"

c = Dom.Create("div")
c.style.padding = "20px"
c.style.color = "#333"
c.style.float = "left"

Dom.Create "div", c, "Here's an iframe:"
Dim iframe
iframe = Dom.Create("iframe", c)
iframe.src = "https://qb64.com"
'iframe.allow = "accelerometer; auto-play; encrypted-media; gyroscope"
iframe.width = 480
iframe.height = 200


Sub LineBreak (count)
    If count = undefined Then count = 1
    Dim i
    For i = 1 To count
        Dom.Create "br", c
    Next i
End Sub