
dim shared pi, p, q, d, z0, t, f, sw, sh

sw = 800
sh = 600
d = 700
z0 = 1500
pi = 4*atn(1)

screen _newimage(sw, sh)

sv = 2*pi/30
su = 2*pi/10

'do
for t = 0 to 2*pi step 0.01
    cls 
    u = 0
    for v=0 to 2*pi+sv step sv
        x = cos(u)
        y = sin(u)
        z = cos(v)
        w = sin(v)
        
        proj x, y, z, w
        preset (p, q)
        
        for u=0 to 2*pi+su step su
            x = cos(u)
            y = sin(u)
            z = cos(v)
            w = sin(v)
        
            proj x, y, z, w
            line -(p, q)
        next
    next
    
    for u=0 to 2*pi+su step su
        x = cos(u)
        y = sin(u)
        z = cos(v)
        w = sin(v)
        
        proj x, y, z, w
        preset (p, q), _rgb(255,0,0)
        
        for v=0 to 2*pi+sv step sv
            x = cos(u)
            y = sin(u)
            z = cos(v)
            w = sin(v)
        
            proj x, y, z, w
            line -(p, q), _rgb(255,0,0)
        next
    next
    

    _limit 50
next
'loop

sub proj(x, y, z, w)
    xx = x
    yy = y*cos(t) - w*sin(t)
    zz = z
    ww = y*sin(t) + w*cos(t)

    d2 = 3
    w0 = 3
    xx = xx*d2/(w0 + ww)
    yy = yy*d2/(w0 + ww)
    zz = zz*d2/(w0 + ww)
    
    xxx = xx*cos(t) - zz*sin(t)
    zzz = xx*sin(t) + zz*cos(t)
    xx = xxx
    zz = zzz
    
    a = pi/12
    b = pi/3
    xxx = xx*cos(a) - yy*sin(a)
    yyy = xx*sin(a) + yy*cos(a)
    xx = xxx
    yy = yyy

    yyy = yy*cos(b) - zz*sin(b)
    zzz = yy*sin(b) + zz*cos(b)
    yy = yyy
    zz = zzz
    
    xx = 200*xx
    yy = 200*yy
    zz = 200*zz

    p = sw/2 + 2*xx*d/(yy + z0)
    q = sh/2 - 2*zz*d/(yy + z0)
end sub
