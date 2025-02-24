Import GFX From "/lib/graphics/2d.bas"

dim shared xx(4*3), yy(4*3), zz(4*3)
dim shared x, y, z
dim shared p, q
dim shared zoom

dim shared phi
dim shared rotx, roty, rotz, phiz, phix
phiz = 0
phix = 0

rotx = 1
roty = 1
rotz = 1

phi = 0

zoom = 150

'dim shared sw, sh
sw = 800
sh = 600
screen newimage(sw, sh) 


zoom = sh/3



dim c(2)
c(0) = rgb(100,0,0)
c(1) = rgb(0,100,0)
c(2) = rgb(0,0,100)
for j=0 to 2
    color c(j)
    x = xx(4*j)
    y = yy(4*j)
    z = zz(4*j)
    proj
    preset (sw/2 + p*zoom, sh/2 - q*zoom)
    for i=1 to 3
        x = xx(4*j + i)
        y = yy(4*j + i)
        z = zz(4*j + i)
        proj
        line -(sw/2 + p*zoom, sh/2 - q*zoom)
    next
    x = xx(4*j)
    y = yy(4*j)
    z = zz(4*j)
    proj
    line -(sw/2 + p*zoom, sh/2 - q*zoom)
next



drag = 0
ox = 0
oy = 0
mw = 0
do
    do while mouseinput
        zoom = zoom - 20*mousewheel
    loop
    
    if mousebutton(1) then
        if drag = 0 then
            drag = 1
            ox = mousex
            oy = mousey
        else
            phiz = phiz - 0.01*(mousex - ox)
            phix = phix - 0.01*(mousey - oy)
            ox = mousex
            oy = mousey
        end if
    else
        drag = 0
    end if

    if resize then
        sw = _resizewidth - 20
        sh = _resizeheight - 20
        screen newimage(sw, sh) 
    end if
    
    if not mousebutton(2) then
        phi = phi + 0.01
    end if

    w = 0.5 + 0.5*sin(phi)
    l = 0.5 + 0.5*cos(phi)
    icos w, l

    cls

    'minor faces
    tri 0, 4+0, 1
    tri 0, 1, 4+3
    tri 2, 4+1, 3
    tri 2, 3, 4+2

    tri 4+0, 4+1, 8+1
    tri 4+0, 8+2, 4+1
    tri 4+2, 4+3, 8+0
    tri 4+2, 8+3, 4+3

    tri 8+0, 1, 8+1
    tri 8+2, 0, 8+3
    tri 8+2, 8+3, 3
    tri 8+0, 8+1, 2

    'major faces
    tri 0, 4+3, 8+3
    tri 0, 8+2, 4+0
    tri 1, 8+0, 4+3
    tri 1, 4+0, 8+1

    tri 2, 4+2, 8+0
    tri 3, 8+3, 4+2
    tri 2, 8+1, 4+1
    tri 3, 4+1, 8+2

    display
    limit 30
loop until keyhit=27

system

sub proj
    d = 10
    y0 = 10

    'rot phi, rotx, roty, rotz
    rot phiz, 0,0,1
    rot phix, 1,0,0
     
    p = x*d/(y0 + y)
    q = z*d/(y0 + y)
end sub

sub tri(a, b, c)
    'centroid
    x = (xx(a) + xx(b) + xx(c))/3
    y = (yy(a) + yy(b) + yy(c))/3
    z = (zz(a) + zz(b) + zz(c))/3
    proj
    cx = x
    cy = y
    cz = z
    
    rcy = y
    
    x = xx(b) - xx(a)
    y = yy(b) - yy(a)
    z = zz(b) - zz(a)
    proj
    x1 = x
    y1 = y
    z1 = z
    
    x = xx(b) - xx(c)
    y = yy(b) - yy(c)
    z = zz(b) - zz(c)
    proj
    x2 = x
    y2 = y
    z2 = z

    x1 = xx(b) - xx(a)
    y1 = yy(b) - yy(a)
    z1 = zz(b) - zz(a)
    
    x2 = xx(b) - xx(c)
    y2 = yy(b) - yy(c)
    z2 = zz(b) - zz(c)

    px = y1*z2 - z1*y2
    py = z1*x2 - x1*z2
    pz = x1*y2 - y1*x2


    'dd = 10*sqr(px*px + py*py + pz*pz)
    'px = px/dd
    'py = py/dd
    'pz = pz/dd

    x = cx - px
    y = cy - py
    z = cz - pz
    proj
   
    'line -(sw/2 + p*zoom, sh/2 - q*zoom), rgb(255,255,255)

    x = px
    y = py
    z = pz
    proj
    if y<0.01 then
        x = xx(a)
        y = yy(a)
        z = zz(a)
        proj
        'preset (sw/2 + p*zoom, sh/2 - q*zoom)
        tx1 = sw/2 + p*zoom
        ty1 = sh/2 - q*zoom

        x = xx(b)
        y = yy(b)
        z = zz(b)
        proj
        'line -(sw/2 + p*zoom, sh/2 - q*zoom), rgb(255,255,255)
        tx2 = sw/2 + p*zoom
        ty2 = sh/2 - q*zoom

        x = xx(c)
        y = yy(c)
        z = zz(c)
        proj
        'line -(sw/2 + p*zoom, sh/2 - q*zoom), rgb(255,255,255)
        tx3 = sw/2 + p*zoom
        ty3 = sh/2 - q*zoom

        x = xx(a)
        y = yy(a)
        z = zz(a)
        proj
        'line -(sw/2 + p*zoom, sh/2 - q*zoom), rgb(255,255,255)
        
        c = 50 + rcy*100
        GFX.FillTriangle tx1,ty1, tx2,ty2, tx3,ty3, rgb(c,c,c)
        
        
        preset (tx1,ty1)
        line -(tx2,ty2), rgb(c+50,c+50,c+50)
        line -(tx3,ty3), rgb(c+50,c+50,c+50)
        line -(tx1,ty1), rgb(c+50,c+50,c+50)
    end if

end sub

sub icos(w, l)
    xx(0) = -w
    yy(0) = -l
    zz(0) = 0
    xx(1) = w
    yy(1) = -l
    zz(1) = 0
    xx(2) = w
    yy(2) = l
    zz(2) = 0
    xx(3) = -w
    yy(3) = l
    zz(3) = 0
    for i=0 to 3
        x = xx(i)
        y = yy(i)
        z = zz(i)
        rot pi/2, 1,0,0
        rot pi/2, 0,0,1
        xx(4 + i) = x
        yy(4 + i) = y
        zz(4 + i) = z
    next
    for i=0 to 3
        x = xx(i)
        y = yy(i)
        z = zz(i)
        rot pi/2, 0,1,0
        rot pi/2, 0,0,1
        xx(8 + i) = x
        yy(8 + i) = y
        zz(8 + i) = z
    next
end sub

'V_rot = V cos u + (R x V) sin u + R(R . V)(1 - cos u)
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

    dt = x*rx + y*ry + z*rz
    x3 = rx*dt
    y3 = ry*dt
    z3 = rz*dt

    x = x1*cos(u) + x2*sin(u) + x3*(1 - cos(u))
    y = y1*cos(u) + y2*sin(u) + y3*(1 - cos(u))
    z = z1*cos(u) + z2*sin(u) + z3*(1 - cos(u))
end sub
