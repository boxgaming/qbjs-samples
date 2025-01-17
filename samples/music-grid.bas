DIM SHARED grid(16, 16), grid2(16, 16), cur
CONST maxx = 512
CONST maxy = 512
SCREEN _NEWIMAGE(maxx, maxy, 32)
_TITLE "MusicGrid"
cleargrid
DIM t#, inp$, cur, oldcur
DO
    IF TIMER - t# > 1 / 8 THEN cur = (cur + 1) AND 15: t# = TIMER
    IF cur <> oldcur THEN
        figuregrid
        drawgrid
        playgrid
        oldcur = cur
    END IF
    domousestuff
    inp$ = INKEY$
    IF inp$ = "C" OR inp$ = "c" THEN cleargrid
    _LIMIT 60
LOOP UNTIL inp$ = CHR$(27)

SUB drawgrid
    DIM scale, scale2, c&
    scale = maxx / 16
    scale2 = FIX(maxx \ 16 - 2)
    FOR y = 0 TO 15
        y1 = y * scale!
        FOR x = 0 TO 15
            x1 = x * scale
            c& = _RGB32(grid2(x, y) * 64 + 64, 0, 0)
            LINE (x1, y1)-(x1 + scale2, y1 + scale2), c&, BF
        NEXT x
    NEXT y
END SUB

SUB figuregrid
    DIM x, y
    FOR y = 0 TO 15
        FOR x = 0 TO 15
            grid2(x, y) = grid(x, y)
        NEXT x
    NEXT y
    FOR y = 1 TO 14
        FOR x = 1 TO 14
            IF grid(x, y) = 1 AND cur = x THEN
                grid2(x, y) = 2
                IF grid(x - 1, y) = 0 THEN grid2(x - 1, y) = 1
                IF grid(x + 1, y) = 0 THEN grid2(x + 1, y) = 1
                IF grid(x, y - 1) = 0 THEN grid2(x, y - 1) = 1
                IF grid(x, y + 1) = 0 THEN grid2(x, y + 1) = 1
            END IF
        NEXT x
    NEXT y
END SUB

SUB domousestuff
    DIM x, y
    DO WHILE _MOUSEINPUT
        IF _MOUSEBUTTON(1) THEN
            x = FIX(_MOUSEX \ FIX(maxx \ 16))
            y = FIX(_MOUSEY \ FIX(maxy \ 16))
            grid(x, y) = 1 - grid(x, y)
        END IF
    LOOP
END SUB

SUB playgrid
    DIM n$, note$, x, y, scale$
    n$ = "L16 "
    scale$ = "o1fo1go1ao2co2do2fo2go2ao3co3do3fo3go3ao4co4do4fo"
    FOR y = 15 TO 0 STEP -1
        IF grid(cur, y) = 1 THEN
            note$ = MID$(scale$, 1 + (15 - y) * 3, 3)
            n$ = n$ + note$ + "," 'comma plays 2 or more column notes simultaneously
        END IF
    NEXT y
    n$ = LEFT$(n$, LEN(n$) - 1)
    PLAY n$
END SUB

SUB cleargrid
    DIM x, y
    FOR y = 0 TO 15
        FOR x = 0 TO 15
            grid(x, y) = 0
        NEXT x
    NEXT y
END SUB