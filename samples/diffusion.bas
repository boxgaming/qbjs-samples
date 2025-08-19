OPTION _EXPLICIT
RANDOMIZE TIMER

SCREEN _NEWIMAGE(800, 800, 32)

TYPE Vector2D
    x AS DOUBLE
    y AS DOUBLE
END TYPE

TYPE Vector2I
    x AS INTEGER
    y AS INTEGER
END TYPE

TYPE Cell
    Center AS Vector2D
    Species AS INTEGER
    ' -1 = Source
    '  0 = Clear
    '  1 = Opaque
    Intensity AS DOUBLE
    Translucence AS DOUBLE
END TYPE

DIM AS DOUBLE CellWidth
DIM AS DOUBLE CellHeight
DIM AS INTEGER CellCountX
DIM AS INTEGER CellCountY

IF (0 = 1) THEN ' Specify cell dimensions, calculate total number.
    CellWidth = 10
    CellHeight = 10
    CellCountX = INT(_WIDTH / CellWidth)
    CellCountY = INT(_HEIGHT / CellHeight)
ELSE '          ' Specify cell number, calculate dimensions.
    CellCountX = 50
    CellCountY = 50
    CellWidth = _WIDTH / CellCountX
    CellHeight = _HEIGHT / CellCountY
END IF

DIM AS Cell World(CellCountX, CellCountY)
DIM AS Cell WorldAux(CellCountX, CellCountY)

DIM AS INTEGER i
DIM AS INTEGER j
DIM AS INTEGER jj
DIM AS INTEGER j0
DIM AS INTEGER k
DIM AS INTEGER kk
DIM AS INTEGER k0
DIM AS DOUBLE x0
DIM AS DOUBLE y0
DIM AS DOUBLE Accumulator
DIM AS DOUBLE Normalizer
DIM AS DOUBLE Factor

' Create diffusion kernel.
DIM AS DOUBLE ImgKernel(-1 TO 1, -1 TO 1)
ImgKernel(1, -1) = 7 '  1 / Sqr(2)
ImgKernel(0, -1) = 10 ' 1
ImgKernel(-1, -1) = 7 ' 1 / Sqr(2)
ImgKernel(1, 0) = 10 '  1
ImgKernel(0, 0) = 0 '   0
ImgKernel(-1, 0) = 10 ' 1
ImgKernel(1, 1) = 7 '   1 / Sqr(2)
ImgKernel(0, 1) = 10 '  1
ImgKernel(-1, 1) = 7 '  1 / Sqr(2)

' Initialize world (just once)
FOR j = 1 TO CellCountX
    FOR k = 1 TO CellCountY
        World(j, k).Center.x = (j - 1 / 2) * CellWidth
        World(j, k).Center.y = (k - 1 / 2) * CellHeight
    NEXT
NEXT

DIM Player AS Vector2I
Player.x = 12
Player.y = 15

DIM AS Vector2I LightSourcePositions(20)
FOR i = 1 TO UBOUND(LightSourcePositions)
    LightSourcePositions(i).x = 1 + INT(RND * CellCountX)
    LightSourcePositions(i).y = 1 + INT(RND * CellCountY)
NEXT

