_Title "Cardioid and Beyond" 'B+ 2019-02-17
Const xmax = 700
Const ymax = 700
Const npoints = 200
Screen _NewImage(xmax, ymax, 32)
Dim Shared pR, pG, pB, cN
CX = xmax / 2
CY = ymax / 2
DA = _Pi(2 / npoints)
R = CX - 10

For Mult = 0 To 100 Step .01
    Cls
    Color &HFFFFFFFF
    Print "Multiple: ";
    'Print Using "###.##"; Mult
    Print _Round(Mult*100)/100
    If Mult = Int(Mult) Then resetPlasma
    Circle (CX, CY), R, _RGB32(0, 128, 0)
    For i = 1 To 200
        x1 = CX + R * Cos(i * DA)
        y1 = CY + R * Sin(i * DA)
        x2 = CX + R * Cos(Mult * i * DA)
        y2 = CY + R * Sin(Mult * i * DA)
        changePlasma
        Line (x1, y1)-(x2, y2)
    Next
    _Display
    _Limit 30
Next

Sub changePlasma ()
    cN = cN + 1
    Color _RGB(127 + 127 * Sin(pR * cN), 127 + 127 * Sin(pG * cN), 127 + 127 * Sin(pB * cN))
End Sub

Sub resetPlasma ()
    pR = Rnd ^ 2: pG = Rnd ^ 2: pB = Rnd ^ 2
End Sub