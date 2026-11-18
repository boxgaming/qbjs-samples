'Option _Explicit '    Get into this habit and save yourself grief from Typos comment out for QBJS

_Title "Missile Command QBJS EnRitchied" '                b+ mod 2023-06-28, now try QBJS adaption
'                                   I probably picked up this game at the JB forum some years ago.

'    Get Constants, Shared Variables and Arrays() declared. These Will Start with Capital Letters.
'        Get Main module variables and arrays declared with starting lower case letters for local.
'         This is what Option _Explicit helps, by forcing us to at least declare these before use.
'       While declaring, telling QB64 the Type we want to use, we can also give brief description.


Const ScreenWidth = 800, ScreenHeight = 600 '                     for our custom screen dimensions
Dim As Integer bombX, bombY '                          incoming bomb screen position to shoot down
Dim As Single bombDX, bombDY '                  DX and DY mean change in X position and Y position
Dim As Integer missileX, missileY '                                               missile position
Dim As Single missileDX, missileDY '                            change X and Y of Missile position
Dim As Integer hits, misses '                                                score hits and misses
Dim As Integer mouseDistanceX, mouseDistanceY '       for calculations of missile DX, DY direction
Dim As Single distance '                                                                     ditto
Dim As Integer radius '                                      drawing hits with target like circles
Dim As Integer boolean '                         to shorten the code line with a bunch of OR tests


Screen _NewImage(ScreenWidth, ScreenHeight, 32) ' sets up a graphics screen with custom dimensions
'                                          the 32 is for _RGB32(red, green, blue, alpha) coloring.
'
'_ScreenMove 250, 60 ' out for QBJS   centers screen in my laptop, you may need different numbers

While 1 '                                             reset game and start a round with a bomb falling
    Cls
    bombX = Rnd * ScreenWidth '                                starts bomb somewhere across the screen
    bombY = 0 '                                                           starts bomb at top of screen
    bombDX = Rnd * 6 - 3 '                                  pick rnd dx = change in x between -3 and 3
    bombDY = Rnd * 3 + 3 '                 pick rnd dy = change in y between 3 and 6,  > 0 for falling
    missileX = ScreenWidth / 2 '                                  missile base at middle across screen
    missileY = ScreenHeight - 4 '   missile launch point at missile base is nearly at bottom of screen
    missileDX = 0 '                           missile is not moving awaiting mouse click for direction
    missileDY = 0 '                                                                              ditto
    distance = 0 '                                             distance of mouse click to missile base

    Do
        'what's the score?
        _Title "Click mouse to intersect incoming   Hits:" + Str$(hits) + ", misses:" + Str$(misses)
        _PrintString (400, 594), "^" '                                 draw missle base = launch point
        While _MouseInput: Wend '                                             poll mouse to get update
        If _MouseButton(1) Then '               the mouse was clicked calc the angle from missile base
            mouseDistanceX = _MouseX - missileX
            mouseDistanceY = _MouseY - missileY

            'distance = (mouseDistanceX ^ 2 + mouseDistanceY ^ 2) ^ .5
            '                   rewrite the above line using _Hypot() which is hidden distance forumla
            distance = _Hypot(mouseDistanceX, mouseDistanceY)

            missileDX = 5 * mouseDistanceX / distance
            missileDY = 5 * mouseDistanceY / distance
        End If

        missileX = missileX + missileDX '                                      update missile position
        missileY = missileY + missileDY '                                                        ditto
        bombX = bombX + bombDX '                                                  update bomb position
        bombY = bombY + bombDY '                                                                 ditto

        '                     I am about to use a boolean variable to shorten a very long IF code line
        '                                 boolean is either 0 or -1 when next 2 statements are execued
        '                                            -1/0 or True/False is everything still in screen?
        boolean = missileX < 0 Or missileY < 0 Or bombX < 0 Or bombY < 0
        boolean = boolean Or missileX > ScreenWidth Or bombX > ScreenWidth Or bombY > ScreenHeight
        If boolean Then '                                                       done with this boolean
            '   reuse boolean to shorten another long code line checking if bomb and missile in screen
            boolean = bombY > ScreenHeight Or missileX < 0 Or missileY < 0 Or missileX > ScreenWidth
            If boolean Then misses = misses + 1
            Exit Do
        End If

        '     if the distance between missle and bomb < 20 pixels then the missile got the bomb, a hit
        'If ((missileX - bombX) ^ 2 + (missileY - bombY) ^ 2) ^ .5 < 20 Then '  show  strike as target
        '                       rewrite the above line using _Hypot() which is hidden distance forumla
        If _Hypot(missileX - bombX, missileY - bombY) < 20 Then

            For radius = 1 To 20 Step 4 '                        draw concetric circles to show strike
                Circle ((missileX + bombX) / 2, (missileY + bombY) / 2), radius
                _Limit 60
            Next
            hits = hits + 1 '                                                    add hit to hits score
            Exit Do
        Else
            Circle (missileX + 4, missileY), 2, &HFFFFFF00 '+4 center on ^ base  draw    missle yellow
            Circle (bombX, bombY), 2, &HFF0000FF '                                      draw bomb blue
        End If
        _Limit 20
    Loop
Wend

