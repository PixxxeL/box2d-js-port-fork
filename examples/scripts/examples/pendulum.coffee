
pendulum = ->
    world = window.world
    ground = world.GetGroundBody()
    rjd = new b2RevoluteJointDef
    len = 150
    for i in [0..3]
        rjd.anchorPoint.Set(250 + 40 * i, 200 - len)
        rjd.body1 = ground
        rjd.body2 = addBody({
            name : "ball #{i + 1}"
            x : 250 + 40 * i
            y : 200
            radius : 20
            friction : .1
            restitution : 1
            density : 1
        })
        world.CreateJoint(rjd)
    rjd.anchorPoint.Set(250 - 40, 200 - len)
    rjd.body1 = ground
    rjd.body2 = addBody({
        name : "ball 5"
        x : 250 - 40 - len
        y : 200 - len
        radius : 20
        friction : .1
        restitution : 1
        density : 1
    })
    world.CreateJoint(rjd)
    return 'Pendulum'
