Dim Shared notes(8) As Integer
Dim Shared shapes(4) As String
Dim Shared duration, decay, gain, key, lastNote, shape
shape = 1
duration = 100
decay = 0
gain = 100

notes(1) = 262 ' C4
notes(2) = 294 ' D4
notes(3) = 330 ' E4
notes(4) = 349 ' F4
notes(5) = 392 ' G4
notes(6) = 440 ' A4
notes(7) = 494 ' B4
notes(8) = 523 ' C5

shapes(1) = "square"
shapes(2) = "sine"
shapes(3) = "sawtooth"
shapes(4) = "triangle"

Color 15
Print
Print "     QBJS Sound Demo": Color 8
Print "     Press a number key 1-8 to play a note": Color 7
Print
Color 3
Print "     ÚÄÄÄÄÄ¿  ÚÄÄÄÄÄ¿  ÚÄÄÄÄÄ¿  ÚÄÄÄÄÄ¿  ÚÄÄÄÄÄ¿  ÚÄÄÄÄÄ¿  ÚÄÄÄÄÄ¿  ÚÄÄÄÄÄ¿"
Print "     ³  1  ³  ³  2  ³  ³  3  ³  ³  4  ³  ³  5  ³  ³  6  ³  ³  7  ³  ³  8  ³"
Print "     ³  C  ³  ³  D  ³  ³  E  ³  ³  F  ³  ³  G  ³  ³  A  ³  ³  B  ³  ³  C  ³"
Print "     ÀÄÄÄÄÄÙ  ÀÄÄÄÄÄÙ  ÀÄÄÄÄÄÙ  ÀÄÄÄÄÄÙ  ÀÄÄÄÄÄÙ  ÀÄÄÄÄÄÙ  ÀÄÄÄÄÄÙ  ÀÄÄÄÄÄÙ"
Print "       Do       Re       Mi       Fa       So       La       Ti       Do   "
Color 7
Print
Print
Print "                                     0                  1000                 "
Print "      ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿                ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿  /\ = '+' Key    "
Print "      ³    Shape    ³      Duration: ³                    ³                  "
Print "      ÃÄÄÄÄÄÄÄÄÄÄÄÄÄ´                ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  \/ = '-' Key    "
Print "      ³             ³                                                        "
Print "      ³             ³                0                   1.0                 "
Print "      ³             ³                ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿  /\ = Up Arrow   "
Print "      ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ          Gain: ³                    ³                  "
Print "        Press 0 to                   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  \/ = Down Arrow " 
Print "       Change Shape                                                          "
Print "                                     0                   1.0                 "
Print "                                     ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿  /\ = Right Arrow"
Print "                              Decay: ³                    ³                  "
Print "                                     ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  \/ = Left Arrow ";
Color 8
Locate 24, 2
Print " Press ESC to Quit";
ShowShape
ShowLevel 14, duration, 50
ShowLevel 19, gain
ShowLevel 24, decay

Do
    key = _KeyHit
    If key >= 49 And key <= 56 Then
        ' Play a note
        Dim n as Integer
        n = key-48
        Sound notes(n), duration, shapes(shape), decay / 100, gain / 100
        If lastNote Then ShowKey lastNote, -1
        ShowKey n
        lastNote = n
        
    ElseIf key = Asc("0") then
        ' Change the current shape
        shape = shape + 1
        If shape > 4 Then shape = 1
        ShowShape

    ElseIf key = Asc("+") Then ' + Key
        duration = duration + 50
        If duration > 1000 Then duration = 1000
        ShowLevel 14, duration, 50
        
    ElseIf key = Asc("-") Then ' - Key
        duration = duration - 50
        If duration < 0 Then duration = 0
        ShowLevel 14, duration, 50


    ElseIf key = 18432 Then ' Up Arrow
        gain = gain + 5
        If gain > 100 Then gain = 100
        ShowLevel 19, gain
        
    ElseIf key = 20480 Then ' Down Arrow
        gain = gain - 5
        If gain < 0 Then gain = 0
        ShowLevel 19, gain
    
    ElseIf key = 19712  Then ' Right Arrow
        decay = decay + 5
        If decay > 100 Then decay = 100
        ShowLevel 24, decay
        
    ElseIf key = 19200 Then ' Left Arrow
        decay = decay - 5
        If decay < 0 Then decay = 0
        ShowLevel 24, decay
    
    End If

    _Limit 60
Loop Until key = 27 'Esc to Quit

Color 8
Locate 24, 2
Print " Program ended.   ";


Sub ShowKey (note, hide)
    Dim col As Integer
    col = 6 + (note-1) * 9
    If hide Then Color 3 Else Color 11
    Locate 5, col: Print "ÚÄÄÄÄÄ¿"
    Locate 6, col: Print "³  " + LTrim$(note) + "  ³"
    Locate 7, col: Print "³"
    Locate 7, col + 6: Print "³"
    Locate 8, col: Print "ÀÄÄÄÄÄÙ"
End Sub

Sub ShowShape
   Color 14
   Locate 17, 10: Print "         "
   Locate 17, 11: Print shapes(shape)
End Sub

Sub ShowLevel (row, level, unit)
    Dim units As Integer
    units = level / 5
    
    Dim lstr As String
    If unit Then
        lstr = Str$(level)
        units = level / unit
    Else
        lstr = "000" + Str$(level)
        lstr = Left$(Right$(lstr, 3), 1) + "." + Right$(lstr, 2)
    End If
  
    Color 6
    Locate row, 39: Print "                    "
    Locate row, 39: Print String$(units, "±")
    
    Color 14
    Locate row-2, 46: Print "      "
    Locate row-2, 47: Print LTrim$(lstr)
End Sub
