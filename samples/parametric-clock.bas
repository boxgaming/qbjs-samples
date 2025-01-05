_TITLE "Parametric Clock"

DIM SHARED MainScreen AS LONG
DIM SHARED BackScreen AS LONG
MainScreen = _NEWIMAGE(600, 600, 32)
BackScreen = _NEWIMAGE(600, 600, 32)
SCREEN MainScreen

RANDOMIZE TIMER

DIM SHARED pi AS DOUBLE
DIM SHARED phi AS DOUBLE
pi = 4 * ATN(1)
phi = (1 + SQR(5)) / 2

TYPE TimeValue
    Hour AS INTEGER
    Minute AS INTEGER
    Second AS DOUBLE
    TenthSecond AS DOUBLE
END TYPE

TYPE Vector
    x AS DOUBLE
    y AS DOUBLE
END TYPE

TYPE ClockHand
    Center AS Vector
    HandPosition AS Vector
    Length AS DOUBLE
    Angle AS DOUBLE
    Shade AS _UNSIGNED LONG
END TYPE

DIM SHARED TheTime AS TimeValue
DIM SHARED HourHand AS ClockHand
DIM SHARED MinuteHand AS ClockHand
DIM SHARED SecondHand AS ClockHand
DIM SHARED TenthSecondHand AS ClockHand

DIM SHARED Mode AS INTEGER
DIM SHARED ModeList(12) AS INTEGER
DIM SHARED TimeShift AS DOUBLE
TimeShift = 0

HourHand.Center.x = 0
HourHand.Center.y = 0
HourHand.Length = 150
MinuteHand.Length = HourHand.Length / (phi)
SecondHand.Length = HourHand.Length / (phi ^ 2)
TenthSecondHand.Length = HourHand.Length / (phi ^ 3)
HourHand.Shade = _RGB32(200, 50, 50, 255)
MinuteHand.Shade = _RGB32(65, 105, 225, 255)
SecondHand.Shade = _RGB32(255, 165, 0, 255)
TenthSecondHand.Shade = _RGB32(138, 43, 226, 255)

CALL InitializeModes
Mode = 12

CALL PrepareClockface(1)
DO
    CALL KeyProcess
    CALL UpdateTime(TIMER + TimeShift)
    CALL UpdateClock
    CALL DrawEverything
    _KEYCLEAR
    _LIMIT 60
LOOP

SYSTEM

SUB InitializeModes
    DIM k AS INTEGER
    FOR k = 1 TO 12
        ModeList(k) = k
    NEXT
END SUB

SUB PrepareClockface (metric AS INTEGER)
    DIM p AS DOUBLE
    DIM q AS LONG
    _DEST BackScreen
    CLS
    CALL ccircle(0, 0, HourHand.Length, HourHand.Shade)
    p = RND
    FOR q = 0 TO ((Mode * 3600) - (metric)) STEP (metric)
        CALL UpdateTime(q)
        CALL UpdateClock
        CALL lineSmooth(SecondHand.Center.x, SecondHand.Center.y, SecondHand.HandPosition.x, SecondHand.HandPosition.y, _RGB32(255 * p, 255 * RND * 155, 255 * (1 - p), 10))
    NEXT
    FOR q = 0 TO ((Mode * 3600) - (3600)) STEP (3600)
        CALL UpdateTime(q)
        CALL UpdateClock
        CALL ccircle(HourHand.HandPosition.x, HourHand.HandPosition.y, 6, HourHand.Shade)
        CALL ccirclefill(HourHand.HandPosition.x, HourHand.HandPosition.y, 5, _RGB32(0, 0, 0, 255))
    NEXT
    _DEST MainScreen
END SUB

SUB KeyProcess
    IF (_KEYDOWN(32) = -1) THEN ' Space
        TimeShift = -TIMER
    END IF
    IF ((_KEYDOWN(114) = -1) OR (_KEYDOWN(84) = -1)) THEN ' r or R
        TimeShift = 0
    END IF
    IF (_KEYDOWN(19200) = -1) THEN ' Leftarrow
        CALL DecreaseMode
        CALL PrepareClockface(1)
        _DELAY .1
    END IF
    IF (_KEYDOWN(19712) = -1) THEN ' Rightarrow
        CALL IncreaseMode
        CALL PrepareClockface(1)
        _DELAY .1
    END IF
    IF (_KEYDOWN(18432) = -1) THEN ' Uparrow
        TimeShift = TimeShift + 60
    END IF
    IF (_KEYDOWN(20480) = -1) THEN ' Downarrow
        TimeShift = TimeShift - 60
    END IF
