'Option _Explicit
'DefLng A-Z

Dim sw, sh, r, rr0, sx, sy, mw, mx, my, mb, rr, valid, old_mx, old_my, old_mw

sw = 640
sh = 480

Dim Shared pi As Double
pi = 4 * Atn(1)

Dim As Double t, a, b, a1, a2
Dim As Double x, y, x0, y0, x1, y1, dx, dy

r = 210
rr0 = 140

sx = 0
sy = sh / 2

Screen _NewImage(sw, sh, 32)
'_ScreenMove 0.5 * (1920 - sw), 0.5 * (1080 - sh)


Do
    'Do While _MouseInput
        mw = mw + _MouseWheel
    'Loop

    If _KeyDown(87) or _KeyDown(119) then 'W
        mw = mw - 1
    ElseIf _KeyDown(83) or _KeyDown(115) then 'S
        mw = mw + 1
    End If

    mx = _MouseX
    my = _MouseY
    mb = _MouseButton(1)

    rr = rr0 - mw

    If mb Then
        Do While mb
            Do While _MouseInput
            Loop
            mb = _MouseButton(1)
        Loop

        valid = -1
        For b = 0 To 2 * pi Step 2 * pi / 3
            x1 = r * Cos(b) + sw / 2
            y1 = r * Sin(b) + sh / 2

            dx = mx - x1
            dy = my - y1
            If dx * dx + dy * dy < rr * rr Then
                valid = 0
                Exit For
            End If
        Next

        If valid Then
            sx = mx
            sy = my
        End If
    End If

    'if mx<>old_mx or my<>old_my or mw<>old_mw then
    'fading light
    If 1 Then



        'line (0,0)-(sw,sh), _rgb(0,0,0), bf
        Line (0, 0)-(sw, sh), _RGBA32(0, 0, 0, 30), BF

        'locate 1,1
        '? mx, my, mw, mb
        
        For b = 0 To 2 * pi Step 2 * pi / 3
            Circle (r * Cos(b) + sw / 2, r * Sin(b) + sh / 2), rr
        Next
        
        a = _Atan2(my - sy, mx - sx)
        
        x0 = sx
        y0 = sy
        
        For t = 0 To 1000
            x = t * Cos(a) + x0
            y = t * Sin(a) + y0
            
            For b = 0 To 2 * pi Step 2 * pi / 3
                If x >= 0 And x < sw And y >= 0 And y < sh Then
                    x1 = r * Cos(b) + sw / 2
                    y1 = r * Sin(b) + sh / 2
                    
                    dx = x - x1
                    dy = y - y1
                    If dx * dx + dy * dy < rr * rr Then
                        a1 = _Atan2(dy, dx)
                        a2 = 2 * a1 - a - pi
                        
                        Line (x0, y0)-(x, y), _RGB(233, 205, 89)
                        
                        x0 = x
                        y0 = y
                        a = a2
                        t = 0
                        Exit For
                    End If
                End If
            Next
        Next
        
        Line (x0, y0)-(x, y), _RGB(233, 205, 89)
        
    End If

    old_mx = mx
    old_my = my
    old_mw = mw

    _Display
    _Limit 50
Loop Until _KeyHit = 27
System
