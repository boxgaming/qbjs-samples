Import Gfx From "lib/graphics/2d.bas"
Import FS  From "lib/io/fs.bas"

Screen NewImage(776, 436, 32)

Dim Shared As Integer i, tcols, trows, painting, img
Dim Shared As Integer cx, cy, fw, fh
Dim Shared As Integer fg(2), bg(2)
Dim Shared As String sel(2)
sel(1) = "█"
sel(2) = " "
cx = -1
fw = FontWidth
fh = FontHeight
fg(1) = 15
tcols = Fix(Width / FontWidth)
trows = Fix(Height / FontHeight)
img = NewImage(640, 400, 32)

DrawUI
DrawBrush 1
MouseHide

Do
    If MouseInput Then 
        MoveCursor
        DrawCursor
        
        Dim mb As Integer
        If MouseButton(1) Then
            mb = 1
        ElseIf MouseButton(2) Then
            mb = 2
        End If
        If mb Then
            If cx > 16 And cy < trows - 2 Then
                painting = -1
                PaintChar mb
            ElseIf Not painting Then
                If cx < 16 Then
                    If cy = 21 Then
                        ' select forground color
                        fg(mb) = Screen(cy+1, cx+1, 1) And 15: DrawBrush mb
                    ElseIf cy = 24 And cx < 8 Then
                        ' select background color
                        bg(mb) = Screen(cy+1, cx+1, 1) And 15: DrawBrush mb
                    ElseIf cy > 2 And cy < 19 Then
                        ' select brush character
                        sel(mb) = Chr$(Screen(cy+1, cx+1)): DrawBrush mb
                    End If
                End If
            End If
        Else
            painting = 0
        End If
    End If
    
    Dim k As String
    k = KeyHit
    If k = 19200 Then                       ' left arrow
        DrawCursor: cx = cx - 1: DrawCursor
    ElseIf k = 19712 Then                   ' right arrow
        DrawCursor: cx = cx + 1: DrawCursor
    ElseIf k = 18432 Then                   ' up arrow
        DrawCursor: cy = cy - 1: DrawCursor
    ElseIf k = 20480 Then                   ' down arrow
        DrawCursor: cy = cy + 1: DrawCursor
    ElseIf k = 32 Then                      ' space bar
        PaintChar 1
        Dim c As Integer
        c = Screen(cy+1, cx+1, 1)
    ElseIf k = 100308 Or k = 100307 Then    ' either ALT key
        PaintChar 2
    ElseIf k = 73 Or k = 105 Then           ' I key
        SaveImage
    ElseIf k = 83 Or k = 115 Then           ' S key
        Save
    ElseIf k = 76 Or k = 108 Then           ' L key
        OnLoad
    ElseIf k = 67 Or k = 99  Then           ' C key
        Clear
    ElseIf k = 70 Or k = 102 Then           ' F key
        FullScreen
    End If
    
    Limit 60
Loop


Sub DrawUI
    Color 7
    Print "────────┬───┬───┤"
    Print " Brush  │   │   │"
    Print "────────┴───┴───┤"
    Dim i As Integer
    For i = 1 To 255
        If i <> 10 Then Print Chr$(i); Else Print " ";
        If i Mod 16 = 0 Then
            Print "│"
        End If
    Next i 
    Print " │"
    Print "────────────────┤"
    Print " Foreground     │"
    For i = 0 To 15: Color i: Print "█";: Next i
    Color 7
    Print "│"
    Print "────────────────┤"
    Print " Background     │"
    For i = 0 To 7: Color i: Print "█";: Next i
    Print "        │"   
    Print "────────────────┴"
    For i = 18 To tcols: Locate trows - 1, i: Print "─";: Next i
    Color , _RGBA(0,0,0,0)
    Color 8:  Locate 27, 2: Print "[ ]    │ [ ]    │      [ ]     │ [ ]     │ [ ]         ";
    Color 7:  Locate 27, 2: Print "   oad      ave   Save    mage      lear      ullscreen";
    Color 15: Locate 27, 2: Print " L        S             I         C         F          ";
End Sub

Sub PaintChar (i As Integer)
    If cx > -1 Then Gfx.InvertRect cx * fw, cy * fh, fw, fh
    Locate cy+1, cx+1
    Color fg(i), bg(i)
    Print sel(i);
    Gfx.InvertRect cx * fw, cy * fh, fw, fh
End Sub

Sub DrawBrush (i As Integer)
    Color fg(i), bg(i)
    If i = 1 Then
        Locate 2, 11
    Else
        Locate 2, 15
    End If
    Print sel(i);
End Sub

Sub MoveCursor
    If cx > -1 Then
        Gfx.InvertRect cx * fw, cy * fh, fw, fh
    End If
    cx = Fix(MouseX / fw)
    cy = Fix(MouseY / fh)
End Sub

Sub DrawCursor
    Gfx.InvertRect cx * fw, cy * fh, fw, fh
    Locate trows, tcols - 8
    Color 15, 0
    Print "       ";
    Locate trows, tcols - 8
    If cx > 16 And cx < tcols And cy > -1 And cy < trows-2 Then
        Print cx-16; ","; cy+1;
    End If
End Sub

Sub OnLoad
    FS.UploadFile "/", ".dat", sub_Load
End Sub

Sub Load (filename As String)
    Dim As Integer rows, cols, row, col, oset, c
    Dim As Byte fg, bg
    oset = 17
    
    Open filename For Binary As #1
    Get #1, , rows
    Get #1, , cols
    For row = 1 To rows
        col = 1
        Locate row, col+oset
        For col = 1 To cols
            If EOF(1) Then
                Close #1
                Exit Sub
            End If
            Get #1, , fg
            Get #1, , bg
            Get #1, , c
            Color fg, bg
            Print Chr$(c);
        Next col
    Next row
    Close #1
End Sub

Sub Clear
    DrawCursor
    Dim row As Integer
    Dim s as String
    s = Space$(80)
    Color 0, 0
    For row = 1 To 25
        Locate row, 18
        Print s;
    Next row
    DrawCursor
End Sub

Sub Save
    Dim As Integer rows, cols, row, col, oset, c
    Dim As Byte fg, bg
    oset = 17
    rows = 25
    cols = 80
    If FileExists("image.dat") Then Kill "image.dat"
    Open "image.dat" For Binary As #1
    Put #1, , rows
    Put #1, , cols
    For row = 1 To rows
        For col = 1 To cols
            fg = Screen(row, oset + col, 1) And 15
            bg = Fix(Screen(row, oset + col, 1) / 16)
            c = Screen(row, oset+col)
            Put #1, , fg
            Put #1, , bg
            Put #1, , c
        Next col
    Next row
    Close #1
    FS.DownloadFile "image.dat"
End Sub

Sub SaveImage
    DrawCursor
    Dest img
    Cls 0, 0
    Dest 0
    PutImage (0, 0), 0, img, (136, 0)-Step(640, 400)
    Gfx.SaveImage img, "image.png"
    FS.DownloadFile "image.png"
    DrawCursor
End Sub