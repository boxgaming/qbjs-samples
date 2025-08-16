Option _Explicit
_Title "SHMUP mod 1 b+ 2024-05-02"
Screen 0: Color 15

Dim cannon1$, cannon2$, missile$, alien$
Dim As Integer cannonX, cannonY, missileX, missileY, missileActive
Dim As Integer alienX, alienY, alienActive, invaded, repelled, frame
Dim As Long kh
cannonX = 37
cannonY = 23
cannon1$ = " ▄█▄ " 'this works better
cannon2$ = "██ ██"
alienActive = 0
alien$ = "<" + Chr$(233) + ">"
missileActive = 0
missile$ = "|"
'invaded = 60
Do
    Cls
    kh = _KeyHit
    If kh = 19200 Then 'LEFT
        cannonX = cannonX - 1
    ElseIf kh = 19712 Then ' RIGHT
        cannonX = cannonX + 1
    ElseIf kh = 32 And missileActive = 0 Then
        missileX = cannonX + 2
        missileY = cannonY
        missileActive = 1
    End If

    If cannonX < 1 Then cannonX = 1
    If cannonX > 75 Then cannonX = 75

    If alienActive = 0 Then
        alienX = Int(Rnd * 76) + 2 - 1
        alienY = 1
        alienActive = 1
        frame = 0
    Else
        frame = frame + 1
        If frame = 15 Then alienY = alienY + 1: frame = 0
        If alienY = 23 Then
            invaded = invaded + 1
            alienActive = 0
        End If
    End If
    Locate alienY, alienX 'draw invader
    Print alien$

    Locate cannonY, cannonX 'draw canon
    Print cannon1$;
    Locate cannonY + 1, cannonX
    Print cannon2$;

    If missileActive = 1 Then ' handle missile
        missileY = missileY - 1
        If missileY < 1 Then
            missileActive = 0
        Else
            Locate missileY, missileX
            If missileX = alienX + 1 And missileY = alienY Then ' hit
                alienActive = 0
                missileActive = 0
                Locate alienY, alienX
                Print " * "
                repelled = repelled + 1
                _Display
                _Delay .1
                alienX = Int(Rnd(1) * 76) + 2 + 1 'new alien
                alienY = Int(Rnd(1) * cannonY)
            Else
                Print missile$
            End If
        End If
    End If
    _Title "Shumps   Invaded:" + Str$(invaded) + "  Repelled:" + Str$(repelled)
    _Display
    _Limit 60
    If Abs(invaded - repelled) > 25 Then Exit Do
Loop Until InKey$ = Chr$(27) ' Pressionar a tecla Esc para sair
If invaded - repelled > 25 Then
    Locate 12, 27: Print "Game over Aliens took over ;("
ElseIf repelled - invaded > 25 Then
    Locate 12, 28: Print "Game over Aliens defeated :)"
End If
_Display
End