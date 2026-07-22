'============================================================
' Metaballs for QB64-PE by a740g
' A loose port of https://github.com/AngelJumbo/lavat
' Converted from the QB64-PE version
' Adapted for zuv-Artistic color
'============================================================

Const SCREEN_WIDTH = 160
Const SCREEN_HEIGHT = 90
Const SCREEN_TITLE = "Metaballs"
Const BALLS_MAX = 20
Const FPS_TARGET = 60
Const SHADE_LEVELS = 5
Const EPSILON = 0.001
Const TWO_PI = 6.283185307179586

Type SimulationConfig
    screenWidth As Long
    screenHeight As Long
    ballCount As Long
    radius As Single
    radiusSquared As Single
    currentFPS As Long
    lastFPS As Long
End Type

Type Metaball
    x As Single
    y As Single
    velocityX As Single
    velocityY As Single
    u As Single
    v As Single
End Type

Type ShadeEntry
    threshold As Single
    glyph As String
End Type

Dim Shared Simulation As SimulationConfig
Dim Shared Metaballs(1 To BALLS_MAX) As Metaball
Dim Shared ShadeTable(0 To 4) As ShadeEntry
Dim Shared fieldU As Single, fieldV As Single

Dim keyCode As Long
Dim fpsText As String

InitProgram
InitSimulation

Do
    UpdateSimulation
    Cls
    RenderSimulation

    Simulation.currentFPS = GetFPS
    If Simulation.currentFPS <> Simulation.lastFPS Then
        Simulation.lastFPS = Simulation.currentFPS
        fpsText = LTrim$(Str$(Simulation.currentFPS))
        _Title SCREEN_TITLE + " (" + fpsText + " FPS)"
    End If

    keyCode = _KeyHit
    _Limit FPS_TARGET
Loop Until keyCode = 27

System

Sub InitProgram
    Screen _NewImage(SCREEN_WIDTH * 8, SCREEN_HEIGHT * 8, 32)
    _Title SCREEN_TITLE
    _Font 8
    _PrintMode _KeepBackground
End Sub

Sub InitSimulation
    Dim i As Long
    Dim h As Single
    Dim vx As Single, vy As Single

    Randomize Timer

    ShadeTable(0).threshold = 0
    ShadeTable(0).glyph = ""
    ShadeTable(1).threshold = 0.03
    ShadeTable(1).glyph = Chr$(176)
    ShadeTable(2).threshold = 0.06
    ShadeTable(2).glyph = Chr$(177)
    ShadeTable(3).threshold = 0.1
    ShadeTable(3).glyph = Chr$(178)
    ShadeTable(4).threshold = 0.16
    ShadeTable(4).glyph = Chr$(219)

    Simulation.screenWidth = SCREEN_WIDTH
    Simulation.screenHeight = SCREEN_HEIGHT
    Simulation.ballCount = BALLS_MAX
    Simulation.radius = 1.5
    Simulation.radiusSquared = Simulation.radius * Simulation.radius

    h = Rnd * TWO_PI

    For i = 1 To Simulation.ballCount
        Metaballs(i).x = Rnd * (Simulation.screenWidth - 1)
        Metaballs(i).y = Rnd * (Simulation.screenHeight - 1)

        vx = (Rnd * 2 - 1) * 0.6
        vy = (Rnd * 2 - 1) * 0.6

        If Abs(vx) < 0.2 Then
            If vx < 0 Then
                vx = -0.2
            Else
                vx = 0.2
            End If
        End If

        If Abs(vy) < 0.2 Then
            If vy < 0 Then
                vy = -0.2
            Else
                vy = 0.2
            End If
        End If

        Metaballs(i).velocityX = vx
        Metaballs(i).velocityY = vy
        Metaballs(i).u = Cos(h + TWO_PI * (i - 1) / Simulation.ballCount)
        Metaballs(i).v = Sin(h + TWO_PI * (i - 1) / Simulation.ballCount)
    Next i
End Sub

Sub UpdateSimulation
    Dim i As Long

    For i = 1 To Simulation.ballCount
        Metaballs(i).x = Metaballs(i).x + Metaballs(i).velocityX
        Metaballs(i).y = Metaballs(i).y + Metaballs(i).velocityY

        If Metaballs(i).x < 0 Then
            Metaballs(i).x = 0
            Metaballs(i).velocityX = -Metaballs(i).velocityX
        End If

        If Metaballs(i).x > Simulation.screenWidth - 1 Then
            Metaballs(i).x = Simulation.screenWidth - 1
            Metaballs(i).velocityX = -Metaballs(i).velocityX
        End If

        If Metaballs(i).y < 0 Then
            Metaballs(i).y = 0
            Metaballs(i).velocityY = -Metaballs(i).velocityY
        End If

        If Metaballs(i).y > Simulation.screenHeight - 1 Then
            Metaballs(i).y = Simulation.screenHeight - 1
            Metaballs(i).velocityY = -Metaballs(i).velocityY
        End If
    Next i
