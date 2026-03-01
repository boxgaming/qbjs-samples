e = 50: d = -e: p = .001 ' atomicheart.bas
w = 400: h = 630: Screen _NewImage(w, h, 32)

d = d + e: For x = 90 To 256: For y = d To d + e
    PSet (x - 90, y), _RGB32(x, 0, 0):
Next: _Delay p: Next

d = d + e: For x = 90 To 256: For y = d To d + e
    PSet (x - 90, y), _RGB32(0, x, 0):
Next: _Delay p: Next

d = d + e: For x = 90 To 256: For y = d To d + e
    PSet (x - 90, y), _RGB32(0, 0, x):
Next: _Delay p: Next

'//////////////

d = d + e: For x = 255 To 90 Step -1: For y = d To d + e
    PSet (x - 90, y), _RGB32(0, x, x):
Next: _Delay p: Next

d = d + e: For x = 255 To 90 Step -1: For y = d To d + e
    PSet (x - 90, y), _RGB32(x, 0, x):
Next: _Delay p: Next

d = d + e: For x = 255 To 90 Step -1: For y = d To d + e
    PSet (x - 90, y), _RGB32(x, x, 0):
Next: _Delay p: Next


'//////////////


d = d + e: For y = d + e To d Step -1: For x = 40 To 206
    PSet (x - 40, y), _RGB32(205 - x, x, 0):
Next: _Delay p * 2: Next

d = d + e: For y = d + e To d Step -1: For x = 40 To 206
    PSet (x - 40, y), _RGB32(x, 205 - x, 0):
Next: _Delay p * 3: Next

d = d + e: For y = d + e To d Step -1: For x = 40 To 206
    PSet (x - 40, y), _RGB32(205 - x, 0, x):
Next: _Delay p * 5: Next



d = d + e: For y = d To d + e: For x = 205 To 40 Step -1
    PSet (x - 40, y), _RGB32(0, x, 205 - x)
Next: _Delay p * 7: Next

d = d + e: For y = d To d + e: For x = 205 To 40 Step -1
    PSet (x - 40, y), _RGB32(x, 0, 205 - x)
Next: _Delay p * 5: Next

d = d + e: For y = d To d + e: For x = 205 To 40 Step -1
    PSet (x - 40, y), _RGB32(0, 205 - x, x)
Next: _Delay p * 8: Next


e = 206: d = -e
d = d + e: For x = 30 To 256: For y = 50 To 256
    PSet (136 + x, d + y - 50), _RGB32(x, 0, y)
Next: _Delay p * 5: Next

d = d + e: For x = 255 To 30 Step -1: For y = 50 To 256
    PSet (136 + x, d + y - 50), _RGB32(0, x, y)
Next: _Delay p * 3: Next

d = d + e: For y = 255 To 50 Step -1: For x = 255 To 30 Step -1
    PSet (136 + x, d + y - 50), _RGB32(x, y, 0)
Next: _Delay p * 2: Next