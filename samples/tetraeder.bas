'based on a YaBASIC example, ported by William33
'the FillTriangle code is based on a Turbo Pascal example
'Option _Explicit

Dim n, p, phi, dphi, psi, dpsi, r, g, dr, dg, db, p2, b, dm, m, p1, p3, n1, n2, n3, sp

_Title "Tetraeder"

Screen _NewImage(1280, 720, 32)

Dim opoints(4, 3)
Restore points
For n = 1 To 4: For p = 1 To 3: Read opoints(n, p): Next p: Next n

Dim triangles(4, 3)
Restore triangles
For n = 1 To 4: For p = 1 To 3: Read triangles(n, p): Next p: Next n

phi = 0: dphi = 0.1: psi = 0: dpsi = 0.05
Dim points(4, 3)

r = 60: g = 20
dr = 0.5: dg = 1.2: db = 3
Do
    _Limit 60
    Cls
    phi = phi + dphi
    psi = psi + dpsi
    For n = 1 To 4
        points(n, 1) = opoints(n, 1) * Cos(phi) - opoints(n, 2) * Sin(phi)
        points(n, 2) = opoints(n, 2) * Cos(phi) + opoints(n, 1) * Sin(phi)
        p2 = points(n, 2) * Cos(psi) - opoints(n, 3) * Sin(psi)
        points(n, 3) = opoints(n, 3) * Cos(psi) + points(n, 2) * Sin(psi)
        points(n, 2) = p2
    Next n

    r = r + dr
    If (r < 0 Or r > 60) Then dr = -dr
    g = g + dg
    If (g < 0 Or g > 60) Then dg = -dg
    b = b + db
    If (b < 0 Or b > 60) Then db = -db
    dm = dm + 0.01
    m = 120 - 80 * Sin(dm)
    For n = 1 To 4
        p1 = triangles(n, 1)
        p2 = triangles(n, 2)
        p3 = triangles(n, 3)
        n1 = points(p1, 1) + points(p2, 1) + points(p3, 1)
        n2 = points(p1, 2) + points(p2, 2) + points(p3, 2)
        n3 = points(p1, 3) + points(p2, 3) + points(p3, 3)
        If (n3 > 0) Then
            sp = n1 * 0.5 - n2 * 0.7 - n3 * 0.6
            Color _RGB32(Int(60 + r + 30 * sp) Mod 256, Int(60 + g + 30 * sp) Mod 256, Int(60 + b + 30 * sp) Mod 256)
            FillTriangle Int(_Width / 2) + m * points(p1, 1), Int(_Height / 2) + m * points(p1, 2), Int(_Width / 2) + m * points(p2, 1), Int(_Height / 2) + m * points(p2, 2), Int(_Width / 2) + m * points(p3, 1), Int(_Height / 2) + m * points(p3, 2)
        End If
    Next n
    _Display

Loop Until InKey$ = Chr$(27)

System

points:
Data -1,-1,+1,+1,-1,-1,+1,+1,+1,-1,+1,-1
triangles:
Data 1,2,4,2,3,4,1,3,4,1,2,3


Sub FillTriangle (xa As Integer, ya As Integer, xb As Integer, yb As Integer, xc As Integer, yc As Integer)
    Dim y1 As Long, y2 As Long, y3 As Long, x1 As Long, x2 As Long, x3 As Long
    Dim dx12 As Long, dx13 As Long, dx23 As Long
    Dim dy12 As Long, dy13 As Long, dy23 As Long, dy As Long
    Dim a As Long, b As Long
    If ya = yb Then
        yb = yb + 1
    End If
    If ya = yc Then
        yc = yc + 1
    End If
    If yc = yb Then
        yb = yb + 1
    End If
    If (ya <> yb) And (ya <> yc) And (yc <> yb) Then
        If (ya > yb) And (ya > yc) Then
            y1 = ya: x1 = xa
            If yb > yc Then
                y2 = yb: x2 = xb
                y3 = yc: x3 = xc
            Else
                y2 = yc: x2 = xc
                y3 = yb: x3 = xb
            End If
        Else
            If (yb > ya) And (yb > yc) Then
                y1 = yb: x1 = xb
                If ya > yc Then
                    y2 = ya: x2 = xa
                    y3 = yc: x3 = xc
                Else
                    y2 = yc: x2 = xc
                    y3 = ya: x3 = xa
                End If
            Else
                If (yc > yb) And (yc > ya) Then
                    y1 = yc: x1 = xc
                    If yb >= ya Then
                        y2 = yb: x2 = xb
                        y3 = ya: x3 = xa
                    Else
                        y2 = ya: x2 = xa
                        y3 = yb: x3 = xb
                    End If
                End If
            End If
        End If
        dx12 = x2 - x1: dy12 = y2 - y1
        dx23 = x3 - x2: dy23 = y3 - y2
        dx13 = x3 - x1: dy13 = y3 - y1
        a = x2 - ((y2 - y3 + dy23) * dx23) / dy23
        b = x3 + (-dy23 * dx13) / (dy13)
        If (a < b) Then
            Line (a, y2)-(b, y2)
            For dy = 0 To -dy23 - 1
                a = x2 + ((dy23 + dy) * dx23) / dy23
                b = x3 + (dy * dx13) / (dy13)
                Line (a, dy + y3)-(b, dy + y3)
            Next
            For dy = -dy23 + 1 To -dy13
                a = x2 + ((dy23 + dy) * dx12) / dy12
                b = x3 + (dy * dx13) / (dy13)
                Line (a, dy + y3)-(b, dy + y3)

            Next
        Else
            Line (b, y2)-(a, y2)
            For dy = 0 To -dy23 - 1
                a = x2 + ((dy23 + dy) * dx23) / dy23
                b = x3 + (dy * dx13) / (dy13)
                Line (a, dy + y3)-(b, dy + y3)
            Next
            For dy = -dy23 + 1 To -dy13
                a = x2 + ((dy23 + dy) * dx12) / dy12
                b = x3 + (dy * dx13) / (dy13)
                Line (a, dy + y3)-(b, dy + y3)
            Next
        End If
    End If

End Sub
