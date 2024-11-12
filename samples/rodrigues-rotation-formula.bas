dim shared x,y,z, p,q, t,zoom
dim shared sw,sh, mx,my,mb,mw

dim shared u
dim shared xx0

sw = 800
sh = 600
screen _newimage(sw, sh, 32)
    if _resize then
        sw = _resizewidth - 20
        sh = _resizeheight - 20
        screen _newimage(sw, sh, 32)
    end if

zoom = 100

x=1
y=0
z=0
proj
line (sw/2, sh/2) - (sw/2 + zoom*p, sh/2 - zoom*q),_rgb(255,0,0)
x=0
y=1
z=0
proj
line (sw/2, sh/2) - (sw/2 + zoom*p, sh/2 - zoom*q),_rgb(0,0,255)
x=0
y=0
z=1
proj
line (sw/2, sh/2) - (sw/2 + zoom*p, sh/2 - zoom*q),_rgb(0,255,0)


y0 = -0.3
u = 0
x0 = 0.1
do
    u = u + 0.1

    if _keydown(19200) then x0 = x0 + 0.1
    if _keydown(19712) then x0 = x0 - 0.1

    cls
    locate 1,1: print xx0

    xx0 = 0
    color _rgb(255,0,0)
    square -0.5,y0,-1, -0.5,y0,1, 0.5,y0,1, 0.5,y0,-1 'roof
    square -0.5,y0-0.5,-1, -0.5,y0-0.5,1, 0.5,y0-0.5,1, 0.5,y0-0.5,-1 'floor
    square -0.5,y0,-1, 0.5,y0,-1, 0.5,y0-0.5,-1, -0.5,y0-0.5,-1 'rear
    square -0.5,y0,1, 0.5,y0,1, 0.5,y0-0.5,1, -0.5,y0-0.5,1 'windshield

    xx0 = x0
    color _rgb(0,0,255)
    square -0.5,y0,-1, -0.5,y0,1, 0.5,y0,1, 0.5,y0,-1 'roof
    square -0.5,y0-0.5,-1, -0.5,y0-0.5,1, 0.5,y0-0.5,1, 0.5,y0-0.5,-1 'floor
    square -0.5,y0,-1, 0.5,y0,-1, 0.5,y0-0.5,-1, -0.5,y0-0.5,-1 'rear
    square -0.5,y0,1, 0.5,y0,1, 0.5,y0-0.5,1, -0.5,y0-0.5,1 'windshield

    _display
    _limit 30
loop until _keyhit = 27
system

sub square(x1,y1,z1, x2,y2,z2, x3,y3,z3, x4,y4,z4)
    x=x1
    y=y1
    z=z1
    proj
    preset (sw/2 + zoom*p, sh/2 - zoom*q)

    x=x2
    y=y2
    z=z2
    proj
    line -(sw/2 + zoom*p, sh/2 - zoom*q)

    x=x3
    y=y3
    z=z3
    proj
    line -(sw/2 + zoom*p, sh/2 - zoom*q)

    x=x4
    y=y4
    z=z4
    proj
    line -(sw/2 + zoom*p, sh/2 - zoom*q)

    x=x1
    y=y1
    z=z1
    proj
    line -(sw/2 + zoom*p, sh/2 - zoom*q)
end sub

sub proj
    rot u, 1,1,0

    x = x + xx0

    d = 100
    p = x*d/(100 + y)
    q = y*d/(100 + y)
end sub

sub rot(u, rx, ry, rz)
    dd = sqr(rx*rx + ry*ry + rz*rz)
    rx = rx/dd
    ry = ry/dd
    rz = rz/dd


    x1 = x
    y1 = y
    z1 = z

    x2 = ry*z - rz*y
    y2 = rz*x - rx*z
    z2 = rx*y - ry*x

    x3 = rx*(rx*x + ry*y + rz*z)
    y3 = ry*(rx*x + ry*y + rz*z)
    z3 = rz*(rx*x + ry*y + rz*z)

    x = x1*cos(u) + x2*sin(u) + x3*(1 - cos(u))
    y = y1*cos(u) + y2*sin(u) + y3*(1 - cos(u))
    z = z1*cos(u) + z2*sin(u) + z3*(1 - cos(u))

end sub

sub rotx(u, x0, y0, z0)
    xx = x - x0
    yy = (y - y0)*cos(u) - (z - z0)*sin(u)
    zz = (y - y0)*sin(u) + (z - z0)*cos(u)

    x = xx + x0
    y = yy + y0
    z = zz + z0
end sub

sub roty(u, x0, y0, z0)
    xx = (x - x0)*cos(u) + (z - z0)*sin(u)
    yy = y - y0
    zz =-(x - x0)*sin(u) + (z - z0)*cos(u)

    x = xx + x0
    y = yy + y0
    z = zz + z0
end sub

sub rotz(u, x0, y0, z0)
    xx = (x - x0)*cos(u) - (y - y0)*sin(u)
    yy = (x - x0)*sin(u) + (y - y0)*cos(u)
    zz = z - z0

    x = xx + x0
    y = yy + y0
    z = zz + z0
end sub