END SUB

SUB UpdateTime (z AS DOUBLE)
    DIM t AS DOUBLE
    t = z
    TheTime.Hour = INT(t / 3600)
    t = t - TheTime.Hour * 3600
    TheTime.Hour = TheTime.Hour MOD Mode
    IF (TheTime.Hour = 0) THEN TheTime.Hour = Mode
    TheTime.Minute = INT(t / 60)
    t = t - TheTime.Minute * 60
    TheTime.Second = t
    TheTime.TenthSecond = (TheTime.Second - INT(TheTime.Second))
END SUB

SUB UpdateClock
    HourHand.Angle = -((TheTime.Hour + (TheTime.Minute / 60) + (TheTime.Second / 3600)) / Mode) * 2 * pi + (pi / 2)
    MinuteHand.Angle = -((TheTime.Minute / 60) + (TheTime.Second / 3600)) * 2 * pi + (pi / 2)
    SecondHand.Angle = -(TheTime.Second / 60) * 2 * pi + (pi / 2)
    HourHand.HandPosition.x = HourHand.Center.x + HourHand.Length * COS(HourHand.Angle)
    HourHand.HandPosition.y = HourHand.Center.y + HourHand.Length * SIN(HourHand.Angle)
    MinuteHand.Center.x = HourHand.HandPosition.x
    MinuteHand.Center.y = HourHand.HandPosition.y
    MinuteHand.HandPosition.x = MinuteHand.Center.x + MinuteHand.Length * COS(MinuteHand.Angle)
    MinuteHand.HandPosition.y = MinuteHand.Center.y + MinuteHand.Length * SIN(MinuteHand.Angle)
    SecondHand.Center.x = MinuteHand.HandPosition.x
    SecondHand.Center.y = MinuteHand.HandPosition.y
    SecondHand.HandPosition.x = SecondHand.Center.x + SecondHand.Length * COS(SecondHand.Angle)
    SecondHand.HandPosition.y = SecondHand.Center.y + SecondHand.Length * SIN(SecondHand.Angle)
END SUB

SUB DrawEverything
    CLS
    _PUTIMAGE (0, 0)-(_WIDTH, _HEIGHT), BackScreen, MainScreen, (0, 0)-(_WIDTH, _HEIGHT)
    CALL DrawModeList
    CALL DrawHUD
    CALL DrawClockHands
    CALL DrawDigitalClock
    _DISPLAY
END SUB

SUB DrawModeList
    DIM k AS INTEGER
    FOR k = 1 TO UBOUND(ModeList)
        IF (Mode = k) THEN
            COLOR _RGB32(255, 255, 0, 255), _RGB32(0, 0, 255, 255)
        ELSE
            COLOR _RGB32(100, 100, 100, 255), _RGB32(0, 0, 0, 0)
        END IF
        _PRINTSTRING ((4 + 5 * k) * 8, _HEIGHT - (1) * 16), LTRIM$(RTRIM$(STR$(ModeList(k))))
    NEXT
    COLOR _RGB32(200, 200, 0, 255), _RGB32(0, 0, 0, 0)
    '_PRINTSTRING ((4 + 1) * 8, _HEIGHT - (1) * 16), ">"
    '_PRINTSTRING ((4 + 5 * (UBOUND(ModeList) + 1)) * 8, _HEIGHT - (1) * 16), "<"
END SUB

SUB IncreaseMode
    IF (Mode < 12) THEN
        Mode = Mode + 1
    ELSE
        Mode = 1
    END IF
END SUB

SUB DecreaseMode
    IF (Mode = 1) THEN
        Mode = 12
    ELSE
        Mode = Mode - 1
    END IF
END SUB

