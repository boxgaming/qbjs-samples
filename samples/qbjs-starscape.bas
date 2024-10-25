const stars = 2000
const galaxies = 50

randomize timer
dim shared pi, d, zz, sw, sh
pi = 4*atn(1)
d = 700
zz = 2100
sw = _RESIZEWIDTH-5
sh = _RESIZEHEIGHT-5

type stype
    x as double
    y as double
    z as double
end type
dim shared star(stars) as stype

type gtype
    x as double
    y as double
    z as double

    r as double
    r1 as double
    r2 as double

    a1 as double
    a2 as double
    a3 as double
end type
dim shared galaxy(galaxies) as gtype

screen _newimage(sw, sh, 32)

dim as double i,x1,y1,z1,z0,r,r1,r2,a1,a2,a3

for i=0 to stars
    star(i).x = 5000*rnd-2500
    star(i).y = 5000*rnd-2500
    star(i).z = 5000*rnd-2500
next
for i=0 to galaxies
    galaxy(i).x = 4000*rnd-2000
    galaxy(i).y = 4000*rnd-2000
    galaxy(i).z = 4000*rnd-2000
    galaxy(i).r = 150*rnd
    galaxy(i).r1 = rnd
    galaxy(i).r2 = rnd
    galaxy(i).a1 = 2*pi*rnd
    galaxy(i).a2 = 2*pi*rnd
    galaxy(i).a3 = 4*pi*rnd - 2.5*pi*rnd
next


dim p, q
do
    cls

    for i=0 to stars
        star(i).z = star(i).z - 100
        if star(i).z < 0 then
            star(i).x = 4000*rnd-2000
            star(i).y = 4000*rnd-2000
            star(i).z = 4000*rnd-2000
        end if
        x1 = star(i).x
        y1 = star(i).y
        z1 = star(i).z
        for z0 = 0 to 3
    
            p = sw/2 + x1*d/(z1 + zz + z0*10)
            q = sh/2 - y1*d/(z1 + zz + z0*10)
            if p>0 and p<sw and q>0 and q<sh then
            pset (p, q),_rgb(255 - 50*z0, 255 - 50*z0, 0)
            end if
        next
    next

    for i=0 to galaxies
        galaxy(i).z = galaxy(i).z - 100
        if galaxy(i).z < 0 then
            galaxy(i).x = 4000*rnd-2000
            galaxy(i).y = 4000*rnd-2000
            galaxy(i).z = 4000*rnd+8000
            galaxy(i).r = 20*rnd + 30
            galaxy(i).r1 = rnd
            galaxy(i).r2 = rnd
            galaxy(i).a1 = 2*pi*rnd
            galaxy(i).a2 = 2*pi*rnd
            galaxy(i).a3 = 4*pi*rnd - 2.5*pi*rnd
        end if
        x1 = galaxy(i).x
        y1 = galaxy(i).y
        z1 = galaxy(i).z
        r = galaxy(i).r
        r1 = galaxy(i).r1
        r2 = galaxy(i).r2
        a1 = galaxy(i).a1
        a2 = galaxy(i).a2
        a3 = galaxy(i).a3
   
        drawgalaxy x1, y1, z1, r, r1, r2, a1, a2, a3
    next

    _display
    _limit 60
loop until _keyhit = 27
sleep
system

sub drawgalaxy(x1, y1, z1, r, r1, r2, a1, a2, u)
    dim c as _unsigned long
    dim p, q
    dim x,y,z,xx,yy,zz,x0,y0,z0,i,k,a,rr,gg,bb
    for a=0 to u step 0.1
        for i=0 to 0.001*r*(u - a)^3.5
            x0 = (rnd - 0.5)*0.2*r*(u - a)
            y0 = (rnd - 0.5)*0.2*r*(u - a)
            z0 = (rnd - 0.5)*0.2*r*(u - a)

            if x0*x0 + y0*y0 + z0*z0 < 2000 then
            for k=0 to 1
                x = x0 + r1*r*a*cos(a + k*pi)
                y = y0 + r2*r*a*sin(a + k*pi)
                z = z0 + 1

                'rot x, y, a1
                'rot y, z, a2

                xx = x
                yy = y
                x = xx*cos(a1) - yy*sin(a1)
                y = xx*sin(a1) + yy*cos(a1)

                yy = y
                zz = z
                y = yy*cos(a2) - zz*sin(a2)
                z = yy*sin(a2) + zz*cos(a2)

                c = 255*(u - a)/2
                rr = c + rnd*50
                gg = 0.2*c + rnd*50
                bb = 0
                if rr < 0 then rr = 0
                if gg < 0 then gg = 0
                if bb < 0 then bb = 0
                if rr > 255 then rr = 255
                if gg > 255 then gg = 255
                if bb > 255 then bb = 255
                rr = rr - z1/100
                gg = gg - z1/100
                bb = bb - z1/100
                
                p = sw/2 + (x + x1)*d/(z + z1 + zz)
                q = sh/2 - (y + y1)*d/(z + z1 + zz)
                if p>0 and p<sw and q>0 and q<sh then
                pset (p, q), _rgb(rr, gg, bb)
                end if

            next
            end if
        next
    next
end sub
