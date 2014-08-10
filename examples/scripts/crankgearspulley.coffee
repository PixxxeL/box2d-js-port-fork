
crankGearsPulley = ->
    world = window.world
    ground = world.GetGroundBody()
    # --------------------------------------------------------------------------
    # crank
    crank = addBody({
        name : 'crank'
        x : 100
        y : 480 - 105
        width : 15
        height : 60
        density : 1
    })
    # revolute joint
    rjd = new b2RevoluteJointDef
    rjd.Initialize(ground, crank, new b2Vec2(100, 480 - 75))
    rjd.motorSpeed = -1 * Math.PI
    rjd.motorTorque = 5000000000
    rjd.enableMotor = true
    rj = world.CreateJoint(rjd)
    # follower
    follower = addBody({
        name : 'follower'
        x : 100
        y : 480 - 195
        width : 15
        height : 120
        density : 1
    })
    rjd.Initialize(crank, follower, new b2Vec2(100, 480 - 135))
    rjd.enableMotor = false
    world.CreateJoint(rjd)
    # piston
    piston = addBody({
        name : 'piston'
        x : 100
        y : 480 - 255
        width : 45
        height : 45
        density : 1
    })
    rjd.Initialize(follower, piston, new b2Vec2(100, 480 - 255));
    world.CreateJoint(rjd);
    # prismatic joint
    pjd = new b2PrismaticJointDef
    pjd.Initialize(ground, piston, new b2Vec2(100, 480 - 255), new b2Vec2(0, 1))
    pjd.motorForce = 500
    pjd.enableMotor = true
    pj = world.CreateJoint(pjd)
    # payload
    payload = addBody({
        name : 'payload'
        x : 100
        y : 480 - 345
        width : 45
        height : 45
        density : 2
    })
    # --------------------------------------------------------------------------
    # gear 1
    gear_1 = addBody({
        name : 'gear 1'
        x : 200
        y : 480 * .5
        radius : 25
        density : 5
    })
    gjd1 = new b2RevoluteJointDef
    gjd1.Initialize(ground, gear_1, gear_1.m_position)
    gj1 = world.CreateJoint(gjd1)
    # gear 2
    gear_2 = addBody({
        name : 'gear 2'
        x : 275
        y : 480 * .5
        radius : 50
        density : 5
    })
    gjd2 = new b2RevoluteJointDef
    gjd2.Initialize(ground, gear_2, gear_2.m_position)
    gj2 = world.CreateJoint(gjd2)
    # plank
    plank = addBody({
        name : 'plank'
        x : 335
        y : 480 * .5
        width : 20
        height : 200
        density : 5
    })
    pjd3 = new b2PrismaticJointDef
    pjd3.Initialize(ground, plank, plank.m_position, new b2Vec2(0, 1))
    pjd3.lowerTranslation = -25
    pjd3.upperTranslation = 100
    pjd3.enableLimit = true
    pj3 = world.CreateJoint(pjd3)
    # gear joint 1
    gjd4 = new b2GearJointDef
    #gjd4.bodyA = gear_1
    #gjd4.bodyB = gear_2
    gjd4.joint1 = gj1
    gjd4.joint2 = gj2
    gjd4.ratio = 2
    gj4 = world.CreateJoint(gjd4)
    # gear joint 2
    gjd5 = new b2GearJointDef
    gjd5.joint1 = gj2
    gjd5.joint2 = pj3
    gjd5.ratio = -1 / 50
    gj5 = world.CreateJoint(gjd5)
    # --------------------------------------------------------------------------
    pulley = addBody({
        name : 'pulley'
        x : 480
        y : 250
        width : 100
        height : 40
        density : 5
    })
    pjd6 = new b2PulleyJointDef
    anchor1 = new b2Vec2(335, 180)
    anchor2 = new b2Vec2(480, 180)
    groundAnchor1 = new b2Vec2(335, 50)
    groundAnchor2 = new b2Vec2(480, 50)
    pjd6.Initialize(plank, pulley, groundAnchor1, groundAnchor2, anchor1, anchor2, 2)
    pjd6.maxLength1 = 200
    pjd6.maxLength2 = 150
    world.CreateJoint(pjd6)
    circle = addBody({
        name : 'circle'
        x : 485
        y : 100
        radius : 40
        friction : .3
        restitution : .3
        density : 5
    })
    # --------------------------------------------------------------------------
    ### line joint
    sd = new b2PolygonShape();
    sd.SetAsBox(7.5 / m_physScale, 30.0 / m_physScale);
    fixtureDef.shape = sd;
    fixtureDef.density = 1.0;

    bd = new b2BodyDef();
    bd.type = b2Body.b2_dynamicBody;
    bd.position.Set(500 / m_physScale, 500/2 / m_physScale);
    body = m_world.CreateBody(bd);
    body.CreateFixture(fixtureDef);

    var ljd:b2LineJointDef = new b2LineJointDef();
    ljd.Initialize(ground, body, body.GetPosition(), new b2Vec2(0.4, 0.6));

    ljd.lowerTranslation = -1;
    ljd.upperTranslation = 1;
    ljd.enableLimit = true;

    ljd.maxMotorForce = 1;
    ljd.motorSpeed = 0;
    ljd.enableMotor = true;

    m_world.CreateJoint(ljd);
    ###
    # --------------------------------------------------------------------------
    ### friction joint
    var fjd:b2FrictionJointDef = new b2FrictionJointDef();
    fjd.Initialize(circleBody, m_world.GetGroundBody(), circleBody.GetPosition());
    fjd.collideConnected = true;
    fjd.maxForce = 200;
    m_world.CreateJoint(fjd);
    ###
    # --------------------------------------------------------------------------
    ###
    var wjd:b2WeldJointDef = new b2WeldJointDef();
    wjd.Initialize(circleBody, body, circleBody.GetPosition());
    m_world.CreateJoint(wjd);
    ###
