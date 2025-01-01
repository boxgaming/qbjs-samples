Import Dom From "lib/web/dom.bas"
'Import Console From "lib/web/console.bas"

Const BASE_URL = "?src=https://raw.githubusercontent.com/boxgaming/qbjs-samples/refs/heads/main/samples/"

Dim Shared As Object amap(), cmap()
ReDim Shared As String alist(0), clist(0)
Dim Shared lastSelected As String

Dim o As Object
o = Dom.GetImage(0)
o.style.display = "none"
o = Dom.Container
o.style.textAlign = "left"
o.style.overflow = "hidden"
o.style.fontFamily = "arial, helvetica, sans-serif"
o.style.fontSize = "14px"

Dim style As Object
style = Dom.Create("style")
style.innerText = "a, a:visited { color: rgb(69, 118, 147); }"

Dim panel As Object
panel = Dom.Create("div")
panel.style.display = "grid"
panel.style.gridTemplateColumns = "300px auto"

Dim As Object lpanel, header
lpanel = Dom.Create("div", panel)
header = Dom.Create("div", lpanel)
header.style.display = "grid"
header.style.gridTemplateColumns = "auto auto"
header.style.padding = "10px"
Dom.Create "div", header, "<b>QBJS Samples</b>"

Dim Shared slist As Object 
slist = Dom.Create("ul", lpanel)
slist.style.overflowY = "auto"
slist.style.marginTop = "0px"
GetSamples
SortList slist

Dim Shared filter As Object
filter = Dom.Create("select", header)
Dom.Event filter, "change", sub_OnChangeFilter
Dim As Object opt, grpc, grpa
opt = Dom.Create("option", filter, "Filter - Show All")
opt.value = "*ALL*"
grpc = Dom.Create("optgroup", filter)
grpc.label = "Category"
grpa = Dom.Create("optgroup", filter)
grpa.label = "Author"

Dim i As Integer
For i = 1 To UBound(clist)
    opt = Dom.Create("option", grpc, clist(i))
    opt.ftype = "category"
    opt.value = clist(i)
Next i
For i = 1 To UBound(alist)
    opt = Dom.Create("option", grpa, alist(i))
    opt.ftype = "author"
    opt.value = alist(i)
Next i

Dim rpanel As Object
rpanel = Dom.Create("div", panel)

Dim Shared server As Object
Dim spanel As Object
spanel = Dom.Create("div", rpanel)
spanel.style.position = "absolute"
spanel.style.right = "145px"
spanel.style.top = "11px"
Dom.Create "span", spanel, "Server: "
server = Dom.Create("select", spanel)
Dom.Event server, "change", sub_OnChangeServer
opt = Dom.Create("option", server, "Production (qbjs.org)")
opt.value = "https://qbjs.org"
opt = Dom.Create("option", server, "Development (github.io)")
opt.value = "https://boxgaming.github.io/qbjs/"

Dim Shared iframe As Object
iframe = Dom.Create("iframe", rpanel)
iframe.style.width = "100%"
iframe.style.height = (_ResizeHeight) + "px"
iframe.frameBorder = "0"
iframe.src = server.value

Dom.Event window, "resize", sub_OnResize
FireResize

' Handle bookmark anchor
Dim h As String
h = document.location.hash
If h Then
    ReDim parts() As String
    Split h, "=", parts
    If UBound(parts) = 2 Then
        If parts(1) = "#src" Then
            iframe.src = server.value + BASE_URL + parts(2)
        ElseIf parts(1) = "#author" Or parts(1) = "#category" Then
            filter.value = parts(2)
            $If Javascript Then
                filter.dispatchEvent(new Event("change"));
            $End If
        End If
    End If
End If


Sub GetSamples
    Dim As String filename, path, pname, author, desc, categories, ts
    ts = Str$(Timer)
    filename = "https://raw.githubusercontent.com/boxgaming/qbjs-samples/refs/heads/main/samples.txt?ts=" + ts
    Open filename For Input As #1
    While Not EOF(1)
    Input #1, path, pname, author, desc, categories

    Dim As Object li, a
        li = Dom.Create("li", slist)
        a = Dom.Create("a", li, pname)
        a.href = "#src=" + path
        a.samplePath = path
        a.categories = categories
        li.sortName = pname
        a.title = "Author:" + Chr$(10) + author + Chr$(10) + Chr$(10) + "Categories: " + Chr$(10) + categories + Chr$(10) + Chr$(10) + "Description:" + Chr$(10) + desc
        Dom.Event a, "click", sub_OnClickSample
        MapAuthors author, li
        MapCategories categories, li
    Wend
    
    Close #1
    ' Delete the cached file
    Kill "/raw.githubusercontent.com/boxgaming/qbjs-samples/refs/heads/main/samples.txt?ts=" + ts
