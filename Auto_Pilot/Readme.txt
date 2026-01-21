The Auto-Pilot project is a microcontroller desgin for StormWorks. Contained in this folder are the lua script files used in microcontroller. 

#### Composit input/output channel information ####

Control IN/OUT (number):
    1: pilot yaw
    2: pilot pitch
    3: pilot roll
    4: pilot up/down
    5: co-Pilot yaw
    6: co-Pilot pitch
    7: co-pilot roll
    8: co-pilot up/down 
    9: pilot look x
    10: pilot look y
    11: co-pilot look x
    12: co-pilot look y
    13: target RPS
    [21-24]: engine throttle

Control IN/OUT (boolean)
    1: inside lights
    2: navigation lights
    3: spot lights
    4: instrument lights
    5: engine (compressors, fuel pumps, and turbine)


Data IN/OUT (number):
    1 - 17: Physics Sensor (see below)
    18: constant value of 1
    19: fuel
    20: 
    [21-24]: engine RPS
    30: constant 0
    31: constant 1
    32: light strob 

Pilot Seat:
    [1] a/d
    [2] w/s
    [3] left/right
    [4] up/down
    [9] look x
    [10] look y

Physics Sensor:
    [1] position x (GPS x)
    [2] position y (Altitude)
    [3] position z (GPS y)
    [4] euler rotation x
    [5] euler rotation y
    [6] euler rotation z
    [7] linear velocity x
    [8] linear velocity y
    [9] linear velocity z
    [10] angular velocity x
    [11] angular velocity y
    [12] angular velocity z
    [13] absolute linear velocity
    [14] absolute angular velocity
    [15] local z tilt
    [16] local x tilt
    [17] compass heading (-0.5 - 0.5)

    Composit channels: [1] Battery Charge, [2] Fuel Level, [3]altimeter, [4] engine throttle, [5] air/fuel ratio (13 - 15.5), [6] engine RPS, [7] fuel throttle, [8] air throttle, [11] clutch, [12] GPS x, [13] GPS y, [14] waypoint x, [15] waypoint y, [16] speed, [17] compass [30] constant 0, [31] constant 1, [32] pulse, [1] start/stop engine, [2] starter, [3] circuit breaker, [4] navigation lights, [5] spot lights, [6] instrument lights [7] electric motors