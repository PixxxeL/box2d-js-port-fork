
continuousCollision = ->
    # create basket
    bodyDef = new b2BodyDef
    shapeDef = new b2BoxDef
    shapeDef.density = 4
    shapeDef.restitution = 1.4
    shapeDef.extents.Set(45, 4.5)
    bodyDef.AddShape(shapeDef)
    shapeDef = new b2BoxDef
    shapeDef.density = 4
    shapeDef.restitution = 1.4
    shapeDef.extents.Set(4.5, 81)
    shapeDef.localPosition.Set(-43.5, -70.5)
    shapeDef.localRotation = -.2
    bodyDef.AddShape(shapeDef)
    shapeDef = new b2BoxDef
    shapeDef.density = 4
    shapeDef.restitution = 1.4
    shapeDef.extents.Set(4.5, 81)
    shapeDef.localPosition.Set(43.5, -70.5)
    shapeDef.localRotation = .2
    #bodyDef.bullet = true
    bodyDef.AddShape(shapeDef)
    bodyDef.position.Set(320, 240)
    world.CreateBody(bodyDef)
    # add some small circles for effect
    for i in [0..4]
        addBody({
            name : "ball #{i + 1}"
            x : Math.random() * 300 + 250
            y : Math.random() * 320 + 20
            radius : Math.random() * 10 + 5
            friction : .3
            density : 1
            restitution : 1.1
            # need add bullet : true
        })
    return 'Continuous Collision Detection'
