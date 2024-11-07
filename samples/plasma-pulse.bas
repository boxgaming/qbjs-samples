 
Screen _NewImage(800, 600, 32)
 
cx = _Width / 2
cy = _Height / 2
 
Do
    t = Timer
    pulse = Sin(t) * .8 'pulse factor
 
    For y = 0 To _Height Step 3
        For x = 0 To _Width Step 3
            a = _Atan2(y - cy, x - cx) + t
            rad = Sqr((x - cx) ^ 2 + (y - cy) ^ 2) / 100
 
            '1st plasma colors
            r1 = (Sin(rad * 2 + t) + Sin(a * 5 + t)) * 127 + 128
            g1 = (Sin(rad * 2 + t + 1) + Sin(a * 5 + t + 1)) * 127 + 128
            b1 = (Sin(rad * 2 + t + 2) + Sin(a * 5 + t + 2)) * 127 + 128
 
            '2nd plasma colors
            r2 = (Sin(rad * 3 + t) + Sin(a * 3 + t + 1)) * 127 + 128
            g2 = (Sin(rad * 3 + t + 2) + Sin(a * 3 + t + 3)) * 127 + 128
            b2 = (Sin(rad * 3 + t + 4) + Sin(a * 3 + t + 4)) * 127 + 128
 
            'Blend plasma colors using pulse factor
            r = r1 * (1 - pulse) + r2 * pulse
            g = g1 * (1 - pulse) + g2 * pulse
            b = b1 * (1 - pulse) + b2 * pulse
 
            c = _RGB(r, g, b)
            For y1 = 0 To 2
                For x1 = 0 To 2
                    PSet (x + x1, y + y1), _RGB(r, g, b)
                Next x1
            Next y1
        Next
    Next
 
    _Display
    _Limit 30
 
Loop Until InKey$ <> ""