SUB DrawClockHands
    DIM k AS DOUBLE
    DIM ctmp AS _UNSIGNED LONG
    DIM SeedLength AS DOUBLE
    SeedLength = 12
    FOR k = 0 TO 1 STEP .01
        ctmp = ColorMix(_RGB32(0, 0, 255, 255), HourHand.Shade, k)
        ctmp = _RGB32(_RED32(ctmp), _GREEN32(ctmp), _BLUE32(ctmp), 255)
        CALL ccirclefill(HourHand.Center.x + (k * HourHand.Length) * COS(HourHand.Angle), HourHand.Center.y + (k * HourHand.Length) * SIN(HourHand.Angle), k * SeedLength, ctmp)
    NEXT
    FOR k = 0 TO 1 STEP .01
        ctmp = ColorMix(HourHand.Shade, MinuteHand.Shade, k)
        ctmp = _RGB32(_RED32(ctmp), _GREEN32(ctmp), _BLUE32(ctmp), 255)
        CALL ccirclefill(MinuteHand.Center.x + (k * MinuteHand.Length) * COS(MinuteHand.Angle), MinuteHand.Center.y + (k * MinuteHand.Length) * SIN(MinuteHand.Angle), SeedLength * (1 - k / phi), ctmp)
    NEXT
    FOR k = 0 TO 1 STEP .005
        ctmp = ColorMix(MinuteHand.Shade, SecondHand.Shade, k)
        ctmp = _RGB32(_RED32(ctmp), _GREEN32(ctmp), _BLUE32(ctmp), 255)
        CALL ccirclefill(SecondHand.Center.x + (k * SecondHand.Length) * COS(SecondHand.Angle), SecondHand.Center.y + (k * SecondHand.Length) * SIN(SecondHand.Angle), (SeedLength * (1 - 1 / phi)) * (1 - k), ctmp)
    NEXT

    CALL DrawPulley(HourHand.Center.x, HourHand.Center.x, 0, HourHand.HandPosition.x, HourHand.HandPosition.y, SeedLength + 2, _RGB32(255, 255, 255, 255))
    CALL DrawPulley(HourHand.HandPosition.x, HourHand.HandPosition.y, SeedLength + 2, MinuteHand.HandPosition.x, MinuteHand.HandPosition.y, (SeedLength * (1 - 1 / phi)) + 1, _RGB32(255, 255, 255, 255))
    CALL DrawPulley(MinuteHand.HandPosition.x, MinuteHand.HandPosition.y, (SeedLength * (1 - 1 / phi)) + 1, SecondHand.HandPosition.x, SecondHand.HandPosition.y, 0, _RGB32(255, 255, 255, 255))
END SUB

SUB DrawDigitalClock
    DIM t AS STRING
    COLOR _RGB32(200, 200, 0, 255), _RGB32(0, 0, 0, 0)
    DIM h AS STRING
    DIM m AS STRING
    DIM s AS STRING
    DIM n AS STRING
    h = LTRIM$(RTRIM$(STR$(TheTime.Hour)))
    IF LEN(h) = 1 THEN h = "0" + h
    m = LTRIM$(RTRIM$(STR$(TheTime.Minute)))
    IF LEN(m) = 1 THEN m = "0" + m
    s = LTRIM$(RTRIM$(STR$(INT(TheTime.Second))))
    IF LEN(s) = 1 THEN s = "0" + s
    n = LTRIM$(RTRIM$(STR$((INT(10 * TheTime.TenthSecond)))))
    t = h + ":" + m + ":" + s ' + ":" + n
    LOCATE 1, (_WIDTH / 8) / 2 - LEN(t) / 2
    PRINT t
END SUB

SUB DrawHUD
    COLOR _RGB32(0, 200, 200, 255), _RGB32(0, 0, 0, 0)
    LOCATE 1, 2: PRINT "SPACE = Midnight"
    LOCATE 2, 2: PRINT "    R = Reset"
    LOCATE 1, 58: PRINT "Up Arrow = Time +"
    LOCATE 2, 58: PRINT "Dn Arrow = Time -"
END SUB

FUNCTION ColorMix~& (Shade1 AS _UNSIGNED LONG, Shade2 AS _UNSIGNED LONG, param AS DOUBLE)
    ColorMix~& = _RGB32((1 - param) * _RED32(Shade1) + param * _RED32(Shade2), (1 - param) * _GREEN32(Shade1) + param * _GREEN32(Shade2), (1 - param) * _BLUE32(Shade1) + param * _BLUE32(Shade2))
END FUNCTION

