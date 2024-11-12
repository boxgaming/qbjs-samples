type ptype
    x as double
    y as double
    vx as double
    vy as double
end type
 
dim shared sw, sh, mx, my, mb, mw
 
sw = 800
sh = 600
screen _newimage(sw, sh, 32)
if _resize then
    sw = _resizewidth - 20
    sh = _resizeheight - 20
    screen _newimage(sw, sh, 32)
end if
 
img = _newimage(sw, sh, 32)
'cls ,_rgba(0,0,0,0)
 
 
score = 500
amount = 10
 
h = 50
rp = 7
rb = 12
 
redim pin(1000) as ptype
rows = 8
x = sw/2 - 2*h
y = (sh - rows*h)/2
m=0
for i=2 to rows + 2
    for j=1 to i + 1
        if j=1 then
            pin(m).vx = 1
        elseif j=i+1 then
            pin(m).vx = -1
        else
            pin(m).vx = 0
        end if
 
        pin(m).x = x + j*h
        pin(m).y = y
        'circle (pin(m).x, pin(m).y), rp
        m = m + 1
    next
    x = x - h/2
    y = y + h
next
 
redim ball(2) as ptype
n = -1
for i=0 to n
    ball(i).x = sw/2 - h + rp + (2*h - rp)*rnd 
    ball(i).y = (sh - rows*h)/2 - h*0.5
    ball(i).vx = 0
    ball(i).vy = 0
 
    score = score - amount
next
 
 
 
_dest img
cls
for i=0 to m-1
    circle(pin(i).x, pin(i).y), rp, _rgb(200,200,200)
next
y0 = (sh - rows*h)/2
'line (0, sh - y)-step(sw, 0)
for i=0 to rows+1
    if i=0 or i=rows+1 then
        color _rgb(255,0,0)
        _printstring ((sw - (rows+2)*h)/2 + i*h, sh - y0 + h/2), "  10x"
    elseif i=1 or i=rows then
        color _rgb(255,80,0)
        _printstring ((sw - (rows+2)*h)/2 + i*h, sh - y0 + h/2), "  4x"
    elseif i=2 or i=rows-1 then
        color _rgb(255,150,0)
        _printstring ((sw - (rows+2)*h)/2 + i*h, sh - y0 + h/2), "  2x"
    elseif i>2 or i<rows-1 then
        color _rgb(155,155,0)
        _printstring ((sw - (rows+2)*h)/2 + i*h, sh - y0 + h/2), " 0.2x"
    end if
next
 
x0 = (sw - (rows+2)*h)/2 
line (x0, y0-200)-step((rows+2)*h,140),_rgb(155,155,155),b
 
q = ""
 
_dest 0
mb_state = 0
do
    mx = _mousex
    my = _mousey
    mb = _mousebutton(1)
 
 
    _putimage (0,0),img
 
    for i=0 to n
        for r=1 to rb
            circle(ball(i).x, ball(i).y), r, _rgb(155,0,0)
        next
        circle(ball(i).x, ball(i).y), rb, _rgb(255,0,0)
        circle(ball(i).x, ball(i).y), rb-3, _rgb(255,0,0)
 
        ball(i).x = ball(i).x + ball(i).vx
        ball(i).y = ball(i).y + ball(i).vy 
        ball(i).vy = ball(i).vy + 0.2
 
        for j=0 to m-1
            d = (ball(i).x - pin(j).x)^2 + (ball(i).y - pin(j).y)^2
 
            if d <= (rp + rb)^2 then
                a = atan2(ball(i).y - pin(j).y, ball(i).x - pin(j).x)
 
                if abs(a + pi/2) < 0.0001 then
                    ball(i).vx = 0.1*ball(i).vx
                    ball(i).vy = 0.1*ball(i).vy
                    
                    if rnd > 0.5 then aa = 1 else aa = -1
                    if abs(pin(j).vx)>0.0001 then aa = pin(j).vx
                
                    ball(i).x = pin(j).x + (rp + rb + 0)*cos(a + aa*0.2)
                    ball(i).y = pin(j).y + (rp + rb + 0)*sin(a + aa*0.2)
                else
                    v = sqr(ball(i).vx^2 + ball(i).vy^2)
 
                    ball(i).vx = 0.5*v*cos(a)
                    ball(i).vy = 0.5*v*sin(a)
 
                    ball(i).x = pin(j).x + (rp + rb + 0)*cos(a )
                    ball(i).y = pin(j).y + (rp + rb + 0)*sin(a )
                end if
 
                circle (pin(j).x, pin(j).y), rb, _rgb(255,255,255)
            end if
        next
 
 
        if ball(i).y > sh - (sh - rows*h)/2 then
 
            if ball(i).x > x0 and ball(i).x < x0+h then
                q = q + ", 10x"
                score = score + amount*10
            elseif ball(i).x > x0+9*h and ball(i).x < x0+10*h then
                q = q + ", 10x"
                score = score + amount*10
            elseif ball(i).x > x0+1*h and ball(i).x < x0+2*h then
                q = q + ", 4x"
                score = score + amount*4
            elseif ball(i).x > x0+8*h and ball(i).x < x0+9*h then
                q = q + ", 4x"
                score = score + amount*4
            elseif ball(i).x > x0+2*h and ball(i).x < x0+3*h then
                q = q + ", 2x"
                score = score + amount*2
            elseif ball(i).x > x0+7*h and ball(i).x < x0+8*h then
                q = q + ", 2x"
                score = score + amount*2
            elseif ball(i).x > x0+3*h and ball(i).x < x0+6*h then
                q = q + ", 0.2x"
                score = score + amount*0.2
            end if
 
 
            for j=i to n-1
                ball(j).x  = ball(j + 1).x 
                ball(j).y  = ball(j + 1).y 
                ball(j).vx = ball(j + 1).vx
                ball(j).vy = ball(j + 1).vy
            next
            n = n - 1
            redim _preserve ball(n) 
 
      end if
    next
 
    w0 = (rows+2)*h
 
    color _rgb(0,255,0)
    _printstring (x0 + 10, y0-200+10), "$"+_trim(str(int(score)))
 
    color _rgb(255,0,0)
    a = "$"+_trim(str(int(amount)))
    _printstring(x0 +(rows+2)*h - len(a)*8 - 10, y0-200+10), a
 
    color _rgb(155,155,0)
    _printstring (x0 + 10, y0-200+140-16-10), right(q, w0/8 - 2)
 
 
    if mx > x0 and mx < x0+w0 and my>y0-200 and my<y0-200+140 then
        color _rgb(255,0,0)
 
        if mb then mb_state = -1
        if mb_state and mb = 0 then
            mb_state = 0
 
            n = n + 1
            redim _preserve ball(n) 
            ball(n).x = sw/2 - h + rp + (2*h - rp)*rnd 
            ball(n).y = (sh - rows*h)/2 - h*0.5
            ball(n).vx = 0
            ball(n).vy = 0
 
            score = score - amount
        end if
    else
        color _rgb(155,155,155)
    end if
    _printstring (sw/2 - 15, y0-200+60), "Play"
 
    if _keydown(18432) then amount = amount + 1
    if amount > 1 then
        if _keydown(20480) then amount = amount - 1
    end if
 
    _display
    _limit 60
loop until _keyhit = 27
