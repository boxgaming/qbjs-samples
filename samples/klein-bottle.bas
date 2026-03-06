dim shared pi, p, q, a, b, x, y, z, t

zoom = 150

sw = 1024
sh = 768

screen _newimage(sw, sh, 32)

if resize then
sw = resizewidth-20
sh = resizeheight-20
screen _newimage(sw, sh, 32)

end if

pi = 4*atn(1)

du = 2*pi/200
dv = 2*pi/20

a = pi/4
b = pi/4

ou = 0
ov = 0

tt = 0
do
    tt = tt + 0.01
    t = 0.5 '+ 0.5*sin(tt)
    a = a + 0.01
    b = b + 0.01
    
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
            ccc = 100*abs(1 + z)
            color rgb(ccc,ccc,ccc)
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
                line -(x3, y3)

                f u, v + dv
                proj
                x4 = sw/2 + zoom*p
                y4 = sh/2 - zoom*q
        next
    next
    
    
    

    'next

    _display
    _limit 100
loop until _keyhit = 27
sleep
system


sub f(u, v)
    
    x = -(2/15)*cos(u)*(3*cos(v)-30*sin(u)+90*((cos(u))^4)*sin(u) - 60*(cos(u))^6*sin(u) + 5*cos(u)*cos(v)*sin(u))
    y = -(1/15)*sin(u)*(3*cos(v) - 3*(cos(v))^2*cos(v) - 48*(cos(u))^4*cos(v) + 48*(cos(u))^6*cos(v) - 60*sin(u) + 5*cos(u)*cos(v)*sin(u) - 5*(cos(u))^3*cos(v)*sin(u) - 80*(cos(u))^5*cos(v)*sin(u) + 80*(cos(u))^7*cos(v)*sin(u)) - 2
    z = (2/15)*(3 + 5*cos(u)*sin(u))*sin(v)

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