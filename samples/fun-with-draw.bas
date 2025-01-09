' Mod MG DRAW by bplus 2023-10-08
'ref  https://qb64.boards.net/thread/219/qb64-dev-competition-idea?page=2&scrollTo=1228

Dim i As Integer, ai As Integer, cc As Integer, u As Integer
Dim a$, s$

Randomize Timer
Screen 13
Do
    a$ = ""
    Do Until Len(a$) > 20
        If Random1(2) = 1 Then
            If Random1(2) = 1 Then a$ = a$ + "L" Else a$ = a$ + "R"
        Else
            If Random1(2) = 1 Then a$ = a$ + "D" Else a$ = a$ + "U"
        End If
        a$ = a$ + Str$(Rand(1, 15))
    Loop
    s$ = a$
    Cls
    For i = 1 To 24
        stepper = Val(Mid$(" 10 12 15 18 20 30 40 45 60 72 90120180", Int(Rnd * 13) + 1, 3))
        For ai = 0 To 360 - stepper Step stepper
            cc = Rand(64, 160)
            If i > 10 Then u = 10 Else u = i
            If i Mod 2 Then cc = 9 Else cc = 15
            PreSet (160, 100)
            'Draw "ta0"  ' this needed?
            a$ = "S" + Str$(22 - u * 2) + "TA" + Str$(ai) + "C" + Str$(cc) + s$
            Draw a$
        Next
    Next
    Print "spacebar for another, esc to quit"
    Sleep
Loop Until Asc(InKey$) = 27

Function Rand& (fromval&, toval&)
    Dim sg%, f&, t&
    If fromval& = toval& Then
        Rand& = fromval&
        Exit Function
    End If
    f& = fromval&
    t& = toval&
    If (f& < 0) And (t& < 0) Then
        sg% = -1
        f& = f& * -1
        t& = t& * -1
    Else
        sg% = 1
    End If
    If f& > t& Then Swap f&, t&
    Rand& = Int(Rnd * (t& - f& + 1) + f&) * sg%
End Function

Function Random1& (maxvaluu&)
    Dim sg%
    sg% = Sgn(maxvaluu&)
    If sg% = 0 Then
        Random1& = 0
    Else
        If sg% = -1 Then maxvaluu& = maxvaluu& * -1
        Random1& = Int(Rnd * maxvaluu& + 1) * sg%
    End If
End Function