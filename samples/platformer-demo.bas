SCREEN _NEWIMAGE(1280, 720, 32)
REM Generated for QB64 with free Claude AI
REM Horizontal distance between platforms will slowly get wider with more playtime
_TITLE "Platformer Demo"
RANDOMIZE TIMER

' Game constants
CONST GRAVITY = 0.8
CONST JUMP_STRENGTH = -18
CONST PLAYER_SIZE = 20
CONST PLATFORM_HEIGHT = 15
CONST MAX_PARTICLES = 200
CONST MAX_PLATFORMS = 200
CONST PLATFORMS_PER_LEVEL = 50 ' Fixed number of platforms per level
CONST AMBIENT_PARTICLE_RATE = 3 ' Number of ambient particles to spawn per frame (0 to disable)

' Define pure colors
DIM SHARED WHITE_COLOR AS LONG
DIM SHARED BLACK_COLOR AS LONG
DIM SHARED GRAY_COLOR AS LONG
WHITE_COLOR = _RGB32(255, 255, 255)
BLACK_COLOR = _RGB32(0, 0, 0)
GRAY_COLOR = _RGB32(192, 192, 192)

' Platform generation variables
DIM SHARED PLATFORM_SPACING AS SINGLE
DIM SHARED PLATFORM_SCATTER AS SINGLE
PLATFORM_SPACING = 180 ' Vertical distance between platforms (adjustable)
PLATFORM_SCATTER = 200 ' Horizontal scatter range (adjustable)

' Player variables
DIM SHARED px AS SINGLE, py AS SINGLE ' Player position
DIM SHARED pvx AS SINGLE, pvy AS SINGLE ' Player velocity
DIM SHARED onGround AS INTEGER
DIM SHARED playerColor AS LONG
DIM SHARED bounceStrength AS SINGLE

' Particle system
TYPE Particle
    x AS SINGLE
    y AS SINGLE
    vx AS SINGLE
    vy AS SINGLE
    life AS INTEGER
    maxLife AS INTEGER
    brightness AS INTEGER
END TYPE

DIM SHARED particles(MAX_PARTICLES) AS Particle
DIM SHARED particleCount AS INTEGER

' Platform system
TYPE Platform
    x AS SINGLE
    y AS SINGLE
    w AS SINGLE
    active AS INTEGER
    bounced AS INTEGER
    id AS INTEGER ' Unique ID to track which platforms have been scored
    isLevelPlatform AS INTEGER ' 1 if this is an original level platform, 0 if dynamically generated
END TYPE

DIM SHARED platforms(MAX_PLATFORMS) AS Platform
DIM SHARED platformCount AS INTEGER
DIM SHARED nextPlatformID AS INTEGER
DIM SHARED highestPlatformY AS SINGLE ' Track highest generated platform
DIM SHARED levelTopY AS SINGLE ' The Y position of the top platform for level completion
DIM SHARED levelPlatformsGenerated AS INTEGER ' How many level platforms have been generated

' Game state
DIM SHARED score AS INTEGER
DIM SHARED gameTime AS SINGLE
DIM SHARED cameraY AS SINGLE
DIM SHARED lastScoredPlatform AS INTEGER ' Track last platform that gave score
DIM SHARED level AS INTEGER
DIM SHARED levelSeed AS LONG ' Seed for level generation
DIM SHARED gameState AS INTEGER ' 0 = playing, 1 = game over
DIM SHARED gameOverTimer AS SINGLE
DIM SHARED levelCompleted AS INTEGER ' Flag to track if level is completed

' Initialize game
CALL InitGame

' Main game loop
DO
    IF gameState = 0 THEN
        CALL HandleInput
        CALL UpdateGame
    ELSEIF gameState = 1 THEN
        CALL HandleGameOver
    END IF

    CALL DrawGame

    _DISPLAY
    _LIMIT 60

    ' Exit on ESC
    'IF _KEYDOWN(27) THEN EXIT DO
LOOP

_KEYCLEAR
SYSTEM

