dim shared pi, p, q, d, z0, t, f, sw, sh

sw = 800
sh = 600
d = 700
z0 = 1500
pi = 4*atn(1)


dim x(16), y(16), z(16), w(16)
x(0)=0-1: y(0) =0-1: z(0) =0-1: w(0) = 0-1
x(1)=  1: y(1) =0-1: z(1) =0-1: w(1) = 0-1
x(2)=  1: y(2) =  1: z(2) =0-1: w(2) = 0-1
x(3)=0-1: y(3) =  1: z(3) =0-1: w(3) = 0-1

x(4)=0-1: y(4) =0-1: z(4) =1: w(4) = 0-1
x(5)=  1: y(5) =0-1: z(5) =1: w(5) = 0-1
x(6)=  1: y(6) =  1: z(6) =1: w(6) = 0-1
x(7)=0-1: y(7) =  1: z(7) =1: w(7) = 0-1

x( 8)=0-1: y( 8) =0-1: z( 8) =0-1: w( 8) = 1
x( 9)=  1: y( 9) =0-1: z( 9) =0-1: w( 9) = 1
x(10)=  1: y(10) =  1: z(10) =0-1: w(10) = 1
x(11)=0-1: y(11) =  1: z(11) =0-1: w(11) = 1

x(12)=0-1: y(12) =0-1: z(12) =1: w(12) = 1
x(13)=  1: y(13) =0-1: z(13) =1: w(13) = 1
x(14)=  1: y(14) =  1: z(14) =1: w(14) = 1
x(15)=0-1: y(15) =  1: z(15) =1: w(15) = 1


screen _newimage(sw, sh)

do
for t = 0 to 8*pi step 0.01
    cls 

    f=0
    i = 0
    proj x(i), y(i), z(i), w(i)
    preset (p, q)
    for i=1 to 3
        proj x(i), y(i), z(i), w(i)
        line -(p, q)
    next
    i = 0
    proj x(i), y(i), z(i), w(i)
    line -(p, q)

    i = 4
    proj x(i), y(i), z(i), w(i)
    preset (p, q)
    for i=4 to 7
        proj x(i), y(i), z(i), w(i)
        line -(p, q)
    next
    i = 4
    proj x(i), y(i), z(i), w(i)
    line -(p, q)

    for i=0 to 3
        proj x(i), y(i), z(i), w(i)
        preset (p, q)
        proj x(i+4), y(i+4), z(i+4), w(i+4)
        line -(p, q)
    next

    f = 1
    k = 8
    i = 0+k
    proj x(i), y(i), z(i), w(i)
    preset (p, q), _rgb(255,0,0)
    for i=1+k to 3+k
        proj x(i), y(i), z(i), w(i)
        line -(p, q), _rgb(255,0,0)
    next
    i = 0+k
    proj x(i), y(i), z(i), w(i)
    line -(p, q), _rgb(255,0,0)

    i = 4+k
    proj x(i), y(i), z(i), w(i)
    preset (p, q), _rgb(255,0,0)
    for i=4+k to 7+k
        proj x(i), y(i), z(i), w(i)
        line -(p, q), _rgb(255,0,0)
    next
    i = 4+k
    proj x(i), y(i), z(i), w(i)
    line -(p, q), _rgb(255,0,0)

    for i=0+k to 3+k
        proj x(i), y(i), z(i), w(i)
        preset (p, q), _rgb(255,0,0)
        proj x(i+4), y(i+4), z(i+4), w(i+4)
        line -(p, q), _rgb(255,0,0)
    next

    for i=0 to 7
        f = 0
        proj x(i), y(i), z(i), w(i)
        preset (p, q)
        f = 1
        proj x(i+k), y(i+k), z(i+k), w(i+k)
        line -(p, q)
    next
     
    _limit 50
next
loop

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
    
    a = pi/3
    b = pi/12
    xxx = xx*cos(a) - yy*sin(a)
    yyy = xx*sin(a) + yy*cos(a)
    xx = xxx
    yy = yyy

    yyy = yy*cos(b) - zz*sin(b)
    zzz = yy*sin(b) + zz*cos(b)
    yy = yyy
    zz = zzz
    
    xx = 100*xx
    yy = 100*yy
    zz = 100*zz

    p = sw/2 + 2*xx*d/(yy + z0)
    q = sh/2 - 2*zz*d/(yy + z0)
end sub
