' Converted to QBJS from specbas sample by ZXDunny
' PROG demos:graphics/deep field
' REM Deep Field by P Malin
RANDOMIZE TIMER
DIM G, t1, q1, u1, v1, A, R, Q, a1, M, C, i1, S, T, D, Z, x1, U, clr
DIM pal()
'SCREEN _NEWIMAGE(1280, 768)
SCREEN _NEWIMAGE(_RESIZEWIDTH-5, _RESIZEHEIGHT-5)
DIM points(_WIDTH, _HEIGHT)
CLS
pal(1) = &HFFFF0000: pal(2) = &HFFFF8000: pal(3) = &HFFFFFF00: pal(4) = &HFFFFFF80: pal(5) = &HFFFFFFFF
FOR G = -64 TO 800
    t1=RND*99: q1=RND*99
    u1=RND*_WIDTH: v1=RND*_HEIGHT
    A=RND*3: R=90/(1+RND*200): Q=1+R*(.5+RND/2)
    a1=1+3*RND^2: M=1: C=(1+3*RND^2)*R*R
    IF RND*9<4 THEN
        Q=R: t1=0: q1=0: A=0: M=_PI/3: a1=1
     END IF
     FOR i1 = 0 TO C
         S=-LOG(RND): T=i1*M: U=S*R*SIN(T): V=S*Q*COS(T)
         T=S*A: X=U*COS(T)+V*SIN(T): Y=V*COS(T)-U*SIN(T)
         D=(X*X+Y*Y)/(R*R+Q*Q): Z=99*((2.7^-D)+.1)
         Z=Z*(RND-.5)^3: y1=Y*COS(t1)+Z*SIN(t1): Z=Z*COS(t1)-Y*SIN(t1)
         x1=u1+X*COS(q1)+y1*SIN(q1): y1=v1-X*SIN(q1)+y1*COS(q1)
         x1p = _ROUND(x1): y1p = _ROUND(y1)
         clr = _ROUND(min(5, max(0, points(x1p,y1p)) + a1))
         PSET (x1p, y1p), pal(clr) 
         points(x1p, y1p) = clr
    NEXT i1
NEXT G

FUNCTION MIN(var1, var2)
    IF var1 < var2 THEN MIN = var1 ELSE MIN = var2
END FUNCTION

FUNCTION MAX(var1, var2)
    IF var1 > var2 THEN MAX = var1 ELSE MAX = var2
END FUNCTION