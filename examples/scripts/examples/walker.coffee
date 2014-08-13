
walker = ->
    world = window.world
    params = _params()
    scale = params['scale']
    pivot = params['pivot']
    m_offset = params['offset']
    m_motorSpeed = -2
    m_motorOn = true
    #
    for i in [0..39]
        addBody({
            name : "microball #{i + 1}"
            x : Math.random() * 620 + 10
            y : 465
            radius : 7.5 / scale
            friction : .5
            restitution : .2
            density : .5
        })
    #
    pos = b2Math.AddVV(pivot, m_offset)
    m_chassis = addBody({
        name : 'm_chassis'
        x : pos.x
        y : pos.y
        width : 150 / scale
        height : 60 / scale
        density : 1
    })
    m_chassis.m_shapeList.m_groupIndex = -1
    #
    m_wheel = addBody({
        name : 'm_wheel'
        x : pos.x
        y : pos.y
        radius : 48 / scale
        density : 1
    })
    m_wheel.m_shapeList.m_groupIndex = -1
    #
    jd = new b2RevoluteJointDef
    po = pivot.Copy()
    po.Add(m_offset)
    jd.Initialize(m_wheel, m_chassis, po)
    jd.collideConnected = false
    jd.motorSpeed = m_motorSpeed
    jd.maxMotorTorque = 400
    jd.enableMotor = m_motorOn
    m_motorJoint = world.CreateJoint(jd)
    #
    wheelAnchor = new b2Vec2(0, 24 / scale)
    wheelAnchor.Add(pivot)
    _create_leg(-1, wheelAnchor, m_chassis, m_wheel)
    _create_leg( 1, wheelAnchor, m_chassis, m_wheel)
    
    m_wheel.m_position = m_wheel.m_position
    m_wheel.m_rotation = 120 * TO_RAD
    _create_leg(-1, wheelAnchor, m_chassis, m_wheel)
    _create_leg( 1, wheelAnchor, m_chassis, m_wheel)
    
    m_wheel.m_position = m_wheel.m_position
    m_wheel.m_rotation = -120 * TO_RAD
    _create_leg(-1, wheelAnchor, m_chassis, m_wheel)
    _create_leg( 1, wheelAnchor, m_chassis, m_wheel)
    return 'Theo Jansen Walker'

_params = ->
    scale = 2
    return {
        offset : new b2Vec2(120, 380)
        scale : scale
        pivot : new b2Vec2(0, -24 / scale)
    }

_create_leg = (dir, anchor, ch, wh) ->
    world = window.world
    params = _params()
    scale = params['scale']
    m_offset = params['offset']
    p1 = [162 * dir / scale,  183 / scale]
    p2 = [216 * dir / scale,   36 / scale]
    p3 = [129 * dir / scale,   57 / scale]
    p4 = [ 93 * dir / scale,  -24 / scale]
    p5 = [180 * dir / scale,  -45 / scale]
    p6 = [ 75 * dir / scale, -111 / scale]
    if dir > 0
        points1 = [
            p3
            p2
            p1
        ]
        points2 = [
            [p6[0] - p4[0], p6[1] - p4[1]]
            [p5[0] - p4[0], p5[1] - p4[1]]
            [0, 0]
        ]
    else
        points1 = [
            p2
            p3
            p1
        ]
        points2 = [
            [p5[0] - p4[0], p5[1] - p4[1]]
            [p6[0] - p4[0], p6[1] - p4[1]]
            [0, 0]
        ]
    leg1 = addBody({
        x : m_offset.x
        y : m_offset.y
        points : points1
        density : 1
    })
    #leg1.m_angularDamping = 10
    leg1.m_shapeList.m_groupIndex = -1
    pos = b2Math.AddVV(p4, m_offset)
    leg2 = addBody({
        x : pos.x
        y : pos.y
        points : points2
        density : 1
    })
    #leg2.m_angularDamping = 10
    leg2.m_shapeList.m_groupIndex = -1

    ###djd = new b2DistanceJointDef
    # Using a soft distance constraint can reduce some jitter.
    # It also makes the structure seem a bit more fluid by
    # acting like a suspension system.
    djd.dampingRatio = .5
    djd.frequencyHz = 10

    djd.Initialize(leg1, leg2, b2Math.AddVV(p2, m_offset), b2Math.AddVV(p5, m_offset))
    world.CreateJoint(djd)
    
    djd.Initialize(leg1, leg2, b2Math.AddVV(p3, m_offset), b2Math.AddVV(p4, m_offset))
    world.CreateJoint(djd)
    
    djd.Initialize(leg1, wh, b2Math.AddVV(p3, m_offset), b2Math.AddVV(anchor, m_offset))
    world.CreateJoint(djd)
    
    djd.Initialize(leg2, wh, b2Math.AddVV(p6, m_offset), b2Math.AddVV(anchor, m_offset))
    world.CreateJoint(djd)
    
    rjd = new b2RevoluteJointDef
    rjd.Initialize(leg2, ch, b2Math.AddVV(p4, m_offset))
    world.CreateJoint(rjd)###