DO

    ' Re-initialize world with every refresh, or perhaps with only significant state updates
    FOR j = 1 TO CellCountX
        FOR k = 1 TO CellCountY
            World(j, k).Species = 0
            World(j, k).Translucence = 1
            World(j, k).Intensity = 0
        NEXT
    NEXT

    ' Opaque things
    FOR i = 1 TO 5
        j0 = 4 * i
        k0 = 4 * i
        FOR j = j0 TO 2 * j0 + 1
            World(j, j0).Species = 1
            World(j, 2 * k0 + 1).Species = 1
            World(j, j0).Translucence = 0
            World(j, 2 * k0 + 1).Translucence = 0
        NEXT
        FOR k = k0 + 1 TO 2 * k0
            World(j0, k).Species = 1
            World(2 * j0 + 1, k).Species = 1
            World(j0, k).Translucence = 0
            World(2 * j0 + 1, k).Translucence = 0
        NEXT

        FOR j = j0 TO 2 * j0 + 1
            World(7 + j, 7 + j0).Species = 1
            World(7 + j, 7 + 2 * k0 + 1).Species = 1
            World(7 + j, 7 + j0).Translucence = .15
            World(7 + j, 7 + 2 * k0 + 1).Translucence = .15
        NEXT
        FOR k = k0 + 1 TO 2 * k0
            World(7 + j0, 7 + k).Species = 1
            World(7 + 2 * j0 + 1, 7 + k).Species = 1
            World(7 + j0, 7 + k).Translucence = .15
            World(7 + 2 * j0 + 1, 7 + k).Translucence = .15
        NEXT
    NEXT

    ' Light sources
    FOR i = 1 TO UBOUND(LightSourcePositions)
        j = LightSourcePositions(i).x
        k = LightSourcePositions(i).y
        World(j, k).Species = -1
        World(j, k).Intensity = 1
    NEXT

    WHILE _MOUSEINPUT: WEND

    ' Player
    Player.x = INT(_MOUSEX + CellWidth / 2) / CellWidth
    Player.y = INT(_MOUSEY + CellHeight / 2) / CellHeight
    j = INT(Player.x)
    k = INT(Player.y)
    World(j, k).Species = -1
    World(j, k).Intensity = 1

    FOR i = 1 TO 20
        FOR j = 1 TO CellCountX
            FOR k = 1 TO CellCountY
                IF (World(j, k).Species <> -1) THEN
                    Accumulator = 0
                    Normalizer = 0
                    FOR jj = -1 TO 1
                        FOR kk = -1 TO 1
                            j0 = j + jj
                            k0 = k + kk
                            IF (j0 < 1) THEN j0 = 1
                            IF (k0 < 1) THEN k0 = 1
                            IF (j0 > CellCountX) THEN j0 = CellCountX
                            IF (k0 > CellCountY) THEN k0 = CellCountY
                            Accumulator = Accumulator + World(j0, k0).Intensity * World(j, k).Translucence * ImgKernel(jj, kk)
                            Normalizer = Normalizer + ImgKernel(jj, kk)
                        NEXT
                    NEXT
                    WorldAux(j, k).Intensity = Accumulator / Normalizer
                END IF
            NEXT
        NEXT
        FOR j = 1 TO CellCountX
            FOR k = 1 TO CellCountY
                IF (World(j, k).Species <> -1) THEN
                    World(j, k).Intensity = WorldAux(j, k).Intensity
                END IF
            NEXT
        NEXT
    NEXT

    CLS
    FOR j = 1 TO CellCountX
        FOR k = 1 TO CellCountY
            x0 = World(j, k).Center.x
            y0 = World(j, k).Center.y
            Factor = ((World(j, k).Intensity)) ^ .3
            IF (World(j, k).Species = -1) THEN
                LINE (x0 - CellWidth / 2, y0 - CellHeight / 2)-(x0 + CellWidth / 2, y0 + CellHeight / 2), _RGB32(255 * Factor, 255 * Factor, 0, 255), BF
            ELSEIF (World(j, k).Species = 0) THEN
                LINE (x0 - CellWidth / 2, y0 - CellHeight / 2)-(x0 + CellWidth / 2, y0 + CellHeight / 2), _RGB32(255 * Factor, 0, 0, 255), BF
            ELSEIF (World(j, k).Species = 1) THEN
                LINE (x0 - CellWidth / 2, y0 - CellHeight / 2)-(x0 + CellWidth / 2, y0 + CellHeight / 2), _RGB32(0, 255 * World(j, k).Translucence, 200, 255), BF
            END IF
            LINE (x0 - CellWidth / 2, y0 - CellHeight / 2)-(x0 + CellWidth / 2, y0 + CellHeight / 2), _RGB32(128, 128, 128, 255), B
        NEXT
    NEXT

    _DISPLAY
    _LIMIT 120
LOOP

