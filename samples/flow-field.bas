SCREEN _NEWIMAGE(800, 600, 32)

TYPE Particle
    x AS SINGLE
    y AS SINGLE
    angle AS SINGLE
    speed AS SINGLE
END TYPE

CONST NUM_PARTICLES = 3000
CONST PI = 3.14159

DIM SHARED particles(1 TO NUM_PARTICLES) AS Particle
DIM SHARED t AS SINGLE

FOR i = 1 TO NUM_PARTICLES
    particles(i).x = RND * 800
    particles(i).y = RND * 600
    particles(i).speed = 0.5 + RND * 1.5
    particles(i).angle = RND * PI * 2
NEXT i

DO
    t = t + 0.01
    FOR i = 1 TO NUM_PARTICLES
        fieldAngle = SIN(particles(i).x / 100 + t) * COS(particles(i).y / 100) + _
                     COS(particles(i).x / 150 - t * 0.5) * SIN(particles(i).y / 120) + _
                     SIN(particles(i).x / 80 + t * 0.7) * SIN(particles(i).y / 90 + t)

        fieldAngle = fieldAngle + (RND - 0.5) * 0.1

        particles(i).angle = particles(i).angle * 0.98 + fieldAngle * 0.02
        particles(i).speed = 0.5 + ABS(SIN(particles(i).x / 200 + t)) * 1.5
        particles(i).x = particles(i).x + COS(particles(i).angle) * particles(i).speed
        particles(i).y = particles(i).y + SIN(particles(i).angle) * particles(i).speed

        IF particles(i).x < 0 THEN
            particles(i).x = 800
            particles(i).y = particles(i).y + (RND - 0.5) * 20
        END IF
        IF particles(i).x > 800 THEN
            particles(i).x = 0
            particles(i).y = particles(i).y + (RND - 0.5) * 20
        END IF
        IF particles(i).y < 0 THEN
            particles(i).y = 600
            particles(i).x = particles(i).x + (RND - 0.5) * 20
        END IF
        IF particles(i).y > 600 THEN
            particles(i).y = 0
            particles(i).x = particles(i).x + (RND - 0.5) * 20
        END IF

        c = _RGB32(127 + 127 * SIN(particles(i).x / 200 + t), _
                   127 + 127 * COS(particles(i).y / 180 + t * 0.7), _
                   127 + 127 * SIN((particles(i).x + particles(i).y) / 300 + t * 0.5))
        PSET (particles(i).x, particles(i).y), c
    NEXT i

    _LIMIT 60
    _DISPLAY
    CLS

LOOP