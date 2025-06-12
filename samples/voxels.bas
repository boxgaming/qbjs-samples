

Type newVoxel
    x As Single
    y As Single
    r As _Unsigned _Byte
    g As _Unsigned _Byte
    b As _Unsigned _Byte
    image As Long
End Type

Dim Shared voxelSize As Single
Dim Shared totalVoxels As Long, i As Long
Dim canvas&, mouseDown As _Byte

voxelSize = 100
totalVoxels = 0

canvas& = _NewImage(600, 600, 32)
Screen canvas&

_MouseHide

Dim voxel(1000) As newVoxel
Dim wireFrameVoxel As newVoxel

wireFrameVoxel.r = 255
wireFrameVoxel.g = 255
wireFrameVoxel.b = 255

Randomize Timer

Const div = 3.4
Const divx = 4
Do
    Cls

    While _MouseInput: Wend
    If _MouseButton(1) Then
        If Not mouseDown Then
            mouseDown = true
            totalVoxels = totalVoxels + 1
            If totalVoxels <= UBound(voxel) Then
                voxel(totalVoxels).x = Int(_MouseX / (voxelSize / divx)) * (voxelSize / divx)
                voxel(totalVoxels).y = Int(_MouseY / (voxelSize / div)) * (voxelSize / div)
                voxel(totalVoxels).r = Rnd * 255
                voxel(totalVoxels).g = Rnd * 255
                voxel(totalVoxels).b = Rnd * 255
            End If
        End If
    Else
        mouseDown = false
    End If

    For i = 1 To totalVoxels
        drawVoxel voxel(i), true
    Next

    wireFrameVoxel.x = Int(_MouseX / (voxelSize / divx)) * (voxelSize / divx)
    wireFrameVoxel.y = Int(_MouseY / (voxelSize / div)) * (voxelSize / div)
    drawVoxel wireFrameVoxel, false

    Print Int(_MouseX / (voxelSize / 2))
    Print Int(_MouseY / (voxelSize / 2))

    Dim k As Long, b$
    k = _KeyHit
    If k = 27 Then totalVoxels = 0
    If k = 8 Then totalVoxels = totalVoxels + (totalVoxels > 0)
    If (k = 67 Or k = 99) And (_KeyDown(100306) Or _KeyDown(100305)) Then
        b$ = ""
        For i = 1 To totalVoxels
            b$ = b$ + "DATA " + Str$(voxel(i).x) + "," + Str$(voxel(i).y) + Chr$(10)
        Next
        _Clipboard$ = b$
    End If

    _Display
    _Limit 30
Loop

Sub drawVoxel (that As newVoxel, fill As _Byte)
    Dim x As Single, y As Single
    Dim top As Single, leftSide As Single

    If that.image = 0 Then
        Dim tempImage&, previousDest&
        tempImage& = _NewImage(voxelSize + 1, voxelSize * 1.15, 32)
        previousDest& = _Dest
        _Dest tempImage&

        x = _Width / 2
        y = 0

        Color _RGB32(that.r, that.g, that.b)
        Line (x, y)-Step(-(voxelSize / 2), voxelSize / 4)
        Line Step(0, 0)-Step((voxelSize / 2), voxelSize / 4)
        Line Step(0, 0)-Step((voxelSize / 2), -(voxelSize / 4))
        Line Step(0, 0)-Step(-(voxelSize / 2), -(voxelSize / 4))
        Line (x - (voxelSize / 2), y + (voxelSize / 4))-Step(0, (voxelSize * 0.625))
        Line Step(0, 0)-Step((voxelSize / 2), (voxelSize / 4))
        Line (x, y + (voxelSize / 2))-Step(0, (voxelSize * 0.625))
        Line (x + (voxelSize / 2), y + (voxelSize / 4))-Step(0, (voxelSize * 0.625))
        Line Step(0, 0)-Step(-(voxelSize / 2), (voxelSize / 4))

        If fill Then
            top = .8
            Paint (x, y + (voxelSize / 4)), _RGB32(that.r * top, that.g * top, that.b * top), _RGB32(that.r, that.g, that.b)

            leftSide = .4
            Paint (x - (voxelSize / 4), y + (voxelSize * 0.7)), _RGB32(that.r * leftSide, that.g * leftSide, that.b * leftSide), _RGB32(that.r, that.g, that.b)

            Paint (x + (voxelSize / 4), y + (voxelSize * 0.7)), _RGB32(that.r, that.g, that.b), _RGB32(that.r, that.g, that.b)
        End If

        that.image = tempImage&

        _Dest previousDest&
    End If
    _PutImage (that.x, that.y), that.image
End Sub
