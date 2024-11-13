Screen _NewImage(605, 300, 32)
Randomize Timer ' KUBIK.bas
'........T=====T 1
'......./-----/| 2
'....../-----/|| 2
'...../-----/||| 2
'..../-----/|||J 3
'.../-----/|||/ 4
'../-----/|||/ 4
'./-----/|||/ 4
'T=====T|||/ 4
'|*****|||/ 4
'|*****||/ 4
'|*****|/ 4
'L=====J 5
for z=1 to 10: cls
a = Int(Rnd * 9) + 3: b = Int(Rnd * 7) + 3: c = Int(Rnd * 7) + 3
Locate 1, 1: For i = 1 To c: Print ".";: Next
Print "T";: For i = 1 To a - 2: Print "=";: Next: Print "T 1"

For i = 1 To b - 2:
    For j = 1 To a + c - 2: Print ".";: Next: Print "|| 2"
Next

For i = 1 To a + c - 2: Print ".";: Next: Print "|J 3"

For i = 1 To c - 1: Locate i + 1, 1
    For j = c - i To 1 Step -1: Print ".";: Next: Print "/";
    For k = 1 To a - 2: Print "-";: Next: Print "/"

    For m = 1 To b - 2
        For n = 1 To c + a - 1 - i: Print "|";: Next: Print
    Next: _Delay .25

    For p = 1 To a + c - 1 - i: Print "|";: Next: Print "/ 4"
Next

Locate i + 1, 1: Print "T";:
For i = 1 To a - 2: Print "=";: Next: Print "T"
For i = 1 To b - 2: Print "|";
    For j = 1 To a - 2: Print "*";: Next: Print "|"
Next

Print "L";: For i = 1 To a - 2: Print "=";: Next: Print "J 5"
_Delay 2
Next
