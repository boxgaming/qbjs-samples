_TITLE "Logic Circuits"

' Use numbers 1-9 to push buttons.
' Press left/right arrow to choose new circuit.

SCREEN _NEWIMAGE(800, 600, 32)

TYPE Wire
    Identity AS _UNSIGNED LONG ' 1000-x
    Pointer AS INTEGER ' Downstream component
    Value AS INTEGER ' Voltage
END TYPE

TYPE Element
    Species AS STRING ' Type of component
    Identity AS _UNSIGNED LONG ' Uniquely identifies component. (1-999)
    A AS Wire
    B AS Wire
    C AS Wire
END TYPE

TYPE Interact
    Species AS STRING ' Type of Output
    Identity AS _UNSIGNED LONG
    Pointer AS INTEGER ' Connected component
    Value AS INTEGER ' Voltage
END TYPE

DIM SHARED Component(1 TO 999) AS Element
DIM SHARED Button(1 TO 9) AS Interact
DIM SHARED Light(1 TO 9) AS Interact
DIM SHARED StateHistory(1 TO 4) AS STRING

DIM SHARED ExampleCircuitNumber AS INTEGER
DIM SHARED ExampleCircuitName AS STRING

DIM SHARED AS _UNSIGNED LONG Greenish
DIM SHARED AS _UNSIGNED LONG Yellowish
Greenish = _RGB32(80, 200, 120, 255)
Yellowish = _RGB32(244, 196, 48, 255)

' '''''''''' '''''''''' '''''''''' '''''''''' '''''''''' ''''''''''

ExampleCircuitNumber = 16

CALL Initialize
CALL LoadCircuit

' Main Loop

DO

    CALL RefreshInput

    CLS
    LINE (0, 0)-(_WIDTH, _HEIGHT), _RGB32(255, 255, 255, 255), BF
    COLOR _RGB32(0, 0, 0, 255), _RGB32(255, 255, 255, 255)
    CALL PrintCircuit
    CALL PrintInput
    CALL PrintOutput
    CALL PrintStateHistory
    CALL DrawGlyph
    CALL DrawControls
    _DISPLAY

    CALL UpdateState

    _LIMIT 60
LOOP

END

' Example circuits

