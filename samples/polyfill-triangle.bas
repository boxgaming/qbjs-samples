'polyFT in QBjs
'v 0.5
'haven't quite figure out how to make the this look good with thicker lines but it works fine at one pixel wide
Import G2D From "lib/graphics/2d.bas"

G2D.LineWidth 4
G2D.LineCap G2D.ROUND

Randomize Timer
For i = 0 to 100
polyFT Rnd * 640, Rnd * 400,rnd*30+30,int(3+rnd*12),int(rnd*360),_rgb32(int(rnd*256),int(rnd*256),int(rnd*256)),_rgb32(int(rnd*256),int(rnd*256),int(rnd*256))
_Limit 200
Next i


Sub polyFT (cx As Long, cy As Long, rad As Long, sides As Integer, rang As Long, klr As _Unsigned Long, lineyes As _Unsigned Long)
    'draw an equilateral polygon using filled triangle for each segment
    'centered at cx,cy to radius rad of sides # of face rotated to angle rang scaled to ww and vv of color klr and lineyes if there is an outline, a value 0 would create no outline
    Dim px(sides)
    Dim py(sides)
    pang = 360 / sides
    ang = 0
    For p = 1 To sides
        px(p) = cx + (rad * Cos(0.01745329 * (ang + rang)))
        py(p) = cy + (rad * Sin(0.01745329 * (ang + rang)))
        ang = ang + pang
    Next p
    For p = 1 To sides - 1
    line (cx,cy)-(px(p),py(p)),klr
    G2D.FillTriangle cx,cy,px(p),py(p),px(p+1),py(p+1),klr
    Next p
    line (cx,cy)-(px(sides),py(sides)),klr
    G2D.FillTriangle cx,cy,px(sides),py(sides),px(1),py(1),klr
  if lineyes>0 then
  for p =1 to sides-1
    Line (px(p), py(p))-(px(p + 1), py(p + 1)), lineyes
  next
  Line (px(sides), py(sides))-(px(1), py(1)), lineyes
  end if
End Sub