N = 7
DIM d(N)
SCREEN 12
FOR k = 1 TO 5
    LOCATE 1, 1
    FOR i = 2 TO N
        r = INT(RND * 90 + 9)
        d(i) = d(i - 1) + r
        COLOR _RGB(100 * i, 0, 0)
        PRINT r
    NEXT
    COLOR _RGB(0, 100, 0)
    PRINT "SUM= "; d(N)
    FOR i = 1 TO N
        d(i) = d(i) / d(N) * _PI(2)
        IF d(i) >= _PI(2) THEN d(i) = _PI(2) - .01
    NEXT
    FOR j = 0 TO 100 STEP .4
        FOR i = 2 TO N
            IF (i MOD 2) = 0 THEN
                CIRCLE (320, 240), j, _RGB(i * 100,0,0), d(i-1), d(i)
                CIRCLE (320, 240), 200-j, _RGB(0, i* 100,0), d(i-1), d(i)
            END IF
            IF (i MOD 2) = 1 THEN
                CIRCLE (320, 240), 100-j, _RGB(0,0,i * 100), d(i-1), d(i)
                CIRCLE (320, 240), 100+j, _RGB(0,i * 50,i * 50), d(i-1), d(i)
            END IF
        NEXT
        _DELAY .016
    NEXT
    _DELAY 1
NEXT