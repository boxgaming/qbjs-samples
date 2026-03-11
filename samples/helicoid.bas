import gfx from "lib/graphics/2d.bas"
dim shared pi, p, q, a, b, x, y, z, t, tt
 
zoom = 80
 
sw = resizewidth - 20
sh = resizeheight - 20
 
screen _newimage(sw, sh, 32)
 
pi = 4*atn(1)
du = 2*pi/20
dv = 2*pi/20
 
a = 0
b = 0'pi/4
 
tt = 0
 
do  
    tt = tt + 0.01
    t = 0.2*sin(tt)
 
    do
        mx = _mousex
        my = _mousey
        mb = _mousebutton(1)
        zoom = zoom - 10*_mousewheel
    loop while _mouseinput
 
    cls
 
    s = 0
    for v=-2*pi to 2*pi step dv
        's = s xor 1
        for u=-3*pi to 3*pi step du
            s = s xor 1
 
            nx = sin(v)
            ny = -cos(v)
            nz = u
 
            roty a
            rotx b
 
            'parallel
            sx = -1
            sy = -sx/0.707
            sz = -0.707*sy
 
            'perspective
            sx = 0  
            sy = -1 
            sz = 0  
 
            'if (nx*sx + ny*sy + nz*sz) < 0 then
                f u, v
                proj 
                x1 = sw/2 + zoom*p
                y1 = sh/2 - zoom*q
                'pset (x1, y1)
 
                f u + du, v
                proj
                x2 = sw/2 + zoom*p
                y2 = sh/2 - zoom*q
                'line -(x2, y2)
 
                f u + du, v + dv
                proj
                x3 = sw/2 + zoom*p
                y3 = sh/2 - zoom*q
                'line -(x3, y3)
 
                f u, v + dv
                proj
                x4 = sw/2 + zoom*p
                y4 = sh/2 - zoom*q
                'line -(x4, y4)
 
                'line -(x1, y1)
 
                if s then
                    c = 255 '- 20*y
                    gfx.FillTriangle x1,y1, x2,y2, x3,y3, _rgb(c,c,c)
                    gfx.FillTriangle x3,y3, x4,y4, x1,y1, _rgb(c,c,c)
                else
                    gfx.FillTriangle x1,y1, x2,y2, x3,y3, _rgb(0,0,0)
                    gfx.FillTriangle x3,y3, x4,y4, x1,y1, _rgb(0,0,0)
                end if
            'end if
        next
    next
 
    _limit 30
    _display
loop until _keyhit = 27
sleep
system
 
 
sub f(u, v)
    x = u*cos(v*t + tt)
    y = u*sin(v*t + tt)
    z = v
 
    'x = (1 + 0.5*v*cos(0.5*(u - t)))*cos(u - t)
    'y = (1 + 0.5*v*cos(0.5*(u - t)))*sin(u - t)
    'z = 0.5*v*sin(0.5*(u - t))
end sub
 
sub proj
    'parallel
    'p = x + 0.707*y
    'q = z + 0.707*y
 
    roty a
    rotx b
 
    p = x*10/(10 + y)
    q = z*10/(10 + y)
end sub
 
sub rotx(u)
    xx = x
    yy = y*cos(u) - z*sin(u)
    zz = y*sin(u) + z*cos(u)
 
    x = xx
    y = yy
    z = zz
end sub
 
sub roty(u)
    xx = x*cos(u) + z*sin(u)
    yy = y
    zz =-x*sin(u) + z*cos(u)
 
    x = xx
    y = yy
    z = zz
end sub
 
sub rotz(u)
    xx = x*cos(u) - y*sin(u)
    yy = x*sin(u) + y*cos(u)
    zz = z
 
    x = xx
    y = yy
    z = zz
end sub
 
'Sub FillTriangle (x1, y1, x2, y2, x3, y3, K As _Unsigned Long)
'    Static a&, m As _MEM
'    If a& = 0 Then a& = _NewImage(1, 1, 32): m = _MemImage(a&)
'    _MemPut m, m.OFFSET, K
'    _MapTriangle _Seamless(0, 0)-(0, 0)-(0, 0), a& To(x1, y1)-(x2, y2)-(x3, y3)
'End Sub