SUB LoadCircuit
    SELECT CASE ExampleCircuitNumber
        CASE 1
            ExampleCircuitName = "On/Off Switch"
            'Call NewComponent("SPL", 10, 1001, 2001, 2002, 20, 20)
            'Call NewComponent("AND", 20, 2001, 2002, 2005, -1, -1)
            'Call NewButton(1, "TOG", 1001, 10)
            'Call NewLight(1, "LED", 2005, 20)
            CALL NewComponent("SPL", 20, 1001, 2001, 2002, 10, 10)
            CALL NewComponent("AND", 10, 2001, 2002, 2005, -1, -1)
            CALL NewButton(1, "TOG", 1001, 20)
            CALL NewLight(1, "LED", 2005, 10)

        CASE 2
            ' --- Latch remembers first time 1 or 2 is pressed. ---
            ExampleCircuitName = "SR Latch"
            CALL NewComponent("NOR", 10, 1001, 1002, 1005, -1, 20)
            CALL NewComponent("NOR", 30, 3001, 3002, 3005, -1, 40)
            CALL NewComponent("SPL", 20, 1005, 3002, 2005, 30, -1)
            CALL NewComponent("SPL", 40, 3005, 1002, 4005, 10, -1)
            CALL NewButton(1, "PSH", 1001, 10)
            CALL NewButton(2, "PSH", 3001, 30)
            CALL NewLight(1, "LED", 2005, 20)
            CALL NewLight(2, "LED", 4005, 40)
        CASE 3
            ' --- Button 1 and 3 only have an effect when 2 is being held. ---
            ExampleCircuitName = "SR Latch with Enable"
            CALL NewComponent("NOR", 10, 1001, 1002, 1005, -1, 20)
            CALL NewComponent("SPL", 20, 1005, 3002, 2005, 30, -1)
            CALL NewComponent("NOR", 30, 3001, 3002, 3005, -1, 40)
            CALL NewComponent("SPL", 40, 3005, 1002, 4005, 10, -1)
            CALL NewComponent("AND", 50, 5001, 5002, 1001, -1, 10)
            CALL NewComponent("SPL", 60, 6001, 5002, 7002, 50, 70)
            CALL NewComponent("AND", 70, 7001, 7002, 3001, -1, 30)
            CALL NewButton(1, "PSH", 5001, 50)
            CALL NewButton(2, "PSH", 6001, 60)
            CALL NewButton(3, "PSH", 7001, 70)
            CALL NewLight(1, "LED", 2005, 20)
            CALL NewLight(2, "LED", 4005, 40)
        CASE 4
            ' --- A pulse drives input 2. ---
            ExampleCircuitName = "SR Latch on Pulse"
            CALL NewComponent("NOR", 10, 1001, 1002, 1005, -1, 20)
            CALL NewComponent("SPL", 20, 1005, 3002, 2005, 30, -1)
            CALL NewComponent("NOR", 30, 3001, 3002, 3005, -1, 40)
            CALL NewComponent("SPL", 40, 3005, 1002, 4005, 10, -1)
            CALL NewComponent("AND", 50, 5001, 5002, 1001, -1, 10)
            CALL NewComponent("SPL", 60, 6001, 5002, 7002, 50, 70)
            CALL NewComponent("AND", 70, 7001, 7002, 3001, -1, 30)
            CALL NewButton(1, "PSH", 5001, 50)
            CALL NewButton(2, "PLS", 6001, 60)
            CALL NewButton(3, "PSH", 7001, 70)
            CALL NewLight(1, "LED", 2005, 20)
            CALL NewLight(2, "LED", 4005, 40)
        CASE 5
            ExampleCircuitName = "D Latch"
            CALL NewComponent("NOR", 1, 1001, 1002, 1005, -1, 2)
            CALL NewComponent("SPL", 2, 1005, 3002, 2005, 3, -1)
            CALL NewComponent("NOR", 3, 3001, 3002, 3005, -1, 4)
            CALL NewComponent("SPL", 4, 3005, 1002, 4005, 1, -1)
            CALL NewComponent("AND", 5, 5001, 5002, 1001, -1, 1)
            CALL NewComponent("SPL", 6, 6001, 5002, 7002, 5, 7)
            CALL NewComponent("AND", 7, 7001, 7002, 3001, -1, 3)
            CALL NewComponent("SPL", 8, 8001, 7001, 9001, 7, 9)
            CALL NewComponent("INV", 9, 9001, 5001, 0, 5, -1)
            CALL NewButton(1, "PSH", 8001, 8)
            CALL NewButton(2, "PSH", 6001, 6)
            CALL NewLight(1, "LED", 2005, 2)
            CALL NewLight(2, "LED", 4005, 4)
        CASE 6
            ExampleCircuitName = "Half Adder"
            CALL NewComponent("XOR", 10, 1001, 1002, 1005, -1, -1)
            CALL NewComponent("SPL", 20, 2001, 1001, 3001, 10, 30)
            CALL NewComponent("AND", 30, 3001, 3002, 3005, -1, -1)
            CALL NewComponent("SPL", 40, 4001, 1002, 3002, 10, 30)
            CALL NewButton(1, "PSH", 2001, 20)
            CALL NewButton(2, "PSH", 4001, 40)
            CALL NewLight(1, "LED", 1005, 10)
            CALL NewLight(2, "LED", 3005, 30)
        CASE 7
            ExampleCircuitName = "Full Adder"
            CALL NewComponent("XOR", 10, 1001, 1002, 1005, -1, -1)
            CALL NewComponent("SPL", 20, 6005, 1001, 4002, 10, 40)
            CALL NewComponent("SPL", 30, 3001, 1002, 4001, 10, 40)
            CALL NewComponent("AND", 40, 4001, 4002, 5001, -1, 50)
            CALL NewComponent("OR", 50, 5001, 5002, 5005, 10, 30)
            CALL NewComponent("XOR", 60, 6001, 6002, 6005, -1, 20)
            CALL NewComponent("AND", 70, 7001, 7002, 5002, -1, 50)
            CALL NewComponent("SPL", 80, 8001, 6001, 7002, 60, 70)
            CALL NewComponent("SPL", 90, 9001, 6002, 7001, 60, 70)
            CALL NewButton(1, "PSH", 8001, 80) 'n1
            CALL NewButton(2, "PSH", 9001, 90) 'n2
            CALL NewButton(3, "PSH", 3001, 30) 'carry in
            CALL NewLight(1, "LED", 5005, 50) 'carry out
            CALL NewLight(2, "LED", 1005, 10) 'sum
        CASE 8
            ExampleCircuitName = "2 Bit Adder"
            CALL NewComponent("XOR", 1, 1001, 1002, 1005, -1, -1)
            CALL NewComponent("SPL", 2, 6005, 1001, 4002, 1, 4)
            CALL NewComponent("SPL", 3, 3001, 1002, 4001, 1, 4)
            CALL NewComponent("AND", 4, 4001, 4002, 5001, -1, 5)
            CALL NewComponent("OR", 5, 5001, 5002, 5005, -1, 13)
            CALL NewComponent("XOR", 6, 6001, 6002, 6005, -1, 2)
            CALL NewComponent("AND", 7, 7001, 7002, 5002, -1, 5)
            CALL NewComponent("SPL", 8, 8001, 6001, 7002, 6, 7)
            CALL NewComponent("SPL", 9, 9001, 6002, 7001, 6, 7)
            CALL NewComponent("XOR", 11, 11001, 11002, 11005, -1, -1)
            CALL NewComponent("SPL", 12, 16005, 11001, 14002, 11, 14)
            CALL NewComponent("SPL", 13, 5005, 11002, 14001, 11, 14)
            CALL NewComponent("AND", 14, 14001, 14002, 15001, -1, 15)
            CALL NewComponent("OR", 15, 15001, 15002, 15005, -1, -1)
            CALL NewComponent("XOR", 16, 16001, 16002, 16005, -1, 12)
            CALL NewComponent("AND", 17, 17001, 17002, 15002, -1, 15)
            CALL NewComponent("SPL", 18, 18001, 16001, 17002, 16, 17)
            CALL NewComponent("SPL", 19, 19001, 16002, 17001, 16, 17)
            CALL NewButton(9, "PSH", 3001, 3) 'carry in
            CALL NewButton(1, "TOG", 8001, 8) 'a0
            CALL NewButton(2, "TOG", 9001, 9) 'b0
            CALL NewButton(3, "TOG", 18001, 18) 'a1
            CALL NewButton(4, "TOG", 19001, 19) 'b1
            CALL NewLight(1, "LED", 15005, 15) 'carry out
            CALL NewLight(2, "LED", 11005, 11) 'sum1
            CALL NewLight(3, "LED", 1005, 1) 'sum0
        CASE 9
            ExampleCircuitName = "3 Bit Adder"
            CALL NewComponent("XOR", 1, 1001, 1002, 1005, -1, -1)
            CALL NewComponent("SPL", 2, 6005, 1001, 4002, 1, 4)
            CALL NewComponent("SPL", 3, 3001, 1002, 4001, 1, 4)
            CALL NewComponent("AND", 4, 4001, 4002, 5001, -1, 5)
            CALL NewComponent("OR", 5, 5001, 5002, 5005, -1, 13)
            CALL NewComponent("XOR", 6, 6001, 6002, 6005, -1, 2)
            CALL NewComponent("AND", 7, 7001, 7002, 5002, -1, 5)
            CALL NewComponent("SPL", 8, 8001, 6001, 7002, 6, 7)
            CALL NewComponent("SPL", 9, 9001, 6002, 7001, 6, 7)
            CALL NewComponent("XOR", 11, 11001, 11002, 11005, -1, -1)
            CALL NewComponent("SPL", 12, 16005, 11001, 14002, 11, 14)
            CALL NewComponent("SPL", 13, 5005, 11002, 14001, 11, 14)
            CALL NewComponent("AND", 14, 14001, 14002, 15001, -1, 15)
            CALL NewComponent("OR", 15, 15001, 15002, 15005, -1, 23)
            CALL NewComponent("XOR", 16, 16001, 16002, 16005, -1, 12)
            CALL NewComponent("AND", 17, 17001, 17002, 15002, -1, 15)
            CALL NewComponent("SPL", 18, 18001, 16001, 17002, 16, 17)
            CALL NewComponent("SPL", 19, 19001, 16002, 17001, 16, 17)
            CALL NewComponent("XOR", 21, 21001, 21002, 21005, -1, -1)
            CALL NewComponent("SPL", 22, 26005, 21001, 24002, 21, 24)
            CALL NewComponent("SPL", 23, 15005, 21002, 24001, 21, 24)
            CALL NewComponent("AND", 24, 24001, 24002, 25001, -1, 25)
            CALL NewComponent("OR", 25, 25001, 25002, 25005, -1, -1)
            CALL NewComponent("XOR", 26, 26001, 26002, 26005, -1, 22)
            CALL NewComponent("AND", 27, 27001, 27002, 25002, -1, 25)
            CALL NewComponent("SPL", 28, 28001, 26001, 27002, 26, 27)
            CALL NewComponent("SPL", 29, 29001, 26002, 27001, 26, 27)
            CALL NewButton(9, "PSH", 3001, 3) 'carry in
            CALL NewButton(1, "TOG", 8001, 8) 'a0
            CALL NewButton(2, "TOG", 9001, 9) 'b0
            CALL NewButton(3, "TOG", 18001, 18) 'a1
            CALL NewButton(4, "TOG", 19001, 19) 'b1
            CALL NewButton(5, "TOG", 28001, 28) 'a2
            CALL NewButton(6, "TOG", 29001, 29) 'b2
            CALL NewLight(1, "LED", 25005, 25) 'carry out
            CALL NewLight(2, "LED", 21005, 21) 'sum2
            CALL NewLight(3, "LED", 11005, 11) 'sum1
            CALL NewLight(4, "LED", 1005, 1) 'sum0
        CASE 10
            ExampleCircuitName = "4 Bit Adder"
            CALL NewComponent("XOR", 1, 1001, 1002, 1005, -1, -1)
            CALL NewComponent("SPL", 2, 6005, 1001, 4002, 1, 4)
            CALL NewComponent("SPL", 3, 3001, 1002, 4001, 1, 4)
            CALL NewComponent("AND", 4, 4001, 4002, 5001, -1, 5)
            CALL NewComponent("OR", 5, 5001, 5002, 5005, -1, 13)
            CALL NewComponent("XOR", 6, 6001, 6002, 6005, -1, 2)
            CALL NewComponent("AND", 7, 7001, 7002, 5002, -1, 5)
            CALL NewComponent("SPL", 8, 8001, 6001, 7002, 6, 7)
            CALL NewComponent("SPL", 9, 9001, 6002, 7001, 6, 7)
            CALL NewComponent("XOR", 11, 11001, 11002, 11005, -1, -1)
            CALL NewComponent("SPL", 12, 16005, 11001, 14002, 11, 14)
            CALL NewComponent("SPL", 13, 5005, 11002, 14001, 11, 14)
            CALL NewComponent("AND", 14, 14001, 14002, 15001, -1, 15)
            CALL NewComponent("OR", 15, 15001, 15002, 15005, -1, 23)
            CALL NewComponent("XOR", 16, 16001, 16002, 16005, -1, 12)
            CALL NewComponent("AND", 17, 17001, 17002, 15002, -1, 15)
            CALL NewComponent("SPL", 18, 18001, 16001, 17002, 16, 17)
            CALL NewComponent("SPL", 19, 19001, 16002, 17001, 16, 17)
            CALL NewComponent("XOR", 21, 21001, 21002, 21005, -1, -1)
            CALL NewComponent("SPL", 22, 26005, 21001, 24002, 21, 24)
            CALL NewComponent("SPL", 23, 15005, 21002, 24001, 21, 24)
            CALL NewComponent("AND", 24, 24001, 24002, 25001, -1, 25)
            CALL NewComponent("OR", 25, 25001, 25002, 25005, -1, 33)
            CALL NewComponent("XOR", 26, 26001, 26002, 26005, -1, 22)
            CALL NewComponent("AND", 27, 27001, 27002, 25002, -1, 25)
            CALL NewComponent("SPL", 28, 28001, 26001, 27002, 26, 27)
            CALL NewComponent("SPL", 29, 29001, 26002, 27001, 26, 27)
            CALL NewComponent("XOR", 31, 31001, 31002, 31005, -1, -1)
            CALL NewComponent("SPL", 32, 36005, 31001, 34002, 31, 34)
            CALL NewComponent("SPL", 33, 25005, 31002, 34001, 31, 34)
            CALL NewComponent("AND", 34, 34001, 34002, 35001, -1, 35)
            CALL NewComponent("OR", 35, 35001, 35002, 35005, -1, -1)
            CALL NewComponent("XOR", 36, 36001, 36002, 36005, -1, 32)
            CALL NewComponent("AND", 37, 37001, 37002, 35002, -1, 35)
            CALL NewComponent("SPL", 38, 38001, 36001, 37002, 36, 37)
            CALL NewComponent("SPL", 39, 39001, 36002, 37001, 36, 37)
            CALL NewButton(9, "PSH", 3001, 3) 'carry in
            CALL NewButton(1, "TOG", 8001, 8) 'a0
            CALL NewButton(2, "TOG", 9001, 9) 'b0
            CALL NewButton(3, "TOG", 18001, 18) 'a1
            CALL NewButton(4, "TOG", 19001, 19) 'b1
            CALL NewButton(5, "TOG", 28001, 28) 'a2
            CALL NewButton(6, "TOG", 29001, 29) 'b2
            CALL NewButton(7, "TOG", 38001, 38) 'a3
            CALL NewButton(8, "TOG", 39001, 39) 'b3
            CALL NewLight(1, "LED", 35005, 35) 'carry out
            CALL NewLight(2, "LED", 31005, 31) 'sum3
            CALL NewLight(3, "LED", 21005, 21) 'sum2
            CALL NewLight(4, "LED", 11005, 11) 'sum1
            CALL NewLight(5, "LED", 1005, 1) 'sum0
        CASE 11
            ExampleCircuitName = "Edge Detector"
            CALL NewComponent("SPL", 1, 1001, 2002, 3001, 2, 3)
            CALL NewComponent("INV", 2, 2002, 4001, 0, 4, -1)
            CALL NewComponent("AND", 3, 3001, 3002, 3010, -1, -1)
            CALL NewComponent("INV", 4, 4001, 5001, 0, 5, -1) ' pair of extra inverters
            CALL NewComponent("INV", 5, 5001, 3002, 0, 3, -1) ' (must be a pair)
            CALL NewButton(1, "PSH", 1001, 1)
            CALL NewLight(1, "LED", 3010, 3)
        CASE 12
            ExampleCircuitName = "D Flip-Flop"
            CALL NewComponent("NOR", 1, 1001, 1002, 1005, -1, 2)
            CALL NewComponent("SPL", 2, 1005, 3002, 2005, 3, -1)
            CALL NewComponent("NOR", 3, 3001, 3002, 3005, -1, 4)
            CALL NewComponent("SPL", 4, 3005, 1002, 4005, 1, -1)
            CALL NewComponent("AND", 5, 5001, 5002, 1001, -1, 1)
            CALL NewComponent("SPL", 6, 6001, 5002, 7002, 5, 7)
            CALL NewComponent("AND", 7, 7001, 7002, 3001, -1, 3)
            CALL NewComponent("SPL", 8, 8001, 7001, 9001, 7, 9)
            CALL NewComponent("INV", 9, 9001, 5001, 0, 5, -1)
            CALL NewComponent("SPL", 11, 11001, 12002, 13001, 12, 13)
            CALL NewComponent("INV", 12, 12002, 14001, 0, 14, -1)
            CALL NewComponent("AND", 13, 13001, 13002, 6001, -1, 6)
            CALL NewComponent("INV", 14, 14001, 15001, 0, 15, -1) ' pair of extra inverters
            CALL NewComponent("INV", 15, 15001, 13002, 0, 13, -1) ' (must be a pair)
            CALL NewButton(1, "PSH", 8001, 8) ' data
            CALL NewButton(2, "PSH", 11001, 11) ' enable
            CALL NewLight(1, "LED", 2005, 2)
            CALL NewLight(2, "LED", 4005, 4) ' often omitted for clarity
        CASE 13
            ExampleCircuitName = "1 Bit Counter"
            CALL NewComponent("NOR", 1, 1001, 1002, 1005, -1, 2)
            CALL NewComponent("SPL", 2, 1005, 3002, 2005, 3, -1)
            CALL NewComponent("NOR", 3, 3001, 3002, 3005, -1, 4)
            CALL NewComponent("SPL", 4, 3005, 1002, 8001, 1, 8)
            CALL NewComponent("AND", 5, 5001, 5002, 1001, -1, 1)
            CALL NewComponent("SPL", 6, 6001, 5002, 7002, 5, 7)
            CALL NewComponent("AND", 7, 7001, 7002, 3001, -1, 3)
            CALL NewComponent("SPL", 8, 8001, 7001, 9001, 7, 9)
            CALL NewComponent("INV", 9, 9001, 5001, 0, 5, -1)
            CALL NewComponent("SPL", 11, 11001, 12002, 13001, 12, 13)
            CALL NewComponent("INV", 12, 12002, 14001, 0, 14, -1)
            CALL NewComponent("AND", 13, 13001, 13002, 6001, -1, 6)
            CALL NewComponent("INV", 14, 14001, 15001, 0, 15, -1)
            CALL NewComponent("INV", 15, 15001, 13002, 0, 13, -1)
            CALL NewButton(1, "PSH", 11001, 11)
            CALL NewLight(1, "LED", 8001, 8)
        CASE 14
            ExampleCircuitName = "2 Bit Counter"
            CALL NewComponent("NOR", 1, 1001, 1002, 1005, -1, 2)
            CALL NewComponent("SPL", 2, 1005, 3002, 31001, 3, 31)
            CALL NewComponent("NOR", 3, 3001, 3002, 3005, -1, 4)
            CALL NewComponent("SPL", 4, 3005, 1002, 8001, 1, 8)
            CALL NewComponent("AND", 5, 5001, 5002, 1001, -1, 1)
            CALL NewComponent("SPL", 6, 6001, 5002, 7002, 5, 7)
            CALL NewComponent("AND", 7, 7001, 7002, 3001, -1, 3)
            CALL NewComponent("SPL", 8, 8001, 7001, 9001, 7, 9)
            CALL NewComponent("INV", 9, 9001, 5001, 0, 5, -1)
            CALL NewComponent("SPL", 11, 11001, 12002, 13001, 12, 13)
            CALL NewComponent("INV", 12, 12002, 14001, 0, 14, -1)
            CALL NewComponent("AND", 13, 13001, 13002, 6001, -1, 6)
            CALL NewComponent("INV", 14, 14001, 15001, 0, 15, -1)
            CALL NewComponent("INV", 15, 15001, 13002, 0, 13, -1)
            CALL NewComponent("NOR", 21, 21001, 21002, 21005, -1, 22)
            CALL NewComponent("SPL", 22, 21005, 23002, 22005, 23, -1)
            CALL NewComponent("NOR", 23, 23001, 23002, 23005, -1, 24)
            CALL NewComponent("SPL", 24, 23005, 21002, 28001, 21, 28)
            CALL NewComponent("AND", 25, 25001, 25002, 21001, -1, 21)
            CALL NewComponent("SPL", 26, 26001, 25002, 27002, 25, 27)
            CALL NewComponent("AND", 27, 27001, 27002, 23001, -1, 23)
            CALL NewComponent("SPL", 28, 28001, 27001, 29001, 27, 29)
            CALL NewComponent("INV", 29, 29001, 25001, 0, 25, -1)
            CALL NewComponent("SPL", 31, 31001, 32002, 33001, 32, 33)
            CALL NewComponent("INV", 32, 32002, 34001, 0, 34, -1)
            CALL NewComponent("AND", 33, 33001, 33002, 26001, -1, 26)
            CALL NewComponent("INV", 34, 34001, 35001, 0, 35, -1)
            CALL NewComponent("INV", 35, 35001, 33002, 0, 33, -1)
            CALL NewButton(1, "PSH", 11001, 11)
            CALL NewLight(1, "LED", 8001, 8)
            CALL NewLight(2, "LED", 28001, 28)
        CASE 15
            ExampleCircuitName = "3 Bit Counter"
            CALL NewComponent("NOR", 1, 1001, 1002, 1005, -1, 2)
            CALL NewComponent("SPL", 2, 1005, 3002, 31001, 3, 31)
            CALL NewComponent("NOR", 3, 3001, 3002, 3005, -1, 4)
            CALL NewComponent("SPL", 4, 3005, 1002, 8001, 1, 8)
            CALL NewComponent("AND", 5, 5001, 5002, 1001, -1, 1)
            CALL NewComponent("SPL", 6, 6001, 5002, 7002, 5, 7)
            CALL NewComponent("AND", 7, 7001, 7002, 3001, -1, 3)
            CALL NewComponent("SPL", 8, 8001, 7001, 9001, 7, 9)
            CALL NewComponent("INV", 9, 9001, 5001, 0, 5, -1)
            CALL NewComponent("SPL", 11, 11001, 12002, 13001, 12, 13)
            CALL NewComponent("INV", 12, 12002, 14001, 0, 14, -1)
            CALL NewComponent("AND", 13, 13001, 13002, 6001, -1, 6)
            CALL NewComponent("INV", 14, 14001, 15001, 0, 15, -1)
            CALL NewComponent("INV", 15, 15001, 13002, 0, 13, -1)
            CALL NewComponent("NOR", 21, 21001, 21002, 21005, -1, 22)
            CALL NewComponent("SPL", 22, 21005, 23002, 51001, 23, 51)
            CALL NewComponent("NOR", 23, 23001, 23002, 23005, -1, 24)
            CALL NewComponent("SPL", 24, 23005, 21002, 28001, 21, 28)
            CALL NewComponent("AND", 25, 25001, 25002, 21001, -1, 21)
            CALL NewComponent("SPL", 26, 26001, 25002, 27002, 25, 27)
            CALL NewComponent("AND", 27, 27001, 27002, 23001, -1, 23)
            CALL NewComponent("SPL", 28, 28001, 27001, 29001, 27, 29)
            CALL NewComponent("INV", 29, 29001, 25001, 0, 25, -1)
            CALL NewComponent("SPL", 31, 31001, 32002, 33001, 32, 33)
            CALL NewComponent("INV", 32, 32002, 34001, 0, 34, -1)
            CALL NewComponent("AND", 33, 33001, 33002, 26001, -1, 26)
            CALL NewComponent("INV", 34, 34001, 35001, 0, 35, -1)
            CALL NewComponent("INV", 35, 35001, 33002, 0, 33, -1)
            CALL NewComponent("NOR", 41, 41001, 41002, 41005, -1, 42)
            CALL NewComponent("SPL", 42, 41005, 43002, 42005, 43, -1)
            CALL NewComponent("NOR", 43, 43001, 43002, 43005, -1, 44)
            CALL NewComponent("SPL", 44, 43005, 41002, 48001, 41, 48)
            CALL NewComponent("AND", 45, 45001, 45002, 41001, -1, 41)
            CALL NewComponent("SPL", 46, 46001, 45002, 47002, 45, 47)
            CALL NewComponent("AND", 47, 47001, 47002, 43001, -1, 43)
            CALL NewComponent("SPL", 48, 48001, 47001, 49001, 47, 49)
            CALL NewComponent("INV", 49, 49001, 45001, 0, 45, -1)
            CALL NewComponent("SPL", 51, 51001, 52002, 53001, 52, 53)
            CALL NewComponent("INV", 52, 52002, 54001, 0, 54, -1)
            CALL NewComponent("AND", 53, 53001, 53002, 46001, -1, 46)
            CALL NewComponent("INV", 54, 54001, 55001, 0, 55, -1)
            CALL NewComponent("INV", 55, 55001, 53002, 0, 53, -1)
            CALL NewButton(1, "PSH", 11001, 11)
            CALL NewLight(1, "LED", 8001, 8)
            CALL NewLight(2, "LED", 28001, 28)
            CALL NewLight(3, "LED", 48001, 48)
        CASE 16
            ExampleCircuitName = "4 Bit Counter"
            CALL NewComponent("NOR", 1, 1001, 1002, 1005, -1, 2)
            CALL NewComponent("SPL", 2, 1005, 3002, 31001, 3, 31)
            CALL NewComponent("NOR", 3, 3001, 3002, 3005, -1, 4)
            CALL NewComponent("SPL", 4, 3005, 1002, 8001, 1, 8)
            CALL NewComponent("AND", 5, 5001, 5002, 1001, -1, 1)
            CALL NewComponent("SPL", 6, 6001, 5002, 7002, 5, 7)
            CALL NewComponent("AND", 7, 7001, 7002, 3001, -1, 3)
            CALL NewComponent("SPL", 8, 8001, 7001, 9001, 7, 9)
            CALL NewComponent("INV", 9, 9001, 5001, 0, 5, -1)
            CALL NewComponent("SPL", 11, 11001, 12002, 13001, 12, 13)
            CALL NewComponent("INV", 12, 12002, 14001, 0, 14, -1)
            CALL NewComponent("AND", 13, 13001, 13002, 6001, -1, 6)
            CALL NewComponent("INV", 14, 14001, 15001, 0, 15, -1)
            CALL NewComponent("INV", 15, 15001, 13002, 0, 13, -1)
            CALL NewComponent("NOR", 21, 21001, 21002, 21005, -1, 22)
            CALL NewComponent("SPL", 22, 21005, 23002, 51001, 23, 51)
            CALL NewComponent("NOR", 23, 23001, 23002, 23005, -1, 24)
            CALL NewComponent("SPL", 24, 23005, 21002, 28001, 21, 28)
            CALL NewComponent("AND", 25, 25001, 25002, 21001, -1, 21)
            CALL NewComponent("SPL", 26, 26001, 25002, 27002, 25, 27)
            CALL NewComponent("AND", 27, 27001, 27002, 23001, -1, 23)
            CALL NewComponent("SPL", 28, 28001, 27001, 29001, 27, 29)
            CALL NewComponent("INV", 29, 29001, 25001, 0, 25, -1)
            CALL NewComponent("SPL", 31, 31001, 32002, 33001, 32, 33)
            CALL NewComponent("INV", 32, 32002, 34001, 0, 34, -1)
            CALL NewComponent("AND", 33, 33001, 33002, 26001, -1, 26)
            CALL NewComponent("INV", 34, 34001, 35001, 0, 35, -1)
            CALL NewComponent("INV", 35, 35001, 33002, 0, 33, -1)
            CALL NewComponent("NOR", 41, 41001, 41002, 41005, -1, 42)
            CALL NewComponent("SPL", 42, 41005, 43002, 71001, 43, 71)
            CALL NewComponent("NOR", 43, 43001, 43002, 43005, -1, 44)
            CALL NewComponent("SPL", 44, 43005, 41002, 48001, 41, 48)
            CALL NewComponent("AND", 45, 45001, 45002, 41001, -1, 41)
            CALL NewComponent("SPL", 46, 46001, 45002, 47002, 45, 47)
            CALL NewComponent("AND", 47, 47001, 47002, 43001, -1, 43)
            CALL NewComponent("SPL", 48, 48001, 47001, 49001, 47, 49)
            CALL NewComponent("INV", 49, 49001, 45001, 0, 45, -1)
            CALL NewComponent("SPL", 51, 51001, 52002, 53001, 52, 53)
            CALL NewComponent("INV", 52, 52002, 54001, 0, 54, -1)
            CALL NewComponent("AND", 53, 53001, 53002, 46001, -1, 46)
            CALL NewComponent("INV", 54, 54001, 55001, 0, 55, -1)
            CALL NewComponent("INV", 55, 55001, 53002, 0, 53, -1)
            CALL NewComponent("NOR", 61, 61001, 61002, 61005, -1, 62)
            CALL NewComponent("SPL", 62, 61005, 63002, 62005, 63, -1)
            CALL NewComponent("NOR", 63, 63001, 63002, 63005, -1, 64)
            CALL NewComponent("SPL", 64, 63005, 61002, 68001, 61, 68)
            CALL NewComponent("AND", 65, 65001, 65002, 61001, -1, 61)
            CALL NewComponent("SPL", 66, 66001, 65002, 67002, 65, 67)
            CALL NewComponent("AND", 67, 67001, 67002, 63001, -1, 63)
            CALL NewComponent("SPL", 68, 68001, 67001, 69001, 67, 69)
            CALL NewComponent("INV", 69, 69001, 65001, 0, 65, -1)
            CALL NewComponent("SPL", 71, 71001, 72002, 73001, 72, 73)
            CALL NewComponent("INV", 72, 72002, 74001, 0, 74, -1)
            CALL NewComponent("AND", 73, 73001, 73002, 66001, -1, 66)
            CALL NewComponent("INV", 74, 74001, 75001, 0, 75, -1)
            CALL NewComponent("INV", 75, 75001, 73002, 0, 73, -1)
            CALL NewButton(1, "PLS", 11001, 11)
            CALL NewLight(1, "LED", 8001, 8)
            CALL NewLight(2, "LED", 28001, 28)
            CALL NewLight(3, "LED", 48001, 48)
            CALL NewLight(4, "LED", 68001, 68)
        CASE ELSE
            ExampleCircuitName = ""
    END SELECT
