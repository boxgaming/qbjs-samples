randomize timer

dim shared piece(17, 2, 4)
dim shared piece_color(17)
dim shared size, sw, sh

'big x and y
dim shared xx, yy

size = 25
sw = 12
sh = 25

redim shared board(sw - 1, sh - 1)

piece(0,0,0)=0: piece(0,1,0)=1: piece(0,2,0)=0
piece(0,0,1)=0: piece(0,1,1)=1: piece(0,2,1)=0
piece(0,0,2)=0: piece(0,1,2)=1: piece(0,2,2)=0
piece(0,0,3)=0: piece(0,1,3)=1: piece(0,2,3)=0
piece(0,0,4)=0: piece(0,1,4)=1: piece(0,2,4)=0

piece(1,0,0)=0: piece(1,1,0)=0: piece(1,2,0)=0
piece(1,0,1)=0: piece(1,1,1)=0: piece(1,2,1)=0
piece(1,0,2)=0: piece(1,1,2)=1: piece(1,2,2)=1
piece(1,0,3)=1: piece(1,1,3)=1: piece(1,2,3)=0
piece(1,0,4)=0: piece(1,1,4)=1: piece(1,2,4)=0

piece(2,0,0)=0: piece(2,1,0)=0: piece(2,2,0)=0
piece(2,0,1)=0: piece(2,1,1)=0: piece(2,2,1)=0
piece(2,0,2)=1: piece(2,1,2)=1: piece(2,2,2)=0
piece(2,0,3)=0: piece(2,1,3)=1: piece(2,2,3)=1
piece(2,0,4)=0: piece(2,1,4)=1: piece(2,2,4)=0

piece(3,0,0)=0: piece(3,1,0)=0: piece(3,2,0)=0
piece(3,0,1)=0: piece(3,1,1)=1: piece(3,2,1)=0
piece(3,0,2)=0: piece(3,1,2)=1: piece(3,2,2)=0
piece(3,0,3)=0: piece(3,1,3)=1: piece(3,2,3)=0
piece(3,0,4)=1: piece(3,1,4)=1: piece(3,2,4)=0

piece(4,0,0)=0: piece(4,1,0)=0: piece(4,2,0)=0
piece(4,0,1)=0: piece(4,1,1)=1: piece(4,2,1)=0
piece(4,0,2)=0: piece(4,1,2)=1: piece(4,2,2)=0
piece(4,0,3)=0: piece(4,1,3)=1: piece(4,2,3)=0
piece(4,0,4)=0: piece(4,1,4)=1: piece(4,2,4)=1

piece(5,0,0)=0: piece(5,1,0)=0: piece(5,2,0)=0
piece(5,0,1)=0: piece(5,1,1)=0: piece(5,2,1)=0
piece(5,0,2)=1: piece(5,1,2)=1: piece(5,2,2)=0
piece(5,0,3)=1: piece(5,1,3)=1: piece(5,2,3)=0
piece(5,0,4)=0: piece(5,1,4)=1: piece(5,2,4)=0

piece(6,0,0)=0: piece(6,1,0)=0: piece(6,2,0)=0
piece(6,0,1)=0: piece(6,1,1)=0: piece(6,2,1)=0
piece(6,0,2)=0: piece(6,1,2)=1: piece(6,2,2)=1
piece(6,0,3)=0: piece(6,1,3)=1: piece(6,2,3)=1
piece(6,0,4)=0: piece(6,1,4)=1: piece(6,2,4)=0

piece(7,0,0)=0: piece(7,1,0)=0: piece(7,2,0)=0
piece(7,0,1)=0: piece(7,1,1)=1: piece(7,2,1)=0
piece(7,0,2)=0: piece(7,1,2)=1: piece(7,2,2)=0
piece(7,0,3)=1: piece(7,1,3)=1: piece(7,2,3)=0
piece(7,0,4)=1: piece(7,1,4)=0: piece(7,2,4)=0

