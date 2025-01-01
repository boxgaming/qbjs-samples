dim pi
pi = 4*atn(1)

dim x1, y1, x2, y2
x1 = -pi
x2 = pi
y1 = 1.2
y2 = -1.2

dim w, h
w = 800
h = 600
screen _newimage(w, h)

dim redraw
redraw = 1

window screen(x1, y1)-(x2, y2)

do
if _resize then
    w = _resizewidth - 20
    h = _resizeheight - 20
    screen _newimage(w, h)
    window screen(x1, y1)-(x2, y2)
    redraw = 1
end if

if redraw then
cls
dim a
for a = x1 to x2 step pi/4
    line (a, y1)-(a, y2),_rgb(50,50,50)
next
for a = y1 to y2 step -0.1
    line (x1, a)-(x2, a),_rgb(50,50,50)
next
line (0, y1)-(0, y2),_rgb(150,150,150)
line (x1, 0)-(x2, 0),_rgb(150,150,150)

dim x, y

color _rgb(200,0,0): locate 1,1: print "y = sin(x)"
pset (x1, 0)
for x=x1 to x2 step 0.01 

    y = sin(x)
    
    line -(x, y), _rgb(200,0,0)
next

color _rgb(0,200,0): locate 2,1: print "y = (tanh(x) + 1)/2"
pset (x1, 0)
for x=x1 to x2 step 0.01 

    y = 0.5 + 0.5*(exp(2*x) - 1)/(exp(2*x) + 1)
    
    line -(x, y), _rgb(0,200,0)
next

color _rgb(255,255,0): locate 3,1: print "y = smoothstep(x)"
pset (x1, 0)
for x=x1 to x2 step 0.01 

    y = (3*x^2 - 2*x^3)*(x>=0 and x<1) + (x>=1)
    
    line -(x, y), _rgb(255,255,0)
next

color _rgb(100,100,0): locate 4,1: print "y = smootherstep(x)"
pset (x1, 0)
for x=x1 to x2 step 0.01 

    y = (-20*x^7 + 70*x^6 - 84*x^5 + 35*x^4)*(x>=0 and x<1) + (x>=1)
    
    line -(x, y), _rgb(100,100,0)
next

redraw = 0
end if
loop