END SUB

' '''''''''' '''''''''' '''''''''' '''''''''' '''''''''' ''''''''''

' Subs and Functions

SUB Initialize
    DIM k AS INTEGER
    FOR k = LBOUND(Component) TO UBOUND(Component)
        Component(k).Species = ""
        Component(k).Identity = 0
        Component(k).A.Identity = 0
        Component(k).B.Identity = 0
        Component(k).C.Identity = 0
        Component(k).A.Pointer = 0
        Component(k).B.Pointer = 0
        Component(k).C.Pointer = 0
        Component(k).A.Value = 0
        Component(k).B.Value = 0
        Component(k).C.Value = 0
    NEXT
    FOR k = LBOUND(Button) TO UBOUND(Button)
        Button(k).Species = ""
        Button(k).Identity = 0
        Button(k).Pointer = 0
        Button(k).Value = 0
    NEXT
    FOR k = LBOUND(Light) TO UBOUND(Light)
        Light(k).Species = ""
        Light(k).Identity = 0
        Light(k).Pointer = 0
        Light(k).Value = 0
    NEXT
    FOR k = LBOUND(StateHistory) TO UBOUND(StateHistory)
        StateHistory(k) = ""
    NEXT
END SUB

SUB Ground
    DIM k AS INTEGER
    FOR k = LBOUND(Component) TO UBOUND(Component)
        Component(k).A.Value = 0
        Component(k).B.Value = 0
        Component(k).C.Value = 0
    NEXT
    FOR k = LBOUND(Button) TO UBOUND(Button)
        Button(k).Value = 0
    NEXT
    FOR k = LBOUND(Light) TO UBOUND(Light)
        Light(k).Value = 0
    NEXT
