'LittleProggieForB+.bas
'By Dav, SEP/2023

Screen _NewImage(800, 600, 32)
dim w2, h2, x, w, n, t '<-- for QBJS to use
w2 = _Width / 2: h2 = _Height / 2
Do
    For x = 0 To _Width Step 5
        For y = 0 To _Height Step 5
            n = Abs(Sin((Sqr(((x - w2) / w2) ^ 2 + ((y - h2) / h2) ^ 2) + t) * t) * 200)
            Line (x, y)-Step(5, 5), _RGBA(Rnd * n, n, 200, 200), BF
        Next
    Next: t = t + (Rnd * 10 - Rnd * 20)
    _Limit 15
    _Display
Loop