End Sub

Function FieldToShade (fieldValue As Single)
    Dim shade As Long

    For shade = SHADE_LEVELS - 1 To 1 Step -1
        If fieldValue >= ShadeTable(shade).threshold Then
            FieldToShade = shade
            Exit Function
        End If
    Next shade

    FieldToShade = 0
End Function

Function MetaField (sampleX As Single, sampleY As Single)
    Dim sum As Single, w As Single
    Dim deltaX As Single, deltaY As Single
    Dim distanceSquared As Single
    Dim i As Long

    sum = 0
    fieldU = 0
    fieldV = 0

    For i = 1 To Simulation.ballCount
        deltaX = sampleX - Metaballs(i).x
        deltaY = sampleY - Metaballs(i).y
        distanceSquared = deltaX * deltaX + deltaY * deltaY

        If distanceSquared < EPSILON Then distanceSquared = EPSILON

        w = Simulation.radiusSquared / distanceSquared
        sum = sum + w
        fieldU = fieldU + w * Metaballs(i).u
        fieldV = fieldV + w * Metaballs(i).v
    Next i

    MetaField = sum
End Function

Function Bound (z As Single, direction As Single)
    Bound = 10 ^ 30

    If direction > EPSILON Then Bound = (1 - z) / direction
    If direction < -EPSILON Then Bound = -z / direction
End Function

Function ZUV (fieldValue As Single)
    Dim z As Single, m As Single, p As Single, angle As Single
    Dim cosine As Single, sine As Single
    Dim x As Single, y As Single
    Dim r As Single, g As Single, b As Single
    Dim q As Single, t As Single

    z = (fieldValue - 0.02) / 0.16
    If z < 0 Then z = 0
    If z > 1 Then z = 1
    z = Sqr(z)

    m = Sqr(fieldU * fieldU + fieldV * fieldV)

    If m < EPSILON Then
        r = z
        g = z
        b = z
    Else
        p = m / fieldValue
        If p > 1 Then p = 1
        p = 0.92 * Sqr(p)

        angle = -0.66 * (z - 0.5)
        cosine = Cos(angle)
        sine = Sin(angle)

        x = (cosine * fieldU - sine * fieldV) / m
        y = (sine * fieldU + cosine * fieldV) / m

        r = 0.958250 * x - 0.036339 * y
        g = -0.278169 * x + 0.111061 * y
        b = -0.066169 * x - 0.993149 * y

        q = Bound(z, r)
        t = Bound(z, g)
        If t < q Then q = t
        t = Bound(z, b)
        If t < q Then q = t

        p = p * q
        r = z + p * r
        g = z + p * g
        b = z + p * b
    End If

    If r < 0 Then r = 0
    If g < 0 Then g = 0
    If b < 0 Then b = 0
    If r > 1 Then r = 1
    If g > 1 Then g = 1
    If b > 1 Then b = 1

    ZUV = _RGB32(255 * r, 255 * g, 255 * b)
End Function

Sub RenderSimulation
    Dim cellX As Long, cellY As Long
    Dim shade As Long
    Dim sampleX As Single, sampleY As Single
    Dim fieldValue As Single

    For cellY = 0 To Simulation.screenHeight - 1
        sampleY = cellY + 0.5

        For cellX = 0 To Simulation.screenWidth - 1
            sampleX = cellX + 0.5
            fieldValue = MetaField(sampleX, sampleY)
            shade = FieldToShade(fieldValue)

            If shade > 0 Then
                Color ZUV(fieldValue)
                _PrintString (cellX * 8, cellY * 8), ShadeTable(shade).glyph
            End If
        Next cellX
    Next cellY
End Sub

Function GetFPS
    Static initialized As Long
    Static frameCount As Long
    Static lastSecond As Double
    Static framesPerSecond As Long
    Dim currentTime As Double

    currentTime = Timer

    If initialized = 0 Then
        lastSecond = currentTime
        initialized = -1
    End If

    If currentTime < lastSecond Then lastSecond = currentTime

    frameCount = frameCount + 1

    If currentTime - lastSecond >= 1 Then
        framesPerSecond = frameCount
        frameCount = 0
        lastSecond = currentTime
    End If

    GetFPS = framesPerSecond
End Function
