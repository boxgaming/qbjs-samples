'===========
'BALLSUB.BAS v1.1
'===========
'Simple Ball SUB that draws balls of different textures.
'Coded by Dav, AUGUST/2023

'New for v1.1: - Added 3 textures: Voronoi, checkered, fabric.

'Ball types: Solid, Gradient, planet, plasma, noisey, striped,
'            plasma mixed, Voronoi pattern, checkered, fabric.



RANDOMIZE TIMER

SCREEN _NEWIMAGE(1000, 600, 32)

DO
    'show all kinds of balls
    ball INT(RND * 10), RND * _WIDTH, RND * _HEIGHT, RND * 300 + 25, RND * 255, RND * 255, RND * 255, 100 + RND * 155
    _LIMIT 10
LOOP UNTIL INKEY$ <> ""


SUB ball (kind, x, y, size, r, g, b, a)
    'SUB by Dav that draws many types of filled balls (circles).
    'Not super fast, but small and easy to add to your programs.

    'kind=0 (Gradient)
    'kind=1 (noisey)
    'kind=2 (planets)
    'kind=3 (plasma)
    'kind=4 (striped)
    'kind=5 (plasma mixed)
    'kind=6 (solid, non gradient)
    'kind-7 (voronoi pattern)
    'kind=8 (checkered pattern)
    'kind=9 (fabric)

    'The DIMs makes the SUB QBJS compatible
    '(these are not needed if using QB64)
    DIM displayStatus%%, t, y2, x2, clr, noise, dx, dy, dis
    DIM scale, xf, yf, cell, cellsize, closest, min, p, Points


    '=== check for and do special drawing kinds first

    'fabric pattern
    IF kind = 9 THEN
        scale = size / 30
        IF scale < 3 THEN scale = 3
        IF scale > 9 THEN scale = 9
        FOR y2 = y - size TO y + size
            FOR x2 = x - size TO x + size
                IF SQR((x2 - x) ^ 2 + (y2 - y) ^ 2) <= size THEN
                    clr = (size - (SQR((x2 - x) * (x2 - x) + (y2 - y) * (y2 - y)))) / size
                    noise = INT(RND * 100)
                    xf = x2 + INT(SIN(((x2 - size) / scale)) * scale)
                    yf = y2 + INT(COS(((y2 - size) / scale)) * scale)
                    PSET (xf, yf), _RGBA(clr * r - noise, clr * g - noise, clr * b - noise, a)
                END IF
            NEXT
        NEXT
        EXIT SUB
    END IF

    'checkered ball
    IF kind = 8 THEN
        cellsize = INT(size / 4)
        IF cellsize < 5 THEN cell = 5
        FOR y2 = y - size TO y + size
            FOR x2 = x - size TO x + size
                IF SQR((x2 - x) ^ 2 + (y2 - y) ^ 2) <= size THEN
                    clr = (size - (SQR((x2 - x) * (x2 - x) + (y2 - y) * (y2 - y)))) / size
                    IF x2 MOD cellsize < (cellsize / 2) THEN
                        IF y2 MOD cellsize < (cellsize / 2) THEN
                            PSET (x2, y2), _RGBA(clr * r - noise, clr * g - noise, clr * b - noise, a)
                        ELSE
                            PSET (x2, y2), _RGBA(1, 1, 1, a)
                        END IF
                    ELSE
                        IF y2 MOD cellsize < (cellsize / 2) THEN
                            PSET (x2, y2), _RGBA(1, 1, 1, a)
                        ELSE
                            PSET (x2, y2), _RGBA(clr * r - noise, clr * g - noise, clr * b - noise, a)
                        END IF
                    END IF

                END IF
            NEXT
        NEXT
        EXIT SUB
    END IF

    'Voronoi pattern
    IF kind = 7 THEN
        Points = INT(size / 25)
        IF Points < 7 THEN Points = 7
        DIM PointX(Points), PointY(Points), PointR(Points), PointG(Points), PointB(Points)
        FOR p = 1 TO Points
            PointX(p) = x + (RND * size * 2) - (size)
            PointY(p) = y + (RND * size * 2) - (size)
            PointR(p) = RND * 255
            PointG(p) = RND * 255
            PointB(p) = RND * 255
        NEXT
        FOR x2 = x - size TO x + size
            FOR y2 = y - size TO y + size
                IF SQR((x2 - x) ^ 2 + (y2 - y) ^ 2) <= size THEN
                    min = SQR((x2 - PointX(1)) ^ 2 + (y2 - PointY(1)) ^ 2)
                    closest = 1
                    FOR p = 2 TO Points
                        dis = SQR((x2 - PointX(p)) ^ 2 + (y2 - PointY(p)) ^ 2)
                        IF dis < min THEN min = dis: closest = p
                    NEXT
                    PSET (x2, y2), _RGBA(PointR(closest) - min, PointG(closest) - min, PointB(closest) - min, a)
                END IF
            NEXT
        NEXT
        EXIT SUB
    END IF


    '==== All other ball textures follow (they use same drawing method)

    'get current display status to restore later
    displayStatus%% = _AUTODISPLAY

    'turn off screen updates while we draw
    _DISPLAY

    t = TIMER
    FOR y2 = y - size TO y + size
        FOR x2 = x - size TO x + size
            IF SQR((x2 - x) ^ 2 + (y2 - y) ^ 2) <= size THEN

                clr = (size - (SQR((x2 - x) * (x2 - x) + (y2 - y) * (y2 - y)))) / size
                SELECT CASE kind
                    CASE 1: 'noisey (grainy)
                        noise = RND * 255
                    CASE 2: 'planet
                        noise = 20 * SIN((x2 + y2) / 30) + 10 * SIN((x2 + y2) / 10)
                    CASE 3: 'plasma
                        r = (SIN(x2 / (size / 4)) + SIN(y2 / size / 2)) * 128 + 128
                        g = (SIN(x2 / (size / 6)) + COS(y2 / (size / 4))) * 128 + 128
                        b = (COS(x2 / (size / 4)) + SIN(y2 / (size / 6))) * 128 + 128
                    CASE 4: 'striped
                        dx = x2 - size: dy = y2 - size
                        dis = SQR(dx * dx + dy * dy)
                        r = SIN(dis / 5) * 255
                        g = COS(dis / 25) * 255
                        b = 255 - SIN(dis / 50) * 255
                    CASE 5: 'plasma mix with gradient & noise
                        noise = INT(RND * 50)
                        r = SIN(6.005 * t) * size - y2 + size + 255
                        g = SIN(3.001 * t) * size - x2 + size + 255
                        b = SIN(2.001 * x2 / size + t + y2 / size) * r + 255
                        t = t + .00195
                    CASE ELSE: 'solid & gradient (no noise)
                        noise = 0
                END SELECT
                IF kind = 6 THEN
                    'if solid color only, then...
                    PSET (x2, y2), _RGBA(r, g, b, a)
                ELSE
                    '...else, with noise & gradient color aware
                    PSET (x2, y2), _RGBA(clr * r - noise, clr * g - noise, clr * b - noise, a)
                END IF
            END IF
        NEXT
    NEXT

    'show the ball on the screen
    _DISPLAY

    'If autodislay was previously on, turn it back on
    IF displayStatus%% = 1 THEN _AUTODISPLAY

END SUB