END SUB

SUB NewComponent (TheSpecies AS STRING, TheIdentity AS _UNSIGNED LONG, WireAId AS _UNSIGNED LONG, WireBId AS _UNSIGNED LONG, WireCId AS _UNSIGNED LONG, WireBPo AS INTEGER, WireCPo AS INTEGER)
    Component(TheIdentity).Species = TheSpecies
    Component(TheIdentity).Identity = TheIdentity
    Component(TheIdentity).A.Identity = WireAId
    Component(TheIdentity).B.Identity = WireBId
    Component(TheIdentity).C.Identity = WireCId
    'Component(TheIdentity).A.Pointer = WireAPo
    Component(TheIdentity).B.Pointer = WireBPo
    Component(TheIdentity).C.Pointer = WireCPo
END SUB

SUB NewButton (TheIndex AS INTEGER, TheSpecies AS STRING, TheIdentity AS _UNSIGNED LONG, ThePointer AS INTEGER)
    Button(TheIndex).Species = TheSpecies
    Button(TheIndex).Identity = TheIdentity
    Button(TheIndex).Pointer = ThePointer
END SUB

SUB NewLight (TheIndex AS INTEGER, TheSpecies AS STRING, TheIdentity AS _UNSIGNED LONG, ThePointer AS INTEGER)
    Light(TheIndex).Species = TheSpecies
    Light(TheIndex).Identity = TheIdentity
    Light(TheIndex).Pointer = ThePointer