SUB InitGame
    ' Initialize player on first platform
    px = 640
    py = 479 ' Start just above the first platform to prevent initial bounce
    pvx = 0
    pvy = 0
    onGround = 0 ' Start not on ground to let physics settle naturally
    playerColor = WHITE_COLOR ' Always pure white player
    bounceStrength = 0

    ' Initialize game state
    level = 1
    levelSeed = TIMER * 1000 + RND * 10000 ' Create unique seed for this level
    gameState = 0 ' Playing state
    gameOverTimer = 0
    levelCompleted = 0

    ' Initialize platforms
    platformCount = 0
    nextPlatformID = 0
    lastScoredPlatform = -1
    levelPlatformsGenerated = 0

    ' Generate level with unique seed
    CALL GenerateLevel

    ' Initialize particles
    particleCount = 0
    FOR i = 0 TO MAX_PARTICLES - 1
        particles(i).life = 0
    NEXT i

    score = 0
    gameTime = 0
    cameraY = 0
END SUB

SUB GenerateLevel
    ' Use level seed for consistent but different platform layouts
    currentSeed = levelSeed + level * 54321 + RND * 1000

    ' Clear all platforms
    FOR i = 0 TO MAX_PLATFORMS - 1
        platforms(i).active = 0
        platforms(i).isLevelPlatform = 0
    NEXT i

    ' Reset counters
    platformCount = 0
    levelPlatformsGenerated = 0
    levelCompleted = 0

    ' First platform (spawn platform) - always in center
    platforms(0).x = 540
    platforms(0).y = 500
    platforms(0).w = 200
    platforms(0).active = 1
    platforms(0).bounced = 0 ' Allow normal bouncing behavior
    platforms(0).id = nextPlatformID
    platforms(0).isLevelPlatform = 1
    nextPlatformID = nextPlatformID + 1
    platformCount = 1
    levelPlatformsGenerated = 1
    highestPlatformY = 500

    ' Generate exactly PLATFORMS_PER_LEVEL platforms for this level
    FOR i = 1 TO PLATFORMS_PER_LEVEL - 1
        platforms(i).y = 500 - i * PLATFORM_SPACING

        ' Use level seed with more randomization to create different patterns
        randomValue = ((currentSeed + i * 789 + level * 123) MOD 32767) / 32767.0
        randomValue2 = ((currentSeed + i * 456 + level * 987) MOD 32767) / 32767.0

        ' Create level-specific scatter pattern with more variation
        centerX = 640 ' Screen center
        scatterAmount = (randomValue - 0.5) * PLATFORM_SCATTER

        ' Add level-specific wave pattern for variety with more randomness
        waveOffset = SIN(i * 0.3 + level + randomValue2 * 3.14) * (80 + level * 10)
        platforms(i).x = centerX + scatterAmount + waveOffset

        ' Keep platforms reasonably on screen
        IF platforms(i).x < 50 THEN platforms(i).x = 50
        IF platforms(i).x > 1100 THEN platforms(i).x = 1100

        ' Vary platform width based on level with more randomization
        widthRandom = ((currentSeed + i * 987 + level * 321) MOD 32767) / 32767.0
        platforms(i).w = 60 + widthRandom * 120 ' Platform width varies more

        platforms(i).active = 1
        platforms(i).bounced = 0
        platforms(i).id = nextPlatformID
        platforms(i).isLevelPlatform = 1
        nextPlatformID = nextPlatformID + 1
        platformCount = platformCount + 1
        levelPlatformsGenerated = levelPlatformsGenerated + 1

        IF platforms(i).y < highestPlatformY THEN
            highestPlatformY = platforms(i).y
        END IF
    NEXT i

    ' Set the level completion Y position (same as top platform)
    levelTopY = highestPlatformY
END SUB

SUB HandleGameOver
    gameOverTimer = gameOverTimer + 0.016

    ' Handle restart input
    IF _KEYDOWN(27) THEN ' Escape to restart
        CALL InitGame ' Reset everything including score
    END IF
END SUB