piece(8,0,0)=0: piece(8,1,0)=0: piece(8,2,0)=0
piece(8,0,1)=0: piece(8,1,1)=1: piece(8,2,1)=0
piece(8,0,2)=0: piece(8,1,2)=1: piece(8,2,2)=0
piece(8,0,3)=0: piece(8,1,3)=1: piece(8,2,3)=1
piece(8,0,4)=0: piece(8,1,4)=0: piece(8,2,4)=1

piece(9,0,0)=0: piece(9,1,0)=0: piece(9,2,0)=0
piece(9,0,1)=0: piece(9,1,1)=0: piece(9,2,1)=0
piece(9,0,2)=1: piece(9,1,2)=1: piece(9,2,2)=1
piece(9,0,3)=0: piece(9,1,3)=1: piece(9,2,3)=0
piece(9,0,4)=0: piece(9,1,4)=1: piece(9,2,4)=0

piece(10,0,0)=0: piece(10,1,0)=0: piece(10,2,0)=0
piece(10,0,1)=0: piece(10,1,1)=0: piece(10,2,1)=0
piece(10,0,2)=0: piece(10,1,2)=0: piece(10,2,2)=0
piece(10,0,3)=1: piece(10,1,3)=0: piece(10,2,3)=1
piece(10,0,4)=1: piece(10,1,4)=1: piece(10,2,4)=1

piece(11,0,0)=0: piece(11,1,0)=0: piece(11,2,0)=0
piece(11,0,1)=0: piece(11,1,1)=0: piece(11,2,1)=0
piece(11,0,2)=0: piece(11,1,2)=0: piece(11,2,2)=1
piece(11,0,3)=0: piece(11,1,3)=0: piece(11,2,3)=1
piece(11,0,4)=1: piece(11,1,4)=1: piece(11,2,4)=1

piece(12,0,0)=0: piece(12,1,0)=0: piece(12,2,0)=0
piece(12,0,1)=0: piece(12,1,1)=0: piece(12,2,1)=0
piece(12,0,2)=0: piece(12,1,2)=0: piece(12,2,2)=1
piece(12,0,3)=0: piece(12,1,3)=1: piece(12,2,3)=1
piece(12,0,4)=1: piece(12,1,4)=1: piece(12,2,4)=0

piece(13,0,0)=0: piece(13,1,0)=0: piece(13,2,0)=0
piece(13,0,1)=0: piece(13,1,1)=0: piece(13,2,1)=0
piece(13,0,2)=0: piece(13,1,2)=1: piece(13,2,2)=0
piece(13,0,3)=1: piece(13,1,3)=1: piece(13,2,3)=1
piece(13,0,4)=0: piece(13,1,4)=1: piece(13,2,4)=0

piece(14,0,0)=0: piece(14,1,0)=0: piece(14,2,0)=0
piece(14,0,1)=0: piece(14,1,1)=1: piece(14,2,1)=0
piece(14,0,2)=1: piece(14,1,2)=1: piece(14,2,2)=0
piece(14,0,3)=0: piece(14,1,3)=1: piece(14,2,3)=0
piece(14,0,4)=0: piece(14,1,4)=1: piece(14,2,4)=0

piece(15,0,0)=0: piece(15,1,0)=0: piece(15,2,0)=0
piece(15,0,1)=0: piece(15,1,1)=1: piece(15,2,1)=0
piece(15,0,2)=0: piece(15,1,2)=1: piece(15,2,2)=1
piece(15,0,3)=0: piece(15,1,3)=1: piece(15,2,3)=0
piece(15,0,4)=0: piece(15,1,4)=1: piece(15,2,4)=0

