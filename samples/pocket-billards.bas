type balltype
    x  as double
    y  as double
    vx as double
    vy as double
    c  as long
end type

'balls
dim shared n
redim shared ball(10) as balltype

'sizes
dim shared sw, sh, ar, br, fc, xc, yc
sw = 375
sh = 667
ar = sw/sh

'geometry
dim drx, dry, dvx, dvy, drmag, nx, ny, qmag

init

dim x, y
dim mb_state, ox, oy
mb_state = 0
ox = 0
oy = 0

do
    if _resize then
        sh = _resizeheight - 20
        sw = ar*sh
        'sw = _resizewidth - 20

        init
    end if

    mx = _mousex
    my = _mousey
    mb = _mousebutton(1)

    'redraw
    _putimage (0,0), img
    for i=0 to n
        r = red(ball(i).c)
        g = green(ball(i).c)
        b = blue(ball(i).c)
        for j=0 to br
            circle (ball(i).x, ball(i).y), j, rgb(r-7*j, g-7*j, b-7*j)
        next
        for j=br to 1.1*br
            circle (ball(i).x, ball(i).y), j, rgba(0, 255 - (j-br)*70, 0, 35)
        next
    next

    'balls
    for i=0 to n
        ball(i).x = ball(i).x + ball(i).vx
        ball(i).y = ball(i).y + ball(i).vy

        'ball(i).vx = 0.99*ball(i).vx
        'ball(i).vy = 0.99*ball(i).vy
        b = atan2( ball(i).vy, ball(i).vx )
        v = sqr(ball(i).vx*ball(i).vx + ball(i).vy*ball(i).vy)

        'terminal velocity
        maxv = 49
        if (v > maxv) then
            ball(i).vx = maxv*cos(b)
            ball(i).vy = maxv*sin(b)
        end if

        'friction
        ball(i).vx = (0.99 - 0.01*(v/maxv))*ball(i).vx
        ball(i).vy = (0.99 - 0.01*(v/maxv))*ball(i).vy
        'ball(i).vx = 0.5*(1 + tanh(3.5*v/maxv))*ball(i).vx
        'ball(i).vy = 0.5*(1 + tanh(3.5*v/maxv))*ball(i).vy


        x = ball(i).x - sw/2
        y = sh/2 - ball(i).y

        'wall collision
        if ((x/(sw/2 - br))^2 + (y/(sh/2 - br))^2) > 1 then
            a = atan2( -(sh/2)*(sh/2)*x, (sw/2)*(sw/2)*(ball(i).y-sh/2) )

            c = 2*a - b - pi
            ball(i).vx = -1.07*v*cos(c)
            ball(i).vy = -1.07*v*sin(c)

            'reset out of bounds
            a = atan2((ball(i).y - sh/2)/(sh/2 - br - 1), (ball(i).x - sw/2)/(sw/2 - br - 1))
            'line (sw/2, sh/2)-(ball(0).x, ball(0).y), rgb(255,0,0)
            'line (sw/2, sh/2)-step((sw/2 - br - 1)*cos(a), (sh/2 - br - 1)*sin(a)), rgb(255,0,0)
            'circle step(0,0),br,rgb(255,0,0)

            ball(i).x = sw/2 + (sw/2 - br - 1)*cos(a)
            ball(i).y = sh/2 + (sh/2 - br - 1)*sin(a)

        end if

        'ball to ball collision
        for j=0 to n
        if i<>j then
            if ((ball(i).x - ball(j).x)^2 + (ball(i).y - ball(j).y)^2) < 4*br*br then
                'a = atan2(ball(i).y - ball(j).y, ball(i).x - ball(j).x)
                'v1 = sqr(ball(i).vx*ball(i).vx + ball(i).vy*ball(i).vy)
                'v2 = sqr(ball(j).vx*ball(j).vx + ball(j).vy*ball(j).vy)
                'v = 0.5*(v1 + v2)
                'ball(i).vx = v*cos(a)
                'ball(i).vy = v*sin(a)
                'ball(j).vx =-v*cos(a)
                'ball(j).vy =-v*sin(a)

                ''e = 0.5
                ''v1f = 0.5*(v1*(1 - e) + v2*(1 + e))
                ''v2f = 0.5*(v1*(1 + e) + v2*(1 - e))
                ''ball(i).vx = v1f*cos(a)
                ''ball(i).vy = v1f*sin(a)
                ''ball(j).vx =-v2f*cos(a)
                ''ball(j).vy =-v2f*sin(a)

                'momentum exchange
                drx = ball(i).x - ball(j).x
                dry = ball(i).y - ball(j).y
                dvx = ball(i).vx - ball(j).vx
                dvy = ball(i).vy - ball(j).vy
                drmag = sqr(drx*drx + dry*dry)
                nx = drx / drmag
                ny = dry / drmag
                qmag = nx * dvx + ny * dvy
                ball(i).vx = ball(i).vx - nx * qmag
                ball(i).vy = ball(i).vy - ny * qmag
                ball(j).vx = ball(j).vx + nx * qmag
                ball(j).vy = ball(j).vy + ny * qmag

                'boost along equal and opposite directions
                'ball(i).x = ball(i).x + .2*nx
                'ball(i).y = ball(i).y + .2*ny
                'ball(j).x = ball(j).x - .2*nx
                'ball(j).y = ball(j).y - .2*ny

                'teleport apart on overlap
                cx = 0.5*(ball(i).x + ball(j).x)
                cy = 0.5*(ball(i).y + ball(j).y)
                ball(i).x = cx + br*nx
                ball(i).y = cy + br*ny
                ball(j).x = cx - br*nx
                ball(j).y = cy - br*ny

            end if
        end if
        next

        'holed
        if i<>0 then
        if ((ball(i).x - xc)^2 + (ball(i).y - yc)^2) < (1.4*br)^2 then
            for j=i to n
                ball(j).x  = ball(j+1).x
                ball(j).y  = ball(j+1).y
                ball(j).vx = ball(j+1).vx
                ball(j).vy = ball(j+1).vy
                ball(j).c  = ball(j+1).c
            next

            n = n - 1

        end if
        end if
    next

    'mouse state
    if mb and mb_state = 0 then
        'if (mx-ball(0).x)^2 + (my-ball(0).y)^2 < br*br then
            mb_state = 1
            ox = mx
            oy = my
        'end if
    end if
    if mb and mb_state then
        line (ox, oy)-(mx, my),rgba(100,100,100,100)
        a = atan2(my - oy, mx - ox)
        v = sqr((my - oy)^2 + (mx - ox)^2)
        x = ball(0).x + (br + 2)*cos(a)
        y = ball(0).y + (br + 2)*sin(a)
        line (x, y)-step(3*br*cos(a), 3*br*sin(a)), rgb(10 + 1*v,155,0)
        line (x, y)-step(br*cos(a+pi/10), br*sin(a+pi/10)), rgb(10 + 1*v,155,0)
        line (x, y)-step(br*cos(a-pi/10), br*sin(a-pi/10)), rgb(10 + 1*v,155,0)
    end if
    if mb = 0 and mb_state then
        ball(0).vx = -0.08*(mx - ox)
        ball(0).vy = -0.08*(my - oy)
        mb_state = 0
    end if

    _display
    _limit 30