End Sub

Sub OnResize
    iframe.style.height = (_ResizeHeight) + "px"
    slist.style.height = (_ResizeHeight - 45) + "px"
End Sub

Sub OnClickSample (event As Object)
    iframe.src = server.value + BASE_URL + event.target.samplePath
    lastSelected = event.target.samplePath
End Sub

Sub OnChangeServer (event As Object)
    Dim url As String
    url = server.value
    If lastSelected Then
        url = url + BASE_URL + lastSelected
    End If
    iframe.src = url
End Sub

Sub OnChangeFilter (event As Object)
    Dim opt As Object
    opt = filter.options[filter.selectedIndex]
    If opt.value = "*ALL*" Then
        SetVisible -1
        Exit Sub
    End If
    SetVisible 0
    Dim o As Object
    If opt.ftype = "author" Then
        location.hash = "author=" + opt.value
        o = amap(opt.value)
    Else
        location.hash = "category=" + opt.value
        o = cmap(opt.value)
    End If
    Dim i As Integer
    For i = 0 to o.length - 1
        o[i].style.display = "list-item"
    Next i
End Sub

Sub Split (sourceString As String, delimiter As String, results() As String)
    Dim sarray As Object
    $If Javascript Then
        sarray = sourceString.split(delimiter);
    $End If
    Dim i As Integer
    Dim s As String
    ReDim results(sarray.length) As String
    For i = 0 To sarray.length + 1
        $If Javascript Then
            s = sarray[i]
        $End if
        results(i+1) = LTrim$(s)
    Next i
End Sub

Sub SetVisible (visible As Integer)
$If Javascript Then
    var child = slist.firstChild;
    while (child) {
        child.style.display = visible ? "list-item": "none";
        child = child.nextSibling;
    }
$End If
End Sub

Sub MapAuthors (authors As String, li As Object)
    ReDim aarray(0) As String
    Split authors, ",", aarray()
    
    Dim ai As Integer
    For ai = 1 To UBound(aarray)
        Dim author As String
        author = aarray(ai)
        
        Dim o As Object
        o = amap(author)
        $If Javascript Then
            if (o == undefined || o.length == undefined) {
                o = [];
            }
            o.push(li);
        $End If
        amap(author) = o

        Dim As Integer found, i
        For i = 1 To UBound(alist)
            If alist(i) = author Then
                found = -1
                Exit For
            End If
        Next i
        If Not found Then
            i = UBound(alist) + 1
            ReDim _Preserve alist(i) As String
            alist(i) = author
        End If
    Next ai
    SortArray alist
End Sub

Sub MapCategories (categories As String, li As Object)
    ReDim carray(0) As String
    Split categories, ",", carray()
    
    Dim ci As Integer
    For ci = 1 To UBound(carray)
        Dim category As String
        category = carray(ci)

        Dim o As Object
        o = cmap(category)
        $If Javascript Then
            if (o == undefined || o.length == undefined) {
                o = [];
            }
            o.push(li);
        $End If
        cmap(category) = o

        Dim As Integer found, i
        For i = 1 To UBound(clist)
            If clist(i) = category Then
                found = -1
                Exit For
            End If
        Next i
        If Not found Then
            i = UBound(clist) + 1
            ReDim _Preserve clist(i) As String
            clist(i) = category
        End If
    Next i
    SortArray clist
End Sub

Sub SortArray (qbarray() As String)
    Dim array As Object
    $If Javascript Then
        array = [];
    $End If
    Dim i As Integer
    For i = 1 To UBound(qbarray)
        Dim o As Object
        o = qbarray(i)
        $If Javascript Then
            array.push(o);
        $End If
    Next i
    $If Javascript Then
        array.sort(function (a, b) {
            return a.toLowerCase().localeCompare(b.toLowerCase());
        });
    $End If
    For i = 0 To array.length - 1
        qbarray(i+1) = array[i]
    Next i
End Sub

Sub SortList (list As Object)
$If Javascript Then
    var i, switching, b, shouldSwitch;
    switching = true;
    while (switching) {
        switching = false;
        b = list.getElementsByTagName("LI");
        for (i = 0; i < (b.length - 1); i++) {
            shouldSwitch = false;
            if (b[i].sortName.toLowerCase().localeCompare(b[i + 1].sortName.toLowerCase()) > 0) {
                shouldSwitch = true;
                break;
            }
        }
        if (shouldSwitch) {
            b[i].parentNode.insertBefore(b[i + 1], b[i]);
            switching = true;
        }
    }
$End If
End Sub

Sub FireResize
$If Javascript Then
    window.dispatchEvent(new Event("resize"));
$End If
End Sub