END SUB

SUB RefreshInput
    DIM AS _UNSIGNED LONG r
    DIM AS INTEGER h, i, j, k, q
    DIM AS DOUBLE t
    h = _KEYHIT

    FOR i = 48 + LBOUND(Button) TO 48 + UBOUND(Button)
        k = i - 48
        SELECT CASE Button(k).Species
            CASE ""
                ' Unused
            CASE "PSH" ' PuSHy Inputs
                IF (_KEYDOWN(i) <> 0) THEN
                    q = 1
                ELSE
                    q = 0
                END IF
                r = Button(k).Identity
                j = Button(k).Pointer
                IF (r = Component(j).A.Identity) THEN
                    Component(j).A.Value = q
                ELSEIF (r = Component(j).B.Identity) THEN
                    Component(j).B.Value = q
                ELSEIF (r = Component(j).C.Identity) THEN
                    Component(j).C.Value = q
                END IF
            CASE "TOG" ' Sticky Inputs
                IF (h = i) THEN
                    r = Button(k).Identity
                    j = Button(k).Pointer
                    IF (r = Component(j).A.Identity) THEN
                        q = Component(j).A.Value
                        IF (q = 0) THEN
                            Component(j).A.Value = 1
                        ELSE
                            Component(j).A.Value = 0
                        END IF
                    END IF
                    IF (r = Component(j).B.Identity) THEN
                        q = Component(j).B.Value
                        IF (q = 0) THEN
                            Component(j).B.Value = 1
                        ELSE
                            Component(j).B.Value = 0
                        END IF
                    END IF
                    IF (r = Component(j).C.Identity) THEN
                        q = Component(j).C.Value
                        IF (q = 0) THEN
                            Component(j).C.Value = 1
                        ELSE
                            Component(j).C.Value = 0
                        END IF
                    END IF
                END IF
            CASE "PLS" ' Pulse
                t = TIMER
                t = t - INT(t)
                IF (t >= 2 / 3) THEN q = 1 ELSE q = 0
                IF (k <= UBOUND(Button)) THEN
                    r = Button(k).Identity
                    j = Button(k).Pointer
                    IF (j <> -1) THEN
                        IF (r = Component(j).A.Identity) THEN
                            Component(j).A.Value = q
                        ELSEIF (r = Component(j).B.Identity) THEN
                            Component(j).B.Value = q
                        ELSEIF (r = Component(j).C.Identity) THEN
                            Component(j).C.Value = q
                        END IF
                    END IF
                END IF
        END SELECT
    NEXT

    IF (h = 19712) THEN ' rightarrow
        ExampleCircuitNumber = ExampleCircuitNumber + 1
        IF (ExampleCircuitNumber > 16) THEN ExampleCircuitNumber = 1
        CALL Initialize
        CALL LoadCircuit
    END IF

    IF (h = 19200) THEN ' leftarrow
        ExampleCircuitNumber = ExampleCircuitNumber - 1
        IF (ExampleCircuitNumber < 1) THEN ExampleCircuitNumber = 16
        CALL Initialize
        CALL LoadCircuit
    END IF

    IF (h = 48) THEN ' 0
        CALL Ground
    END IF

    _KEYCLEAR
END SUB

