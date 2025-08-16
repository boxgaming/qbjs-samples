'fake-voronoi-plasma.bas
'Dav, OCT/2023
Screen _NewImage(800, 600, 32)
Do
    For x = 0 To _Width Step 2
        For y = 0 To _Height Step 2
            d = Sqr(((x - y) ^ 2) + t + ((y - x) ^ 2) + t)
            Line (x, y)-Step(2, 2), _RGBA((d + x + t) Mod 255, (d + y + t) Mod 255, (d + t) Mod 255, 10), BF
        Next
    Next
    t = t + 1
    _Limit 30
Loop Until InKey$ = Chr$(27)