SUB cpset (x1, y1, col AS _UNSIGNED LONG)
    PSET (_WIDTH / 2 + x1, -y1 + _HEIGHT / 2), col
END SUB

SUB cline (x1 AS DOUBLE, y1 AS DOUBLE, x2 AS DOUBLE, y2 AS DOUBLE, col AS _UNSIGNED LONG)
    LINE (_WIDTH / 2 + x1, -y1 + _HEIGHT / 2)-(_WIDTH / 2 + x2, -y2 + _HEIGHT / 2), col
END SUB

SUB ccircle (x1 AS DOUBLE, y1 AS DOUBLE, rad AS DOUBLE, col AS _UNSIGNED LONG)
    CIRCLE (_WIDTH / 2 + x1, -y1 + _HEIGHT / 2), rad, col
END SUB

SUB ccirclefill (x1 AS DOUBLE, y1 AS DOUBLE, rad AS DOUBLE, col AS _UNSIGNED LONG)
    CALL CircleFill(_WIDTH / 2 + x1, -y1 + _HEIGHT / 2, rad, col)
END SUB

SUB CircleFill (CX AS INTEGER, CY AS INTEGER, R AS INTEGER, C AS _UNSIGNED LONG)
    ' CX = center x coordinate
    ' CY = center y coordinate
    '  R = radius
    '  C = fill color
    DIM Radius AS INTEGER, dr AS INTEGER
    DIM X AS INTEGER, Y AS INTEGER
    Radius = ABS(R)
    dr = -Radius
    X = Radius
    Y = 0
    IF Radius = 0 THEN PSET (CX, CY), C: EXIT SUB
    LINE (CX - X, CY)-(CX + X, CY), C, BF
    WHILE X > Y
        dr = dr + Y * 2 + 1
        IF dr >= 0 THEN
            IF X <> Y + 1 THEN
                LINE (CX - Y, CY - X)-(CX + Y, CY - X), C, BF
                LINE (CX - Y, CY + X)-(CX + Y, CY + X), C, BF
            END IF
            X = X - 1
            dr = dr - X * 2
        END IF
        Y = Y + 1
        LINE (CX - X, CY - Y)-(CX + X, CY - Y), C, BF
        LINE (CX - X, CY + Y)-(CX + X, CY + Y), C, BF
    WEND
END SUB

SUB DrawPulley (x1 AS DOUBLE, y1 AS DOUBLE, rad1 AS DOUBLE, x2 AS DOUBLE, y2 AS DOUBLE, rad2 AS DOUBLE, col AS _UNSIGNED LONG)
    DIM ang AS DOUBLE
    ang = _ATAN2(y2 - y1, x2 - x1) + pi / 2
    CALL lineSmooth(x1 + rad1 * COS(ang), y1 + rad1 * SIN(ang), x2 + rad2 * COS(ang), y2 + rad2 * SIN(ang), col)
    CALL lineSmooth(x1 - rad1 * COS(ang), y1 - rad1 * SIN(ang), x2 - rad2 * COS(ang), y2 - rad2 * SIN(ang), col)
    CALL ccircle(x1, y1, rad1, col)
    CALL ccircle(x2, y2, rad2, col)
END SUB

