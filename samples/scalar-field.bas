OPTION _EXPLICIT

DO UNTIL _SCREENEXISTS: LOOP
_TITLE "Scalar Field"

SCREEN _NEWIMAGE(800, 600, 32)
RANDOMIZE TIMER

TYPE Vector
    x AS DOUBLE
    y AS DOUBLE
END TYPE

DIM SHARED Position(10) AS Vector
DIM SHARED Velocity(10) AS Vector
DIM AS INTEGER j, k
DIM AS DOUBLE f, f1, f3, f7, f9, g

FOR j = 1 TO UBOUND(Position)
    Position(j).x = _WIDTH * (RND - .5)
    Position(j).y = _HEIGHT * (RND - .5)
    Velocity(j).x = 5 * (RND - .5)
    Velocity(j).y = 5 * (RND - .5)
NEXT

DO
    CLS

    FOR j = 1 TO UBOUND(Position)
        Position(j).x = Position(j).x + Velocity(j).x
        Position(j).y = Position(j).y + Velocity(j).y
        IF (Position(j).x < -_WIDTH / 2) THEN Velocity(j).x = -Velocity(j).x
        IF (Position(j).x > _WIDTH / 2) THEN Velocity(j).x = -Velocity(j).x
        IF (Position(j).y < -_HEIGHT / 2) THEN Velocity(j).y = -Velocity(j).y
        IF (Position(j).y > _HEIGHT / 2) THEN Velocity(j).y = -Velocity(j).y
    NEXT

    FOR j = -_WIDTH / 2 TO _WIDTH / 2 STEP 10
        FOR k = -_HEIGHT / 2 TO _HEIGHT / 2 STEP 10
            f = 15 * CalcPotential#(j, k)
            CALL CCircle(j, k, 4, _RGB(255 * f, 255 * f / 2, 255 * f / 4))
            'NEXT
            'NEXT

            'FOR j = -_WIDTH / 2 TO _WIDTH / 2 STEP 10
            'FOR k = -_HEIGHT / 2 TO _HEIGHT / 2 STEP 10
            f1 = 10 * CalcPotential#(j - 5, k - 5)
            f3 = 10 * CalcPotential#(j + 5, k - 5)
            f7 = 10 * CalcPotential#(j - 5, k + 5)
            f9 = 10 * CalcPotential#(j + 5, k + 5)
            FOR g = .15 TO .65 STEP .1
                f = .5
                IF (f1 > g) AND (f3 > g) AND (f7 > g) AND (f9 > g) THEN f = 1
                IF (f1 < g) AND (f3 < g) AND (f7 < g) AND (f9 < g) THEN f = 0
                IF (f = .5) THEN
                    IF (f1 < g) AND (f3 < g) AND (f7 > g) AND (f9 > g) THEN CALL CLine(j - 5, k, j + 5, k, _RGB(255, 255, 255 / 2))
                    IF (f1 > g) AND (f3 > g) AND (f7 < g) AND (f9 < g) THEN CALL CLine(j - 5, k, j + 5, k, _RGB(255, 255, 255 / 2))
                    IF (f1 > g) AND (f3 < g) AND (f7 > g) AND (f9 < g) THEN CALL CLine(j, k - 5, j, k + 5, _RGB(255, 255, 255 / 2))
                    IF (f1 < g) AND (f3 > g) AND (f7 < g) AND (f9 > g) THEN CALL CLine(j, k - 5, j, k + 5, _RGB(255, 255, 255 / 2))
                    IF (f1 > g) AND (f3 < g) AND (f7 < g) AND (f9 < g) THEN CALL CLine(j - 5, k, j, k - 5, _RGB(255, 255, 255 / 2))
                    IF (f1 < g) AND (f3 > g) AND (f7 < g) AND (f9 < g) THEN CALL CLine(j, k - 5, j + 5, k, _RGB(255, 255, 255 / 2))
                    IF (f1 < g) AND (f3 < g) AND (f7 > g) AND (f9 < g) THEN CALL CLine(j - 5, k, j, k + 5, _RGB(255, 255, 255 / 2))
                    IF (f1 < g) AND (f3 < g) AND (f7 < g) AND (f9 > g) THEN CALL CLine(j, k + 5, j + 5, k, _RGB(255, 255, 255 / 2))
                END IF
            NEXT
        NEXT
    NEXT

    _DISPLAY
    _LIMIT 60
LOOP

END

FUNCTION CalcPotential# (x0 AS DOUBLE, y0 AS DOUBLE)
    DIM TheReturn AS DOUBLE
    DIM AS INTEGER j
    DIM AS DOUBLE dx, dy, r
    TheReturn = 0
    FOR j = 1 TO UBOUND(Position)
        dx = x0 - Position(j).x
        dy = y0 - Position(j).y
        r = SQR(dx * dx + dy * dy)
        TheReturn = TheReturn + 1 / r
    NEXT
    CalcPotential# = TheReturn
END FUNCTION

SUB CCircle (x0 AS DOUBLE, y0 AS DOUBLE, rad AS DOUBLE, shade AS _UNSIGNED LONG)
    CIRCLE (_WIDTH / 2 + x0, -y0 + _HEIGHT / 2), rad, shade
END SUB

SUB CLine (x0 AS DOUBLE, y0 AS DOUBLE, x1 AS DOUBLE, y1 AS DOUBLE, shade AS _UNSIGNED LONG)
    LINE (_WIDTH / 2 + x0, -y0 + _HEIGHT / 2)-(_WIDTH / 2 + x1, -y1 + _HEIGHT / 2), shade
END SUB

