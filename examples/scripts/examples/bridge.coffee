
bridge = ->
    world = window.world
    ground = world.GetGroundBody()
    rjd = new b2RevoluteJointDef
    rjd.lowerAngle = -15 / TO_RAD
    rjd.upperAngle =  15 / TO_RAD
    rjd.enableLimit = true
    prevBody = ground
    # bridge
    for i in [0..9]
        body = addBody({
            name : "plank #{i + 1}"
            x : 122 + 44 * i
            y : 250
            width : 48
            height : 10
            density : 20
            friction : .2
        })
        rjd.Initialize(prevBody, body, new b2Vec2(100 + 44 * i, 250))
        world.CreateJoint(rjd)
        prevBody = body
    rjd.Initialize(prevBody, ground, new b2Vec2(100 + 44 * 10, 250))
    world.CreateJoint(rjd)
    # span boxes
    for i in [0..4]
        addBody({
            name : "box #{i + 1}"
            x : Math.random() * 400 + 120
            y : Math.random() * 150 + 50
            width : Math.random() * 10 + 20
            height : Math.random() * 10 + 20
            density : 1
            friction : .3
            restitution : .1
        })
    # span circles
    for i in [0..4]
        addBody({
            name : "circle #{i + 1}"
            x : Math.random() * 400 + 120
            y : Math.random() * 150 + 50
            radius : Math.random() * 5 + 10
            density : 1
            friction : .3
            restitution : .1
        })
    # span polygons
    for i in [0..14]
        if Math.random() > .66
            points = [
                [-10 - Math.random() * 10,  10 + Math.random() * 10]
                [ -5 - Math.random() * 10, -10 - Math.random() * 10]
                [  5 + Math.random() * 10, -10 - Math.random() * 10]
                [ 10 + Math.random() * 10,  10 + Math.random() * 10]
            ]
        else if Math.random() > .5
            pm = Math.random() * .5 + .8
            p0 = [0, 10 + Math.random() * 10]
            p2 = [-5 - Math.random() * 10, -10 - Math.random() * 10]
            p3 = [ 5 + Math.random() * 10, -10 - Math.random() * 10]
            p1 = [(p0[0] + p2[0]) * pm, (p0[1] + p2[1]) * pm]
            p4 = [(p3[0] + p0[0]) * pm, (p3[1] + p0[1]) * pm]
            points = [p0, p1, p2, p3, p4]
        else
            points = [
                [0, 10 + Math.random() * 10]
                [-5 - Math.random() * 10, -10 - Math.random() * 10]
                [ 5 + Math.random() * 10, -10 - Math.random() * 10]
            ]
        addBody({
            name : "polygon #{i + 1}"
            x : Math.random() * 400 + 120
            y : Math.random() * 150 + 50
            points : points
            density : 1
            friction : .3
            restitution : .1
            rotation : Math.random() * Math.PI
        })
    return 'Bridge'