piece(16,0,0)=0: piece(16,1,0)=0: piece(16,2,0)=0
piece(16,0,1)=0: piece(16,1,1)=0: piece(16,2,1)=0
piece(16,0,2)=0: piece(16,1,2)=1: piece(16,2,2)=1
piece(16,0,3)=0: piece(16,1,3)=1: piece(16,2,3)=0
piece(16,0,4)=1: piece(16,1,4)=1: piece(16,2,4)=0

piece(17,0,0)=0: piece(17,1,0)=0: piece(17,2,0)=0
piece(17,0,1)=0: piece(17,1,1)=0: piece(17,2,1)=0
piece(17,0,2)=1: piece(17,1,2)=1: piece(17,2,2)=0
piece(17,0,3)=0: piece(17,1,3)=1: piece(17,2,3)=0
piece(17,0,4)=0: piece(17,1,4)=1: piece(17,2,4)=1

screen _newimage(sw*size, sh*size, 32)

piece_color(0) = _rgb(255,0,0)
piece_color(1) = _rgb(255,145,0)
piece_color(2) = _rgb(255,200,211)
piece_color(3) = _rgb(0,255,220)
piece_color(4) = _rgb(0,230,255)
piece_color(5) = _rgb(0,170,10)
piece_color(6) = _rgb(0,250,20)
piece_color(7) = _rgb(128,230,0)
piece_color(8) = _rgb(80,150,0)
piece_color(9) = _rgb(0,200,0)
piece_color(10) = _rgb(50,160,170)
piece_color(11) = _rgb(50,110,175)
piece_color(12) = _rgb(50,50,175)
piece_color(13) = _rgb(110,50,175)
piece_color(14) = _rgb(210,0,255)
piece_color(15) = _rgb(110,0,130)
piece_color(16) = _rgb(255,0,140)
piece_color(17) = _rgb(170,0,100)

dim t as double
 

redraw = 1

speed = 3
lines = 0
pause = 0
putpiece = 0
startx = (sw - 4)/2

pn = int(rnd*18)
px = startx
py = -2
rot = 0

dim title$
title$ = "lines="+ltrim$(str$(lines))+",speed="++ltrim$(str$(speed))
_title title$

t = timer

do
    if (timer - t) > (1/speed) and not pause then
        if valid(pn, px, py + 1, rot) then py = py + 1 else putpiece = 1

        t = timer
        redraw = 1
    end if

    if putpiece then
        if valid(pn, px, py, rot) then
            n = place(pn, px, py, rot)
            if n then
                lines = lines + n
                title$ = "lines="+ltrim$(str$(lines))+",speed="++ltrim$(str$(speed))
                _title title$
            end if
        end if

        pn = int(rnd*18)
        px = startx
        py = -2
        rot = 0

        putpiece = 0
        redraw = 1

        if not valid(pn, px, py, rot) then
            for y=0 to sh-1
                for x=0 to sw-1
                    board(x, y) = 0
                next
            next
            lines = 0
            title$ = "lines="+ltrim$(str$(lines))+",speed="++ltrim$(str$(speed))
            _title title$
        end if
    end if

    if redraw then
        line (0,0)-(sw*size, sh*size),_rgb(0,0,0),bf
        for y=0 to sh - 1
            for x=0 to sw - 1
                if board(x, y) <> 0 then
                    line (x*size, y*size)-step(size-2, size-2), piece_color(board(x, y)-1), bf
                else
                    line (x*size, y*size)-step(size-2, size-2), _rgb(50,50,50), b
                end if
            next
        next

        for y=0 to 4
            for x=0 to 2
                rotate x, y, pn, rot
                if piece(pn, x, y) then line ((px + xx)*size, (py + yy)*size)-step(size-2, size-2), piece_color(pn), bf
            next
        next

        _display
        redraw = 0
    end if

    k = _keyhit
    if k then 
        shift = _keydown(100304) or _keydown(100303)
        select case k
        case 18432 'up
            if valid(pn, px, py, (rot + 1) mod 4) then rot = (rot + 1) mod 4
            pause = 0
        case 19200 'left
            if shift then
                for x2=0 to sw-1
                    if not valid(pn, px - x2, py, rot) then exit for
                next
                px = px - x2 + 1
            else
                if valid(pn, px - 1, py, rot) then px = px - 1
            end if
            pause = 0
        case 19712 'right
            if shift then
                for x2=px to sw-1
                    if not valid(pn, x2, py, rot) then exit for
                next
                px = x2 - 1
            else 
                if valid(pn, px + 1, py, rot) then px = px + 1
            end if
            pause = 0
        case 20480, 32 'down
            if shift or k = 32 then
                for y2=py to sh-1
                    if not valid(pn, px, y2, rot) then exit for
                next
                py = y2 - 1
                putpiece = 1
            else
                if valid(pn, px, py + 1, rot) then py = py + 1
            end if
            pause = 0
        case 112 'p
            pause = not pause
        case 13 'enter
            for y=0 to sh-1
                for x=0 to sw-1
                    board(x, y) = 0
                next
            next
            pn = int(rnd*18)
            px = startx
            py = -2
            rot = 0
            putpiece = 0
            lines = 0
            title$ = "lines="+ltrim$(str$(lines))+",speed="++ltrim$(str$(speed))
            _title title$
        case 43, 61 'plus
            if speed < 100 then
                speed = speed + 1
                title$ = "lines="+ltrim$(str$(lines))+",speed="++ltrim$(str$(speed))
                _title title$
            end if
        case 95, 45
            if speed > 1 then
                speed = speed - 1
                title$ = "lines="+ltrim$(str$(lines))+",speed="++ltrim$(str$(speed))
                _title title$
            end if
        case 27
            exit do
        end select

        redraw = 1
    end if
    
    _limit 60