SUB GenerateNewPlatforms
    ' Only generate additional platforms if we haven't completed the level yet
    IF levelCompleted THEN EXIT SUB

    ' Generate new platforms as player climbs higher, but mark them as non-level platforms
    targetY = cameraY - 1000 ' Generate platforms well above camera

    WHILE highestPlatformY > targetY
        ' Find an empty platform slot or reuse the lowest non-level platform
        slotIndex = -1
        lowestY = 999999
        lowestIndex = 0

        FOR i = 0 TO MAX_PLATFORMS - 1
            IF NOT platforms(i).active THEN
                slotIndex = i
                EXIT FOR
            END IF

            ' Track lowest non-level platform for potential reuse
            IF platforms(i).y > lowestY AND NOT platforms(i).isLevelPlatform THEN
                lowestY = platforms(i).y
                lowestIndex = i
            END IF
        NEXT i

        ' If no empty slot, reuse the lowest non-level platform if it's far below camera
        IF slotIndex = -1 AND lowestY > cameraY + 800 AND NOT platforms(lowestIndex).isLevelPlatform THEN
            slotIndex = lowestIndex
        END IF

        ' Create new platform if we have a slot
        IF slotIndex >= 0 THEN
            platforms(slotIndex).y = highestPlatformY - PLATFORM_SPACING

            ' Use level-based generation for consistency but with more randomness
            currentSeed = levelSeed + level * 54321 + RND * 1000
            platformIndex = ABS(highestPlatformY / PLATFORM_SPACING)
            randomValue = ((currentSeed + platformIndex * 789 + level * 234) MOD 32767) / 32767.0

            centerX = 640
            scatterAmount = (randomValue - 0.5) * PLATFORM_SCATTER
            waveOffset = SIN(platformIndex * 0.3 + level) * 100
            platforms(slotIndex).x = centerX + scatterAmount + waveOffset

            ' Keep platforms on screen
            IF platforms(slotIndex).x < 50 THEN platforms(slotIndex).x = 50
            IF platforms(slotIndex).x > 1100 THEN platforms(slotIndex).x = 1100

            widthRandom = ((currentSeed + platformIndex * 456) MOD 32767) / 32767.0
            platforms(slotIndex).w = 80 + widthRandom * 100
            platforms(slotIndex).active = 1
            platforms(slotIndex).bounced = 0
            platforms(slotIndex).id = nextPlatformID
            platforms(slotIndex).isLevelPlatform = 0 ' Mark as dynamically generated
            nextPlatformID = nextPlatformID + 1

            highestPlatformY = platforms(slotIndex).y
        ELSE
            ' If we can't create more platforms, break to avoid infinite loop
            EXIT WHILE
        END IF
    WEND
END SUB

SUB HandleInput
    ' Only handle input during gameplay
    IF gameState = 0 THEN
        ' Jump on spacebar or up arrow
        IF (_KEYDOWN(32) OR _KEYDOWN(18432)) AND onGround THEN
            pvy = JUMP_STRENGTH
            onGround = 0
            bounceStrength = 15
            CALL CreateBounceParticles(px, py + PLAYER_SIZE)
        END IF

        ' Left/Right movement
        IF _KEYDOWN(19200) THEN ' Left arrow
            pvx = pvx - 0.5
        END IF
        IF _KEYDOWN(19712) THEN ' Right arrow
            pvx = pvx + 0.5
        END IF
    END IF
END SUB

