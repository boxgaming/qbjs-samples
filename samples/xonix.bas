Randomize Timer: b = Int(Rnd * 15 + 7): a = Int(Rnd * 15 + 7) ' xonix.bas
y = Int(Rnd * (b - 3) + 3): x = Int(Rnd * (a - 3) + 3)
'b = 10: a = 20: y = 5: x = 5
If Rnd < .5 Then dx = -1 Else dx = 1
If Rnd < .5 Then dy = -1 Else dy = 1

For i = 1 To a: Print "#";: Next: Print ' area
For j = 1 To b - 2: Print "#";: For k = 1 To a - 2: Print ".";: Next: Print "#": Next
For i = 1 To a: Print "#";: Next

For q = 1 To 100: _Delay .03: Locate y, x: Print " "
    If y + dy < 2 Or y + dy > b - 1 Then dy = -dy
    y = y + dy
    If x + dx < 2 Or x + dx > a - 1 Then dx = -dx
    x = x + dx
    Locate y, x: Print "@"
Next