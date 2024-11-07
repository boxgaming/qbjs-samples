'sinwavewater.bas
'Dav, AUG/2024
 
Screen _NewImage(800, 600, 32)
 
Do
    Cls
    For waves = 1 To 10
        For x = 0 To _Width
            'choose of two ways to float
            If waves Mod 2 Then
                y = (60 * waves) + (2 + waves) * Sin(x / (15 + waves) - Timer * waves)
            Else
                y = (60 * waves) + (2 + waves) * Sin(x / (15 + waves) + Timer * waves)
            End If
            Line (x, _Height)-(x, y), _RGB(waves, waves, 25 * waves)
        Next
    Next
    _Limit 30
    _Display
Loop Until InKey$ <> ""