SUB UpdateGame
    gameTime = gameTime + 0.016

    ' Apply gravity
    pvy = pvy + GRAVITY

    ' Apply friction
    pvx = pvx * 0.95

    ' Limit horizontal velocity
    IF pvx > 8 THEN pvx = 8
    IF pvx < -8 THEN pvx = -8

    ' Update player position
    px = px + pvx
    py = py + pvy

    ' Keep player on screen horizontally
    IF px < PLAYER_SIZE THEN px = PLAYER_SIZE
    IF px > 1280 - PLAYER_SIZE THEN px = 1280 - PLAYER_SIZE

    ' Check platform collisions
    onGround = 0
    FOR i = 0 TO MAX_PLATFORMS - 1
        IF platforms(i).active THEN
            IF px + PLAYER_SIZE > platforms(i).x AND px - PLAYER_SIZE < platforms(i).x + platforms(i).w THEN
                IF py + PLAYER_SIZE > platforms(i).y AND py + PLAYER_SIZE < platforms(i).y + PLATFORM_HEIGHT + 10 THEN
                    IF pvy > 0 THEN ' Falling down
                        py = platforms(i).y - PLAYER_SIZE
                        pvy = 0
                        onGround = 1

                        ' Check if this is the top level platform for level completion
                        IF platforms(i).isLevelPlatform AND platforms(i).y = levelTopY AND NOT levelCompleted THEN
                            levelCompleted = 1

                            ' Level complete! Generate new level but keep score
                            level = level + 1
                            levelSeed = TIMER * 1000 + RND * 10000 ' New seed for next level

                            ' Reset player position to bottom
                            px = 640
                            py = 479 ' Start just above platform
                            pvx = 0
                            pvy = 0
                            onGround = 0 ' Let physics settle naturally
                            cameraY = 0
                            lastScoredPlatform = -1

                            ' Generate completely new level
                            CALL GenerateLevel

                            ' Bonus points for completing level
                            score = score + 1000

                            ' Create celebration particles
                            CALL CreateBounceParticles(px, py)
                        END IF

                        ' Only score if this is a new platform and player actually jumped to it
                        IF NOT platforms(i).bounced AND platforms(i).id > lastScoredPlatform AND pvy > 3 THEN
                            bounceStrength = 20 + RND * 10
                            platforms(i).bounced = 1

                            ' Give extra points for level platforms
                            IF platforms(i).isLevelPlatform THEN
                                score = score + 20
                            ELSE
                                score = score + 10
                            END IF

                            lastScoredPlatform = platforms(i).id
                            CALL CreateBounceParticles(px, py + PLAYER_SIZE)
                        END IF
                    END IF
                END IF
            END IF
        END IF
    NEXT i

    ' Update camera to follow player
    targetCameraY = py - 400
    cameraY = cameraY + (targetCameraY - cameraY) * 0.1

    ' Generate new platforms as needed (only if level not completed)
    CALL GenerateNewPlatforms

    ' Update bounce strength
    IF bounceStrength > 0 THEN bounceStrength = bounceStrength - 1

    ' Update particles
    CALL UpdateParticles

    ' Generate ambient particles
    CALL GenerateAmbientParticles

    ' Game over if player falls too far below the starting platform
    IF py > 500 + 400 THEN ' 400 pixels below the first platform
        gameState = 1 ' Switch to game over state
        gameOverTimer = 0
    END IF
END SUB

