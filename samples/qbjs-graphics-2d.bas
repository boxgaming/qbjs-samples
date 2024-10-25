Import G2D From "lib/graphics/2d.bas"

Cls , 15
G2D.RoundRect 10, 10, 200, 200, 5, 9
G2D.Ellipse 110, 110, 50, 30, 0, 2

G2D.Shadow 0, 7, 7, 10
G2D.FillRoundRect 300, 10, 200, 75, 15, 3
G2D.FillCircle 50, 50, 30, 4
G2D.ShadowOff

G2D.FillEllipse 320, 320, 60, 40, 15, 5

G2D.Shadow 5, 0, 0, 15
Line (350, 150)-(450, 250), 0, BF
G2D.FillTriangle 500, 300, 580, 300, 530, 380, 1
G2D.ShadowOff

G2D.LineWidth 6
G2D.LineDash 12, 4
Line (20, 300)-(200, 380), 0, B
G2D.LineDashOff

G2D.LineWidth 15
Line (20, 240)-(200, 240), 4
G2D.LineCap G2D.ROUND
Line (20, 260)-(200, 260), 4
G2D.LineCap G2D.SQUARE
Line (20, 280)-(200, 280), 4

G2D.LineWidth 25
G2D.LineCap G2D.ROUND
G2D.Curve 470, 120, 650, 100, 520, 250, 2

G2D.Shadow 0, 7, 7, 10
G2D.LineWidth 3
G2D.Bezier 260, 20, 200, 100, 310, 150, 260, 250, 1
G2D.ShadowOff