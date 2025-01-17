dim shared pi, p, q, a, b, x, y, z, t

zoom = 150

sw = 1024
sh = 768

screen _newimage(sw, sh, 32)

pi = 4*atn(1)

du = 2*pi/10
dv = 2*pi/20

a = pi/4
b = pi/4

ou = 0
ov = 0

tt = 0
do
    tt = tt + 0.01
    t = 0.5 + 0.5*sin(tt)
    a = t
    'for t = 0 to 1 step 0.01
    do
        mx = _mousex
        my = _mousey
        mb = _mousebutton(1)
        zoom = zoom - 10*_mousewheel
    loop while _mouseinput

    cls

    xu = 0
    xv = 0

    for u=0 to 2*pi step du
        xu = xu xor 1
        for v=0 to 2*pi step dv
            xu = xu xor 1

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
                preset (x1, y1)

                f u + du, v
                proj
                x2 = sw/2 + zoom*p
                y2 = sh/2 - zoom*q
                line -(x2, y2)

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

                'if xu then
                '    c = 255
                '    FillTriangle x1,y1, x2,y2, x3,y3, _rgb(c,c,c)
                '    FillTriangle x3,y3, x4,y4, x1,y1, _rgb(c,c,c)
                'else
                '    FillTriangle x1,y1, x2,y2, x3,y3, _rgb(0,0,0)
                '    FillTriangle x3,y3, x4,y4, x1,y1, _rgb(0,0,0)
                'end if
            'end if
        next
    next

    'next

    _display
    _limit 100
loop until _keyhit = 27
sleep
system


sub f(u, v)
    'x = u*cos(v)
    'y = u*sin(v)
    'z = v

    'x = (1 + 0.5*v*cos(0.5*(u - t)))*cos(u - t)
    'y = (1 + 0.5*v*cos(0.5*(u - t)))*sin(u - t)
    'z = 0.5*v*sin(0.5*(u - t))

    rr = 2.0
    r = 0.5 

    x1 = (rr + r*cos(v))*cos(u)
    y1 = (rr + r*cos(v))*sin(u)
    z1 = r*sin(v)

    z2 = (rr + r*cos(u))*cos(v)
    y2 = (rr + r*cos(u))*sin(v)
    x2 = r*sin(u)

    x = (1 - t)*x1 + t*x2
    y = (1 - t)*y1 + t*y2
    z = (1 - t)*z1 + t*z2

end sub

sub proj
    'parallel
    'p = x + 0.707*y
    'q = z + 0.707*y

    roty a
    rotx b

    d = 10
    p = x*d/(10 + y)
    q = z*d/(10 + y)
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