SUB DrawGame
    ' Clear screen with pure black background
    CLS , BLACK_COLOR

    IF gameState = 0 THEN
        ' Normal gameplay drawing

        ' No background graphics - pure black background only

        ' Draw platforms
        FOR i = 0 TO MAX_PLATFORMS - 1
            IF platforms(i).active THEN
                platY = platforms(i).y - cameraY
                IF platY > -50 AND platY < 770 THEN
                    ' Level platforms are pure white, dynamic platforms are slightly dimmer
                    IF platforms(i).isLevelPlatform THEN
                        platformColor = WHITE_COLOR
                    ELSE
                        platformColor = _RGB32(180, 180, 180) ' Slightly dimmer for dynamic platforms
                    END IF

                    ' Draw platform as filled rectangle
                    FOR thick = 0 TO PLATFORM_HEIGHT
                        FOR x = platforms(i).x TO platforms(i).x + platforms(i).w
                            IF x >= 0 AND x < 1280 AND platY + thick >= 0 AND platY + thick < 720 THEN
                                PSET (x, platY + thick), platformColor
                            END IF
                        NEXT x
                    NEXT thick
                END IF
            END IF
        NEXT i

        ' Draw particles
        CALL DrawParticles

        ' Draw player - always pure white
        playerY = py - cameraY
        playerSize = PLAYER_SIZE + bounceStrength * 0.5

        ' Player is always pure white
        CALL DrawPlayerSquare(px, playerY, playerSize, WHITE_COLOR)

        ' Draw level completion indicator
        ' (Green glow removed for cleaner look)

        ' Draw UI in pure white
        COLOR GRAY_COLOR
        '_PRINTSTRING (10, 10), "Score: " + STR$(score)
        _PRINTSTRING (10, 10), "Level:" + STR$(level) + " (random platforms - incremental difficulty)"
        _PRINTSTRING (10, 30), "Hold arrows to move sideways & up or space to jump"
        '_PRINTSTRING (10, 50), "Press/hold arrows to move, SPACE to jump"
        '_PRINTSTRING (10, 70), "Height: " + STR$(INT(-py / 100))
        '_PRINTSTRING (10, 90), "Platforms in level: " + STR$(PLATFORMS_PER_LEVEL)

        ' Show distance to level completion
        distanceToTop = INT((py - levelTopY) / PLATFORM_SPACING)
        IF distanceToTop > 0 THEN
            _PRINTSTRING (10, 50), "Platforms left to complete on this level:" + STR$(distanceToTop + 1)
        ELSE
            _PRINTSTRING (10, 50), "Get on top platform to generate the next level!"
        END IF

    ELSEIF gameState = 1 THEN
        ' Game Over screen
        COLOR GRAY_COLOR

        ' Center the game over text
        _PRINTSTRING (600, 300), "GAME OVER"
        _PRINTSTRING (600, 340), "Level Reached: " + STR$(level)
        _PRINTSTRING (600, 380), "Final Score: " + STR$(score)
        _PRINTSTRING (600, 420), "Press ESC to restart"
        '_PRINTSTRING (600, 460), "Press ESC to quit"
    END IF
END SUB

SUB DrawPlayerSquare (x AS SINGLE, y AS SINGLE, size AS SINGLE, col AS LONG)
    FOR dx = -size TO size
        FOR dy = -size TO size
            IF x + dx >= 0 AND x + dx < 1280 AND y + dy >= 0 AND y + dy < 720 THEN
                PSET (x + dx, y + dy), col
            END IF
        NEXT dy
    NEXT dx
END SUB

SUB CreateBounceParticles (x AS SINGLE, y AS SINGLE)
    particleAmount = 20 + RND * 30
    FOR i = 0 TO particleAmount
        ' Find empty particle slot
        FOR j = 0 TO MAX_PARTICLES - 1
            IF particles(j).life <= 0 THEN
                particles(j).x = x + (RND - 0.5) * 50
                particles(j).y = y + (RND - 0.5) * 25

                ' More varied particle velocities
                angle = RND * 6.28318 ' Random angle in radians
                speed = 5 + RND * 15
                particles(j).vx = COS(angle) * speed
                particles(j).vy = SIN(angle) * speed - RND * 8 ' Bias upward

                ' Varied lifespans
                particles(j).life = 20 + RND * 40
                particles(j).maxLife = particles(j).life

                ' Store brightness as 255 for pure white particles
                particles(j).brightness = 200 + RND * 55 ' Slight brightness variation

                EXIT FOR
            END IF
        NEXT j
    NEXT i
END SUB

SUB GenerateAmbientParticles
    IF AMBIENT_PARTICLE_RATE <= 0 THEN EXIT SUB

    FOR i = 0 TO AMBIENT_PARTICLE_RATE - 1
        ' Only generate if random chance
        IF RND < 0.6 THEN
            ' Find empty particle slot
            FOR j = 0 TO MAX_PARTICLES - 1
                IF particles(j).life <= 0 THEN
                    ' Generate particles from the player's center mass
                    particles(j).x = px + (RND - 0.5) * (PLAYER_SIZE * 0.8)
                    particles(j).y = py + (RND - 0.5) * (PLAYER_SIZE * 0.8)

                    ' Particles drip downward with slight random movement
                    particles(j).vx = (RND - 0.5) * 2
                    particles(j).vy = RND * 2 + 0.5 ' Mostly downward

                    ' Ambient particles live longer and are dimmer
                    particles(j).life = 40 + RND * 80
                    particles(j).maxLife = particles(j).life
                    particles(j).brightness = 80 + RND * 80 ' Dimmer than bounce particles

                    EXIT FOR
                END IF
            NEXT j
        END IF
    NEXT i