SUB UpdateState
    DIM AS INTEGER j, k, a, b, c
    DIM AS _UNSIGNED LONG g

    FOR k = LBOUND(Component) TO UBOUND(Component)
        IF (Component(k).Species <> "") THEN

            IF INSTR("AND NOR OR XOR", Component(k).Species) > 0 THEN
                a = Component(k).A.Value
                b = Component(k).B.Value
                ' Update self
                SELECT CASE Component(k).Species
                    CASE "AND"
                        Component(k).C.Value = BinaryAND(a, b)
                    CASE "NOR"
                        Component(k).C.Value = BinaryNOR(a, b)
                    CASE "OR"
                        Component(k).C.Value = BinaryOR(a, b)
                    CASE "XOR"
                        Component(k).C.Value = BinaryXOR(a, b)
                END SELECT
                ' Update downstream
                j = Component(k).C.Pointer
                IF (j <> -1) THEN
                    g = Component(k).C.Identity
                    c = Component(k).C.Value
                    IF (Component(j).A.Identity = g) THEN
                        Component(j).A.Value = c
                    ELSEIF (Component(j).B.Identity = g) THEN
                        Component(j).B.Value = c
                    END IF
                END IF

            ELSEIF INSTR("INV SPL", Component(k).Species) > 0 THEN
                SELECT CASE Component(k).Species
                    CASE "INV"
                        a = Component(k).A.Value
                        ' Update self
                        Component(k).B.Value = BinaryINV(a)
                        ' Update downstream
                        j = Component(k).B.Pointer
                        IF (j <> -1) THEN
                            g = Component(k).B.Identity
                            b = Component(k).B.Value
                            IF (Component(j).A.Identity = g) THEN
                                Component(j).A.Value = b
                            ELSEIF (Component(j).B.Identity = g) THEN
                                Component(j).B.Value = b
                            END IF
                        END IF

                    CASE "SPL"
                        a = Component(k).A.Value
                        ' Update self
                        Component(k).B.Value = a
                        Component(k).C.Value = a
                        ' Update downstream
                        j = Component(k).B.Pointer
                        IF (j <> -1) THEN
                            g = Component(k).B.Identity
                            b = Component(k).B.Value
                            IF (Component(j).A.Identity = g) THEN
                                Component(j).A.Value = b
                            ELSEIF (Component(j).B.Identity = g) THEN
                                Component(j).B.Value = b
                            END IF
                        END IF
                        j = Component(k).C.Pointer
                        IF (j <> -1) THEN
                            g = Component(k).C.Identity
                            c = Component(k).C.Value
                            IF (Component(j).A.Identity = g) THEN
                                Component(j).A.Value = c
                            ELSEIF (Component(j).B.Identity = g) THEN
                                Component(j).B.Value = c
                            END IF
                        END IF
                END SELECT
            END IF
        END IF
    NEXT
END SUB

FUNCTION BinaryAND (a AS INTEGER, b AS INTEGER)
    DIM TheReturn AS INTEGER
    IF ((a = 0) AND (b = 0)) THEN TheReturn = 0
    IF ((a = 0) AND (b = 1)) THEN TheReturn = 0
    IF ((a = 1) AND (b = 0)) THEN TheReturn = 0
    IF ((a = 1) AND (b = 1)) THEN TheReturn = 1
    BinaryAND = TheReturn
END FUNCTION

FUNCTION BinaryINV (a AS INTEGER)
    DIM TheReturn AS INTEGER
    IF (a = 0) THEN TheReturn = 1
    IF (a = 1) THEN TheReturn = 0
    BinaryINV = TheReturn
END FUNCTION

FUNCTION BinaryNAND (a AS INTEGER, b AS INTEGER)
    DIM TheReturn AS INTEGER
    IF ((a = 0) AND (b = 0)) THEN TheReturn = 1
    IF ((a = 0) AND (b = 1)) THEN TheReturn = 1
    IF ((a = 1) AND (b = 0)) THEN TheReturn = 1
    IF ((a = 1) AND (b = 1)) THEN TheReturn = 0
    BinaryNAND = TheReturn
END FUNCTION

FUNCTION BinaryNOR (a AS INTEGER, b AS INTEGER)
    DIM TheReturn AS INTEGER
    IF ((a = 0) AND (b = 0)) THEN TheReturn = 1
    IF ((a = 0) AND (b = 1)) THEN TheReturn = 0
    IF ((a = 1) AND (b = 0)) THEN TheReturn = 0
    IF ((a = 1) AND (b = 1)) THEN TheReturn = 0
    BinaryNOR = TheReturn
END FUNCTION

FUNCTION BinaryOR (a AS INTEGER, b AS INTEGER)
    DIM TheReturn AS INTEGER
    IF ((a = 0) AND (b = 0)) THEN TheReturn = 0
    IF ((a = 0) AND (b = 1)) THEN TheReturn = 1
    IF ((a = 1) AND (b = 0)) THEN TheReturn = 1
    IF ((a = 1) AND (b = 1)) THEN TheReturn = 1
    BinaryOR = TheReturn
END FUNCTION

FUNCTION BinaryXOR (a AS INTEGER, b AS INTEGER)
    DIM TheReturn AS INTEGER
    IF ((a = 0) AND (b = 0)) THEN TheReturn = 0
    IF ((a = 0) AND (b = 1)) THEN TheReturn = 1
    IF ((a = 1) AND (b = 0)) THEN TheReturn = 1
    IF ((a = 1) AND (b = 1)) THEN TheReturn = 0
    BinaryXOR = TheReturn
END FUNCTION

SUB PrintCircuit
    DIM k, n AS INTEGER
    PRINT "Example " + _TRIM$(STR$(ExampleCircuitNumber)) + ": "; ExampleCircuitName
    PRINT
    FOR k = LBOUND(Component) TO UBOUND(Component)
        IF (Component(k).Species <> "") THEN
            n = n + 1
            PRINT "["; _TRIM$(STR$(k)); "] "; Component(k).Species; Component(k).A.Identity; Component(k).B.Identity; Component(k).C.Identity; Component(k).B.Pointer; Component(k).C.Pointer
        END IF
        IF (n = 20) THEN
            PRINT "..."
            EXIT FOR
        END IF
    NEXT
    IF (n < 20) THEN
        FOR k = n TO 20
            PRINT
        NEXT
    END IF
    PRINT
END SUB

SUB PrintInput
    DIM k AS INTEGER
    DIM AS STRING InputRep
    InputRep = ""
    PRINT "Input: "
    FOR k = LBOUND(Button) TO UBOUND(Button)
        IF (Button(k).Species <> "") THEN
            IF (Button(k).Identity = Component(Button(k).Pointer).A.Identity) THEN
                IF Button(k).Species = "PSH" THEN
                    InputRep = InputRep + "(" + _TRIM$(STR$(Button(k).Pointer)) + ":" + _TRIM$(STR$(Button(k).Identity)) + ")" + _TRIM$(STR$(Component(Button(k).Pointer).A.Value)) + " "
                ELSEIF Button(k).Species = "TOG" THEN
                    InputRep = InputRep + "[" + _TRIM$(STR$(Button(k).Pointer)) + ":" + _TRIM$(STR$(Button(k).Identity)) + "]" + _TRIM$(STR$(Component(Button(k).Pointer).B.Value)) + " "
                ELSEIF Button(k).Species = "PLS" THEN
                    InputRep = InputRep + "{" + _TRIM$(STR$(Button(k).Pointer)) + ":" + _TRIM$(STR$(Button(k).Identity)) + "}" + _TRIM$(STR$(Component(Button(k).Pointer).C.Value)) + " "
                END IF
            ELSEIF (Button(k).Identity = Component(Button(k).Pointer).B.Identity) THEN
                IF Button(k).Species = "PSH" THEN
                    InputRep = InputRep + "(" + _TRIM$(STR$(Button(k).Pointer)) + ":" + _TRIM$(STR$(Button(k).Identity)) + ")" + _TRIM$(STR$(Component(Button(k).Pointer).A.Value)) + " "
                ELSEIF Button(k).Species = "TOG" THEN
                    InputRep = InputRep + "[" + _TRIM$(STR$(Button(k).Pointer)) + ":" + _TRIM$(STR$(Button(k).Identity)) + "]" + _TRIM$(STR$(Component(Button(k).Pointer).B.Value)) + " "
                ELSEIF Button(k).Species = "PLS" THEN
                    InputRep = InputRep + "{" + _TRIM$(STR$(Button(k).Pointer)) + ":" + _TRIM$(STR$(Button(k).Identity)) + "}" + _TRIM$(STR$(Component(Button(k).Pointer).C.Value)) + " "
                END IF
            ELSEIF (Button(k).Identity = Component(Button(k).Pointer).C.Identity) THEN
                IF Button(k).Species = "PSH" THEN
                    InputRep = InputRep + "(" + _TRIM$(STR$(Button(k).Pointer)) + ":" + _TRIM$(STR$(Button(k).Identity)) + ")" + _TRIM$(STR$(Component(Button(k).Pointer).A.Value)) + " "
                ELSEIF Button(k).Species = "TOG" THEN
                    InputRep = InputRep + "[" + _TRIM$(STR$(Button(k).Pointer)) + ":" + _TRIM$(STR$(Button(k).Identity)) + "]" + _TRIM$(STR$(Component(Button(k).Pointer).B.Value)) + " "
                ELSEIF Button(k).Species = "PLS" THEN
                    InputRep = InputRep + "{" + _TRIM$(STR$(Button(k).Pointer)) + ":" + _TRIM$(STR$(Button(k).Identity)) + "}" + _TRIM$(STR$(Component(Button(k).Pointer).C.Value)) + " "
                END IF
            END IF
        END IF
    NEXT
    IF (InputRep <> "") THEN
        IF (LEN(InputRep) >= (1 * _WIDTH) / 8 - 3) THEN
            InputRep = LEFT$(InputRep, (1 * _WIDTH) / 8 - 3) + "..."
        END IF
        PRINT InputRep;
    END IF
    PRINT: PRINT
