dim w, h, pi
pi = 4*atn(1)
w = 640
h = 480
screen _newimage(w, h, 32)
dim i, t, x, y
t = 0
do
    t = t+0.1
    cls
    for i=1 to 4
        for x=0 to w
            y = 100*sin(pi*x/w)*sin(3*pi*x/w + t + i*t*pi*0.01)
            pset (x, h/2 - y)
        next
    next
    _limit 60
loop