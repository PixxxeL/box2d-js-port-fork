
ragdoll = ->
    world = window.world
    rjd = new b2RevoluteJointDef
    for i in [0..1]
        startX = 70 + Math.random() * 20 + 480 * i
        startY = 20 + Math.random() * 50
        prefix = if i then 'right' else 'left'
        # head
        head = addBody({
            name : "#{prefix} head"
            x : startX
            y : startY
            radius : 12.5
            friction : .4
            restitution : .3
            density : 1
        })
        # dont work
        head.ApplyImpulse(
            new b2Vec2(
                Math.random() * 5000000 - 2500000,
                Math.random() * 5000000 - 2500000
            ), 
            head.m_position
        )
        # torsos
        torsos = []
        params = {
            x : startX
            width : 30
            height : 20
            friction : .4
            restitution : .1
            density : 1
        }
        for j in [0..2]
            params['name'] = "#{prefix} torso #{j + 1}"
            params['y'] = startY + 28 + j * 15
            torsos.push( addBody(params) )
        # upper arms
        upper_arms = []
        params = {
            y : startY + 30
            width : 13
            height : 36
            friction : .4
            restitution : .1
            density : 1
        }
        for j in [0..1]
            side = if j then 'right' else 'left'
            params['x'] = startX + if j then 20 else -20
            params['name'] = "#{prefix} upper arms #{side}"
            upper_arms.push( addBody(params) )
        # lower arms
        lower_arms = []
        params = {
            y : startY + 57
            width : 12
            height : 34
            friction : .4
            restitution : .1
            density : 1
        }
        for j in [0..1]
            side = if j then 'right' else 'left'
            params['x'] = startX + if j then 20 else -20
            params['name'] = "#{prefix} lower arms #{side}"
            lower_arms.push( addBody(params) )
        # upper legs
        upper_legs = []
        params = {
            y : startY + 85
            width : 15
            height : 44
            friction : .4
            restitution : .1
            density : 1
        }
        for j in [0..1]
            side = if j then 'right' else 'left'
            params['x'] = startX + if j then 8 else -8
            params['name'] = "#{prefix} upper legs #{side}"
            upper_legs.push( addBody(params) )
        # lower legs
        lower_legs = []
        params = {
            y : startY + 120
            width : 12
            height : 40
            friction : .4
            restitution : .1
            density : 1
        }
        for j in [0..1]
            side = if j then 'right' else 'left'
            params['x'] = startX + if j then 8 else -8
            params['name'] = "#{prefix} lower legs #{side}"
            lower_legs.push( addBody(params) )
        # joint
        rjd.enableLimit = true
        # head to shoulders
        rjd.lowerAngle = -40 / TO_RAD
        rjd.upperAngle =  40 / TO_RAD
        rjd.Initialize(torsos[0], head, new b2Vec2(startX, startY + 15))
        world.CreateJoint(rjd)
        # upper arm to left shoulders
        rjd.lowerAngle = -85 / TO_RAD
        rjd.upperAngle = 130 / TO_RAD
        rjd.Initialize(torsos[0], upper_arms[0], new b2Vec2(startX - 20, startY + 18))
        world.CreateJoint(rjd)
        # upper arm to right shoulders
        rjd.lowerAngle = -130 / TO_RAD
        rjd.upperAngle =   85 / TO_RAD
        rjd.Initialize(torsos[0], upper_arms[1], new b2Vec2(startX + 20, startY + 18))
        world.CreateJoint(rjd)
        # left lower arm to upper arm
        rjd.lowerAngle = -130 / TO_RAD
        rjd.upperAngle =   10 / TO_RAD
        rjd.Initialize(upper_arms[0], lower_arms[0], new b2Vec2(startX - 20, startY + 45))
        world.CreateJoint(rjd)
        # right lower arm to upper arm
        rjd.lowerAngle = -10 / TO_RAD
        rjd.upperAngle = 130 / TO_RAD
        rjd.Initialize(upper_arms[1], lower_arms[1], new b2Vec2(startX + 20, startY + 45))
        world.CreateJoint(rjd)
        # shoulders / stomach
        rjd.lowerAngle = -15 / TO_RAD
        rjd.upperAngle =  15 / TO_RAD
        rjd.Initialize(torsos[0], torsos[1], new b2Vec2(startX, startY + 30))
        world.CreateJoint(rjd)
        # stomach / hips
        rjd.Initialize(torsos[1], torsos[2], new b2Vec2(startX, startY + 50))
        world.CreateJoint(rjd)
        # torso to left upper leg
        rjd.lowerAngle = -25 / TO_RAD
        rjd.upperAngle =  45 / TO_RAD
        rjd.Initialize(torsos[2], upper_legs[0], new b2Vec2(startX - 8, startY + 72))
        world.CreateJoint(rjd)
        # torso to right upper leg
        rjd.lowerAngle = -45 / TO_RAD
        rjd.upperAngle =  25 / TO_RAD
        rjd.Initialize(torsos[2], upper_legs[1], new b2Vec2(startX + 8, startY + 72))
        world.CreateJoint(rjd)
        # left upper leg to lower leg
        rjd.lowerAngle = -25 / TO_RAD
        rjd.upperAngle = 115 / TO_RAD
        rjd.Initialize(upper_legs[0], lower_legs[0], new b2Vec2(startX - 8, startY + 105))
        world.CreateJoint(rjd)
        # right upper leg to lower leg
        rjd.lowerAngle = -115 / TO_RAD
        rjd.upperAngle =   25 / TO_RAD
        rjd.Initialize(upper_legs[1], lower_legs[1], new b2Vec2(startX + 8, startY + 105))
        world.CreateJoint(rjd)
    # stairs
    params = {
        height : 20
        friction : .4
        restitution : .3
    }
    # stairs on the left
    for i in [1..10]
        params['name'] = "left stair #{i}"
        params['x'] = 10 + 10 * i
        params['y'] = 260 + 20 * i
        params['width'] = 20 * i
        addBody params
    # stairs on the right
    for i in [1..10]
        params['name'] = "right stair #{i}"
        params['x'] = 630 - 10 * i
        params['y'] = 260 + 20 * i
        params['width'] = 20 * i
        addBody params
    # separator
    addBody {
        x : 320
        y : 420
        width : 50
        height : 100
        friction : .4
        restitution : .3
    }