END SUB

SUB PrintStateHistory
    DIM k AS INTEGER
    DIM StateRep AS STRING
    StateRep = ""
    FOR k = LBOUND(Component) TO UBOUND(Component)
        IF (Component(k).Species <> "") THEN
            StateRep = StateRep + "[" + _TRIM$(STR$(k)) + "]" + _TRIM$(STR$(Component(k).A.Value)) + _TRIM$(STR$(Component(k).B.Value)) + _TRIM$(STR$(Component(k).C.Value))
        END IF
    NEXT
    IF (StateHistory(1) <> StateRep) THEN
        FOR k = UBOUND(StateHistory) TO 2 STEP -1
            StateHistory(k) = StateHistory(k - 1)
        NEXT
        StateHistory(1) = StateRep
    END IF
    PRINT "State:"
    FOR k = LBOUND(StateHistory) TO UBOUND(StateHistory)
        StateRep = StateHistory(k)
        IF (LEN(StateRep) >= (1 * _WIDTH) / 8 - 3) THEN
            StateRep = LEFT$(StateHistory(k), (1 * _WIDTH) / 8 - 3) + "..."
        END IF
        PRINT StateRep
    NEXT
END SUB

SUB PrintOutput
    DIM k AS INTEGER
    DIM AS STRING OutputRep
    OutputRep = ""
    PRINT "Output: "
    FOR k = LBOUND(Light) TO UBOUND(Light)
        IF (Light(k).Species <> "") THEN
            IF (Light(k).Identity = Component(Light(k).Pointer).A.Identity) THEN
                OutputRep = OutputRep + "(" + _TRIM$(STR$(Light(k).Pointer)) + ":" + _TRIM$(STR$(Light(k).Identity)) + ")" + _TRIM$(STR$(Component(Light(k).Pointer).A.Value)) + " "
            END IF
            IF (Light(k).Identity = Component(Light(k).Pointer).B.Identity) THEN
                OutputRep = OutputRep + "(" + _TRIM$(STR$(Light(k).Pointer)) + ":" + _TRIM$(STR$(Light(k).Identity)) + ")" + _TRIM$(STR$(Component(Light(k).Pointer).B.Value)) + " "
            END IF
            IF (Light(k).Identity = Component(Light(k).Pointer).C.Identity) THEN
                OutputRep = OutputRep + "(" + _TRIM$(STR$(Light(k).Pointer)) + ":" + _TRIM$(STR$(Light(k).Identity)) + ")" + _TRIM$(STR$(Component(Light(k).Pointer).C.Value)) + " "
            END IF
        END IF
    NEXT
    IF (OutputRep <> "") THEN
        IF (LEN(OutputRep) >= (1 * _WIDTH) / 8 - 3) THEN
            OutputRep = LEFT$(OutputRep, (1 * _WIDTH) / 8 - 3) + "..."
        END IF
        PRINT OutputRep;
    END IF
    PRINT: PRINT
END SUB

SUB DrawGlyph
    TYPE Vector
        x AS DOUBLE
        y AS DOUBLE
    END TYPE
    DIM AS INTEGER n, m, k, j
    DIM AS _UNSIGNED LONG g, ActiveColor
    DIM Position(UBOUND(Component)) AS Vector
    n = 0
    FOR k = LBOUND(Component) TO UBOUND(Component)
        IF (Component(k).Species <> "") THEN n = n + 1
    NEXT
    m = 0
    FOR k = LBOUND(Component) TO UBOUND(Component)
        IF (Component(k).Species <> "") THEN
            m = m + 1
            Position(k).x = _WIDTH / 4 + 120 * COS(1 * 2 * 3.14 * (m / n))
            Position(k).y = _HEIGHT / 4 + 120 * SIN(3 * 2 * 3.14 * (m / n))
        END IF
    NEXT
    CALL CPrintstring("Glyph:", _WIDTH / 4 - 8 * (6) / 2, _HEIGHT / 4 + 150, _RGB32(0, 0, 0, 255))
    FOR k = LBOUND(Component) TO UBOUND(Component)
        IF (Component(k).Species <> "") THEN
            g = Component(k).B.Identity
            j = Component(k).B.Pointer
            IF (j <> -1) THEN
                IF (g = Component(j).A.Identity) THEN
                    IF (Component(j).A.Value = 1) THEN
                        ActiveColor = _RGB32(255, 0, 0)
                    ELSE
                        ActiveColor = _RGB32(0, 0, 255)
                    END IF
                ELSEIF (g = Component(j).B.Identity) THEN
                    IF (Component(j).B.Value = 1) THEN
                        ActiveColor = _RGB32(255, 0, 0)
                    ELSE
                        ActiveColor = _RGB32(0, 0, 255)
                    END IF
                ELSEIF (g = Component(j).C.Identity) THEN
                    IF (Component(j).C.Value = 1) THEN
                        ActiveColor = _RGB32(255, 0, 0)
                    ELSE
                        ActiveColor = _RGB32(0, 0, 255)
                    END IF
                END IF
                CALL CLine(Position(k).x, Position(k).y, Position(j).x, Position(j).y, ActiveColor)
                'CALL LineSmooth(Position(k).x, Position(k).y, Position(j).x, Position(j).y, ActiveColor)
            END IF
            g = Component(k).C.Identity
            j = Component(k).C.Pointer
            IF (j <> -1) THEN
                IF (g = Component(j).A.Identity) THEN
                    IF (Component(j).A.Value = 1) THEN
                        ActiveColor = _RGB32(255, 0, 0)
                    ELSE
                        ActiveColor = _RGB32(0, 0, 255)
                    END IF
                ELSEIF (g = Component(j).B.Identity) THEN
                    IF (Component(j).B.Value = 1) THEN
                        ActiveColor = _RGB32(255, 0, 0)
                    ELSE
                        ActiveColor = _RGB32(0, 0, 255)
                    END IF
                ELSEIF (g = Component(j).C.Identity) THEN
                    IF (Component(j).C.Value = 1) THEN
                        ActiveColor = _RGB32(255, 0, 0)
                    ELSE
                        ActiveColor = _RGB32(0, 0, 255)
                    END IF
                END IF
                CALL CLine(Position(k).x, Position(k).y, Position(j).x, Position(j).y, ActiveColor)
                'CALL LineSmooth(Position(k).x, Position(k).y, Position(j).x, Position(j).y, ActiveColor)
            END IF
        END IF
    NEXT
    FOR k = LBOUND(Button) TO UBOUND(Button)
        IF (Button(k).Species <> "") THEN
            j = Button(k).Pointer
            IF (Button(k).Identity = Component(j).A.Identity) THEN
                n = Component(j).A.Value
            ELSEIF (Button(k).Identity = Component(j).B.Identity) THEN
                n = Component(j).B.Value
            ELSEIF (Button(k).Identity = Component(j).C.Identity) THEN
                n = Component(j).C.Value
            END IF
            SELECT CASE Button(k).Species
                CASE "PSH"
                    CALL CCircle(Position(j).x, Position(j).y, 18, Greenish)
                    IF (n = 1) THEN CALL CCircle(Position(j).x, Position(j).y, 16, Greenish)
                CASE "TOG"
                    CALL CLineB(Position(j).x - 16, Position(j).y - 16, Position(j).x + 16, Position(j).y + 16, Greenish)
                    IF (n = 1) THEN CALL CLineB(Position(j).x - 14, Position(j).y - 14, Position(j).x + 14, Position(j).y + 14, Greenish)
                CASE "PLS"
                    CALL CLine(Position(j).x - 20 + 4, Position(j).y - 20 + 5, Position(j).x + 20 + 4, Position(j).y - 20 + 5, Greenish)
                    CALL CLine(Position(j).x - 22 + 4, Position(j).y - 20 + 5, Position(j).x + 0 + 4, Position(j).y + 22 + 5, Greenish)
                    CALL CLine(Position(j).x + 22 + 4, Position(j).y - 20 + 5, Position(j).x + 0 + 4, Position(j).y + 22 + 5, Greenish)
                    IF (n = 1) THEN
                        CALL CLine(Position(j).x - 18 + 4, Position(j).y - 18 + 5, Position(j).x + 18 + 4, Position(j).y - 18 + 5, Greenish)
                        CALL CLine(Position(j).x - 18 + 4, Position(j).y - 18 + 5, Position(j).x + 0 + 4, Position(j).y + 18 + 5, Greenish)
                        CALL CLine(Position(j).x + 18 + 4, Position(j).y - 18 + 5, Position(j).x + 0 + 4, Position(j).y + 18 + 5, Greenish)
                    END IF
            END SELECT
        END IF
    NEXT
    FOR k = LBOUND(Light) TO UBOUND(Light)
        IF (Light(k).Species <> "") THEN
            j = Light(k).Pointer
            IF (Light(k).Identity = Component(j).A.Identity) THEN
                n = Component(j).A.Value
            ELSEIF (Light(k).Identity = Component(j).B.Identity) THEN
                n = Component(j).B.Value
            ELSEIF (Light(k).Identity = Component(j).C.Identity) THEN
                n = Component(j).C.Value
            END IF
            CALL CLineB(Position(j).x - 16, Position(j).y - 16, Position(j).x + 16, Position(j).y + 16, Yellowish)
            IF (n = 1) THEN
                CALL CLineB(Position(j).x - 14, Position(j).y - 14, Position(j).x + 14, Position(j).y + 14, Yellowish)
            END IF
        END IF
    NEXT
    FOR k = LBOUND(Component) TO UBOUND(Component)
        IF (Component(k).Species <> "") THEN
            CALL CPrintstring(_TRIM$(STR$(k)), Position(k).x - 2, Position(k).y + 6, _RGB32(0, 0, 0, 255))
        END IF
    NEXT
