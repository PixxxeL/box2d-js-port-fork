
bridge = ->
    world = window.world
    ground = world.GetGroundBody()
    rjd = new b2RevoluteJointDef
    rjd.lowerAngle = -15 / TO_RAD
    rjd.upperAngle =  15 / TO_RAD
    rjd.enableLimit = true
    # bridge
    for i in [0..9]
        body = addBody({
            name : "plank #{i}"
            width : 48
            height : 10
            density : 20
            friction : .2
        })
    ###
    var ;
    
    var prevBody:b2Body = ground;
    for (i = 0; i < numPlanks; ++i)
    {
        bd.position.Set((100 + 22 + 44 * i) / m_physScale, 250 / m_physScale);
        body = m_world.CreateBody(bd);
        body.CreateFixture(fixtureDef);
        
        anchor.Set((100 + 44 * i) / m_physScale, 250 / m_physScale);
        jd.Initialize(prevBody, body, anchor);
        m_world.CreateJoint(jd);
        
        prevBody = body;
    }
    
    anchor.Set((100 + 44 * numPlanks) / m_physScale, 250 / m_physScale);
    jd.Initialize(prevBody, ground, anchor);
    m_world.CreateJoint(jd);
    ###
