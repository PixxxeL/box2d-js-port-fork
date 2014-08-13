
simple = ->
    world = window.world
    # squares
    addBody({
        name : 'square 1'
        x : 260
        y : 50,
        width : 30
        height : 30
        friction : .2
        density : 1
    })
    addBody({
        name : 'square 2'
        x : 500
        y : 75,
        width : 30
        height : 30
        friction : .2
        density : 3
    })
    # circles
    addBody({
        name : 'circle 1'
        x : 370
        y : 100
        radius: 15
        friction : .2
        restitution : .2
        density : 2
    })
    addBody({
        name : 'circle 2'
        x : 130
        y : 75
        radius: 15
        friction : .2
        restitution : .2
        density : 2
    })
    # static triangle
    tri = addBody({
        name : 'static triangle'
        x : 320
        y : 380
        points: [[0, 0], [100, 50], [-100, 75]]
        friction : .1
        density : .25
    })
    rjd = new b2RevoluteJointDef
    rjd.body1 = tri
    rjd.body2 = window.world.GetGroundBody()
    rjd.anchorPoint = tri.m_position
    world.CreateJoint(rjd)
    # static square
    square = addBody({
        name : 'static square'
        x : 160
        y : 300,
        width : 100
        height : 100
        friction : .5
        density : 10
    })
    rjd.body1 = square
    rjd.anchorPoint = square.GetCenterPosition()
    world.CreateJoint(rjd)
    # static circle
    circle = addBody({
        name : 'static circle'
        x : 480
        y : 320,
        radius : 50
        friction : .75
        density : 1
    })
    rjd.body1 = circle
    rjd.anchorPoint = circle.GetCenterPosition()
    world.CreateJoint(rjd)
    return