END SUB

SUB UpdateParticles
    FOR i = 0 TO MAX_PARTICLES - 1
        IF particles(i).life > 0 THEN
            ' Store old position for collision detection
            oldX = particles(i).x
            oldY = particles(i).y

            ' Update position
            particles(i).x = particles(i).x + particles(i).vx
            particles(i).y = particles(i).y + particles(i).vy

            ' Apply gravity to particles
            particles(i).vy = particles(i).vy + 0.15

            ' Apply air resistance
            particles(i).vx = particles(i).vx * 0.99
            particles(i).vy = particles(i).vy * 0.99

            ' Check collision with platforms
            FOR j = 0 TO MAX_PLATFORMS - 1
                IF platforms(j).active THEN
                    ' Check if particle is hitting a platform
                    IF particles(i).x >= platforms(j).x AND particles(i).x <= platforms(j).x + platforms(j).w THEN
                        IF particles(i).y >= platforms(j).y AND particles(i).y <= platforms(j).y + PLATFORM_HEIGHT THEN
                            ' Particle hit platform - make it slide off randomly
                            IF oldY < platforms(j).y THEN
                                ' Hit from above - bounce and slide
                                particles(i).y = platforms(j).y - 1
                                particles(i).vy = -ABS(particles(i).vy) * 0.3 ' Small bounce

                                ' Add random horizontal slide
                                slideDirection = 1
                                IF RND < 0.5 THEN slideDirection = -1
                                particles(i).vx = particles(i).vx + slideDirection * (1 + RND * 2)

                                ' Reduce life slightly on collision
                                particles(i).life = particles(i).life - 2
                            ELSEIF oldX < platforms(j).x THEN
                                ' Hit from left side
                                particles(i).x = platforms(j).x - 1
                                particles(i).vx = -ABS(particles(i).vx) * 0.5
                                particles(i).vy = particles(i).vy + (RND - 0.5) * 2
                            ELSEIF oldX > platforms(j).x + platforms(j).w THEN
                                ' Hit from right side
                                particles(i).x = platforms(j).x + platforms(j).w + 1
                                particles(i).vx = ABS(particles(i).vx) * 0.5
                                particles(i).vy = particles(i).vy + (RND - 0.5) * 2
                            END IF

                            EXIT FOR ' Only collide with one platform per frame
                        END IF
                    END IF
                END IF
            NEXT j

            ' Decrease life
            particles(i).life = particles(i).life - 1
        END IF
    NEXT i
END SUB

SUB DrawParticles
    DIM alpha
    FOR i = 0 TO MAX_PARTICLES - 1
        IF particles(i).life > 0 THEN
            particleY = particles(i).y - cameraY
            IF particleY >= 0 AND particleY < 720 AND particles(i).x >= 0 AND particles(i).x < 1280 THEN
                ' Particles fade by becoming more transparent but stay white
                alpha = particles(i).life / particles(i).maxLife

                ' Keep particles pure white, just fade the alpha
                IF alpha > 0.3 THEN
                    particleColor = WHITE_COLOR
                ELSE
                    ' For very faded particles, make them slightly dimmer but still white
                    dimness = INT(255 * (alpha / 0.3))
                    IF dimness < 80 THEN dimness = 80 ' Minimum brightness
                    particleColor = _RGB32(dimness, dimness, dimness)
                END IF

                ' Draw particle with size variation
                size = 1 + alpha * 2
                FOR dx = -size TO size
                    FOR dy = -size TO size
                        IF particles(i).x + dx >= 0 AND particles(i).x + dx < 1280 THEN
                            IF particleY + dy >= 0 AND particleY + dy < 720 THEN
                                PSET (particles(i).x + dx, particleY + dy), particleColor
                            END IF
                        END IF
                    NEXT dy
                NEXT dx
            END IF
        END IF
    NEXT i
END SUB