loop
system

sub rotate(x, y, pn, rot)
    select case pn
    case 0
        rot_new = rot mod 2
    case else 
        rot_new = rot
    end select

    select case rot_new
    case 0
        xx = x
        yy = y
    case 1
        if pn = 0 then
            xx = y - 1
            yy = 3 - x
        elseif pn = 14 or pn = 15 then
            xx = y - 1
            yy = 3 - x
        else
            xx = y - 2
            yy = 4 - x
        end if
    case 2
        if pn = 14 or pn = 15 then
            xx = 2 - x
            yy = 4 - y
        else
            xx = 2 - x
            yy = 6 - y
        end if
    case 3
        if pn = 14 or pn = 15 then
            xx = 3 - y
            yy = x + 1
        else
            xx = 4 - y
            yy = x + 2
        end if
    end select
end sub

function valid(pn, px, py, rot)
    for y=0 to 4
        for x=0 to 2
            rotate x, y, pn, rot
            if py + yy >= 0 then
                if piece(pn, x, y) then
                    if (px + xx >= sw) or (px + xx < 0) then
                        valid = 0
                        exit function
                    end if
                    if (py + yy >= sh) then
                        valid = 0
                        exit function
                    end if
                    'if (py >= 0) then
                    if board(px + xx, py + yy) then
                        valid = 0
                        exit function
                    end if
                    'end if
                end if
            end if
        next
    next
    valid = 1
end function

function place(pn, px, py, rot)
    lines2 = 0

    for y=0 to 4
        for x=0 to 2
            rotate x, y, pn, rot
            if py + yy >= 0 then
                if piece(pn, x, y) then board(px + xx, py + yy) = pn + 1
            end if
        next
    next

    'clear lines
    for y=py-5 to py+5
        if y>=0 and y<sh then
            clr = 1
            for x=0 to sw - 1
                if board(x, y) = 0 then
                    clr = 0
                    exit for
                end if
            next

            if clr then
                lines2 = lines2 + 1
                for y2=y to 1 step -1
                    for x=0 to sw-1
                        board(x, y2) = board(x, y2-1)
                    next
                next
            end if
        end if
    next

    place = lines2
end function