loop until _keyhit=27
system

sub init()
    br = (18/375)*sw

    if sw>=sh then
        fc = sqr((sw/2)^2 - (sh/2)^2)
        xc = sw/2 + fc
        yc = sh/2
    else
        fc = sqr((sh/2)^2 - (sw/2)^2)
        xc = sw/2
        yc = sh/2 + fc
    end if

    n = 6
    ball(0).x = sw/2
    ball(0).y = sh/2
    ball(0).vx = 0
    ball(0).vy = 0
    ball(0).c = rgb(255,255,255)

    ball(1).x  = sw/2
    ball(1).y  = sh/4
    ball(1).vx = 0
    ball(1).vy = 0
    ball(1).c  = rgb(255,0,0)
    ball(2).x  = sw/2 + br*2+1
    ball(2).y  = sh/4
    ball(2).vx = 0
    ball(2).vy = 0
    ball(2).c  = rgb(255,0,255)
    ball(3).x  = sw/2 - br*2-1
    ball(3).y  = sh/4
    ball(3).vx = 0
    ball(3).vy = 0
    ball(3).c  = rgb(0,0,255)

    ball(4).x  = sw/2 - br*1
    ball(4).y  = sh/4 + br*2+0.8
    ball(4).vx = 0
    ball(4).vy = 0
    ball(4).c  = rgb(255,255,0)
    ball(5).x  = sw/2 + br*1
    ball(5).y  = sh/4 + br*2+0.8
    ball(5).vx = 0
    ball(5).vy = 0
    ball(5).c  = rgb(255,155,0)
    ball(6).x  = sw/2 + br*0
    ball(6).y  = sh/4 + br*4+0.8
    ball(6).vx = 0
    ball(6).vy = 0
    ball(6).c  = rgb(155,255,0)

    screen _newimage(sw, sh, 32)

    img = _newimage(sw, sh, 32)
    _dest img
    cls ,_rgba(0,0,0, 250)

    dim x, y
    dim w(1), z(1)
    for y=0 to sh
    for x=0 to sw
        dist = ((x - sw/2)/(sw/2))^2 + ((sh/2 - y)/(sh/2))^2
        if dist < 1 then
            g = 35*rnd + 14
            g = g + 35*dist

            ''uncomment for bad ass mod
            'w(0) = 1
            'w(1) = 0
            'z(0) = (x - sw/2)/100
            'z(1) = (sh/2 - y - fc)/100
            'cdiv w, w, z
            'z(0) = (x - xc)/100
            'z(1) = (y - yc)/100
            'cdiv w, w, z
            'z(0) = log(100*sqr(w(0)*w(0) + w(1)*w(1)))
            'z(1) = atan2(w(1), w(0))/(pi/8)
            'g = 0
            'g = g + 70*(abs(cos(2*pi*z(0))*cos(2*pi*z(1))))^0.7
            'if g>255 or g<0 then g=0
            'g = g - 14*rnd
            'if g>255 or g<0 then g=0
            'g = g + 100*(dist)^4

            pset (x, y), rgb(0,g,0)
        end if
    next
    next

    preset (sw, sh/2)
    for a=0 to 2*pi+0.1 step 0.1
        x = (sw/2)*cos(a)
        y = (sh/2)*sin(a)

        line -(sw/2 + x, sh/2 - y), rgb(0,255,0)
    next

    for i=0 to 1.1*br
        circle (xc, yc), i, rgb(0,0,0)
    next
    circle (xc, yc), 1.2*br, rgb(0,255,0)
    for i=1.2*br to 1.5*br
        circle (xc, yc), i, rgba(0, 255 - 50*(i - 1.2*br), 0, 100)
    next

    _dest 0
    _putimage (0,0), img

end sub

sub cdiv( w(), z1(), z2() )
    x = z1(0)
    y = z1(1)
    a = z2(0)
    b = z2(1)

    d = a*a + b*b
    w(0) = (x*a + y*b)/d
    w(1) = (y*a - x*b)/d
end sub