END SUB

SUB DrawControls
    DIM AS INTEGER n, k, j
    DIM AS DOUBLE x0, y0
    CALL CPrintstring("Button:", _WIDTH / 4 - 8 * (7) / 2, 0, _RGB32(0, 0, 0, 255))
    FOR k = LBOUND(Button) TO UBOUND(Button)
        x0 = _WIDTH / 4 - 120 + k * 25
        y0 = -25
        n = 0
        j = Button(k).Pointer
        IF (j > 0) THEN
            IF (Button(k).Identity = Component(j).A.Identity) THEN
                n = Component(j).A.Value
            ELSEIF (Button(k).Identity = Component(j).B.Identity) THEN
                n = Component(j).B.Value
            ELSEIF (Button(k).Identity = Component(j).C.Identity) THEN
                n = Component(j).C.Value
            END IF
        END IF
        SELECT CASE Button(k).Species
            CASE "PSH"
                CALL CCircle(x0, y0, 10, Greenish)
                IF (n = 1) THEN CALL CPaint(x0, y0, Greenish)
            CASE "TOG"
                CALL CLineB(x0 - 10, y0 - 10, x0 + 10, y0 + 10, Greenish)
                IF (n = 1) THEN CALL CLineBF(x0 - 10, y0 - 10, x0 + 10, y0 + 10, Greenish)
            CASE "PLS"
                CALL CLine(x0 - 10, y0 - 10, x0 + 10, y0 - 10, Greenish)
                CALL CLine(x0 - 10, y0 - 10, x0 + 0, y0 + 10, Greenish)
                CALL CLine(x0 + 10, y0 - 10, x0 + 0, y0 + 10, Greenish)
                IF (n = 1) THEN CALL CPaint(x0, y0, Greenish)
            CASE ELSE
                CALL CCircle(x0, y0, 5, Greenish)
        END SELECT
    NEXT
    CALL CPrintstring("Light:", _WIDTH / 4 - 8 * (6) / 2, -50, _RGB32(0, 0, 0, 255))
    FOR k = LBOUND(Light) TO UBOUND(Light)
        x0 = _WIDTH / 4 - 120 + k * 25
        y0 = -75
        IF (Light(k).Species <> "") THEN
            CALL CLineB(x0 - 10, y0 - 10, x0 + 10, y0 + 10, Yellowish)
        ELSE
            CALL CLineB(x0 - 5, y0 - 5, x0 + 5, y0 + 5, Yellowish)
        END IF
        n = 0
        j = Light(k).Pointer
        IF (j > 0) THEN
            IF (Light(k).Identity = Component(j).A.Identity) THEN
                n = Component(j).A.Value
            ELSEIF (Light(k).Identity = Component(j).B.Identity) THEN
                n = Component(j).B.Value
            ELSEIF (Light(k).Identity = Component(j).C.Identity) THEN
                n = Component(j).C.Value
            END IF
            IF (n = 1) THEN CALL CPaint(x0, y0, Yellowish)
        END IF
    NEXT
END SUB

SUB CCircle (x0 AS DOUBLE, y0 AS DOUBLE, rad AS DOUBLE, shade AS _UNSIGNED LONG)
    CIRCLE (_WIDTH / 2 + x0, -y0 + _HEIGHT / 2), rad, shade
END SUB

SUB CPaint (x0 AS DOUBLE, y0 AS DOUBLE, shade AS _UNSIGNED LONG)
    PAINT (_WIDTH / 2 + x0, -y0 + _HEIGHT / 2), shade
END SUB

SUB CPrintstring (TheString AS STRING, x0 AS DOUBLE, y0 AS DOUBLE, shade AS _UNSIGNED LONG)
    COLOR shade
    _PRINTSTRING (_WIDTH / 2 + x0, -y0 + _HEIGHT / 2), TheString
END SUB

SUB CLine (x0 AS DOUBLE, y0 AS DOUBLE, x1 AS DOUBLE, y1 AS DOUBLE, shade AS _UNSIGNED LONG)
    LINE (_WIDTH / 2 + x0, -y0 + _HEIGHT / 2)-(_WIDTH / 2 + x1, -y1 + _HEIGHT / 2), shade
END SUB

SUB CLineB (x0 AS DOUBLE, y0 AS DOUBLE, x1 AS DOUBLE, y1 AS DOUBLE, shade AS _UNSIGNED LONG)
    LINE (_WIDTH / 2 + x0, -y0 + _HEIGHT / 2)-(_WIDTH / 2 + x1, -y1 + _HEIGHT / 2), shade, B
END SUB

SUB CLineBF (x0 AS DOUBLE, y0 AS DOUBLE, x1 AS DOUBLE, y1 AS DOUBLE, shade AS _UNSIGNED LONG)
    LINE (_WIDTH / 2 + x0, -y0 + _HEIGHT / 2)-(_WIDTH / 2 + x1, -y1 + _HEIGHT / 2), shade, BF
END SUB