SUB lineSmooth (x0, y0, x1, y1, c AS _UNSIGNED LONG)
    'FellippeHeitor 2020
    'https://en.wikipedia.org/w/index.html?title=Xiaolin_Wu%27s_line_algorithm&oldid=852445548
    'STxAxTIC 2020 Correction to alpha channel.

    IF (1 = 1) THEN
        CALL cline(x0, y0, x1, y1, c)
    ELSE

        DIM plX AS INTEGER, plY AS INTEGER, plI

        DIM steep AS _BYTE
        steep = ABS(y1 - y0) > ABS(x1 - x0)

        IF steep THEN
            SWAP x0, y0
            SWAP x1, y1
        END IF

        IF x0 > x1 THEN
            SWAP x0, x1
            SWAP y0, y1
        END IF

        DIM dx, dy, gradient
        dx = x1 - x0
        dy = y1 - y0
        gradient = dy / dx

        IF dx = 0 THEN
            gradient = 1
        END IF

        'handle first endpoint
        DIM xend, yend, xgap, xpxl1, ypxl1
        xend = _ROUND(x0)
        yend = y0 + gradient * (xend - x0)
        xgap = (1 - ((x0 + .5) - INT(x0 + .5)))
        xpxl1 = xend 'this will be used in the main loop
        ypxl1 = INT(yend)
        IF steep THEN
            plX = ypxl1
            plY = xpxl1
            plI = (1 - (yend - INT(yend))) * xgap
            CALL cpset(plX, plY, _RGB32(_RED32(c), _GREEN32(c), _BLUE32(c), plI * _ALPHA32(c)))

            plX = ypxl1 + 1
            plY = xpxl1
            plI = (yend - INT(yend)) * xgap
            CALL cpset(plX, plY, _RGB32(_RED32(c), _GREEN32(c), _BLUE32(c), plI * _ALPHA32(c)))
        ELSE
            plX = xpxl1
            plY = ypxl1
            plI = (1 - (yend - INT(yend))) * xgap
            CALL cpset(plX, plY, _RGB32(_RED32(c), _GREEN32(c), _BLUE32(c), plI * _ALPHA32(c)))

            plX = xpxl1
            plY = ypxl1 + 1
            plI = (yend - INT(yend)) * xgap
            CALL cpset(plX, plY, _RGB32(_RED32(c), _GREEN32(c), _BLUE32(c), plI * _ALPHA32(c)))
        END IF

        DIM intery
        intery = yend + gradient 'first y-intersection for the main loop

        'handle second endpoint
        DIM xpxl2, ypxl2
        xend = _ROUND(x1)
        yend = y1 + gradient * (xend - x1)
        xgap = ((x1 + .5) - INT(x1 + .5))
        xpxl2 = xend 'this will be used in the main loop
        ypxl2 = INT(yend)
        IF steep THEN
            plX = ypxl2
            plY = xpxl2
            plI = (1 - (yend - INT(yend))) * xgap
            CALL cpset(plX, plY, _RGB32(_RED32(c), _GREEN32(c), _BLUE32(c), plI * _ALPHA32(c)))

            plX = ypxl2 + 1
            plY = xpxl2
            plI = (yend - INT(yend)) * xgap
            CALL cpset(plX, plY, _RGB32(_RED32(c), _GREEN32(c), _BLUE32(c), plI * _ALPHA32(c)))
        ELSE
            plX = xpxl2
            plY = ypxl2
            plI = (1 - (yend - INT(yend))) * xgap
            CALL cpset(plX, plY, _RGB32(_RED32(c), _GREEN32(c), _BLUE32(c), plI * _ALPHA32(c)))

            plX = xpxl2
            plY = ypxl2 + 1
            plI = (yend - INT(yend)) * xgap
            CALL cpset(plX, plY, _RGB32(_RED32(c), _GREEN32(c), _BLUE32(c), plI * _ALPHA32(c)))
        END IF

        'main loop
        DIM x
        IF steep THEN
            FOR x = xpxl1 + 1 TO xpxl2 - 1
                plX = INT(intery)
                plY = x
                plI = (1 - (intery - INT(intery)))
                CALL cpset(plX, plY, _RGB32(_RED32(c), _GREEN32(c), _BLUE32(c), plI * _ALPHA32(c)))

                plX = INT(intery) + 1
                plY = x
                plI = (intery - INT(intery))
                CALL cpset(plX, plY, _RGB32(_RED32(c), _GREEN32(c), _BLUE32(c), plI * _ALPHA32(c)))

                intery = intery + gradient
            NEXT
        ELSE
            FOR x = xpxl1 + 1 TO xpxl2 - 1
                plX = x
                plY = INT(intery)
                plI = (1 - (intery - INT(intery)))
                CALL cpset(plX, plY, _RGB32(_RED32(c), _GREEN32(c), _BLUE32(c), plI * _ALPHA32(c)))

                plX = x
                plY = INT(intery) + 1
                plI = (intery - INT(intery))
                CALL cpset(plX, plY, _RGB32(_RED32(c), _GREEN32(c), _BLUE32(c), plI * _ALPHA32(c)))

                intery = intery + gradient
            NEXT
        END IF

        'plot:
        ' Change to regular PSET for standard coordinate orientation.
        'Call cpset(plX, plY, _RGB32(_Red32(c), _Green32(c), _Blue32(c), plI * _Alpha32(c)))
        'Return

    END IF
END SUB