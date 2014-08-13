
_compoundCircle = (i) ->
    radius = 15
    bodyDef = new b2BodyDef
    circle = new b2CircleDef
    circle.density = 1
    circle.radius = radius
    circle.restitution = .2
    circle.localPosition.Set(-radius, 0)
    bodyDef.AddShape(circle)
    circle = new b2CircleDef
    circle.density = 1
    circle.radius = radius
    circle.restitution = .2
    circle.localPosition.Set(radius, 0)
    bodyDef.AddShape(circle)
    bodyDef.position.Set(Math.random() * radius * 2 + 480, 380 - i * radius * 2)
    bodyDef.rotation = Math.random() * Math.PI * 2 - Math.PI
    return bodyDef

_compoundRect = (i) ->
    width = 15
    height = 30
    bodyDef = new b2BodyDef
    shapeDef = new b2BoxDef
    shapeDef.density = 1
    shapeDef.extents.Set(width * .5, height * .5)
    shapeDef.restitution = .2
    shapeDef.localPosition.Set(-15, 0)
    shapeDef.localRotation = Math.PI * .5
    bodyDef.AddShape(shapeDef)
    shapeDef = new b2BoxDef
    shapeDef.density = 1
    shapeDef.extents.Set(width * .5, height * .5)
    shapeDef.restitution = .2
    bodyDef.AddShape(shapeDef)
    bodyDef.position.Set(Math.random() * height + 150, 380 - i * height)
    bodyDef.rotation = Math.random() * Math.PI * 2 - Math.PI
    return bodyDef

_compoundPoly = (i) ->
    bodyDef = new b2BodyDef
    points = [[-30, 0], [30, 0], [0, 15]]
    shapeDef = new b2PolyDef
    shapeDef.vertexCount = points.length
    for p, j in points
        shapeDef.vertices[j].Set(p[0], p[1])
    shapeDef.density = 1
    shapeDef.localRotation = .3524 * Math.PI
    r = new b2Mat22(shapeDef.localRotation)
    shapeDef.localPosition = b2Math.b2MulMV(r, new b2Vec2(30, 0))
    bodyDef.AddShape(shapeDef)
    shapeDef = new b2PolyDef
    shapeDef.vertexCount = points.length
    for p, j in points
        shapeDef.vertices[j].Set(p[0], p[1])
    shapeDef.density = 1
    shapeDef.localRotation = -.3524 * Math.PI
    r = new b2Mat22(shapeDef.localRotation)
    shapeDef.localPosition = b2Math.b2MulMV(r, new b2Vec2(-30, 0))
    bodyDef.AddShape(shapeDef)
    bodyDef.position.Set(320, 360 - 40 * i)
    return bodyDef

_compoundBasket = ->
    bodyDef = new b2BodyDef
    shapeDef = new b2BoxDef
    shapeDef.density = 4
    shapeDef.extents.Set(45, 4.5)
    bodyDef.AddShape(shapeDef)
    shapeDef = new b2BoxDef
    shapeDef.density = 4
    shapeDef.extents.Set(4.5, 81)
    shapeDef.localPosition.Set(-43.5, -70.5)
    shapeDef.localRotation = -.2
    bodyDef.AddShape(shapeDef)
    shapeDef = new b2BoxDef
    shapeDef.density = 4
    shapeDef.extents.Set(4.5, 81)
    shapeDef.localPosition.Set(43.5, -70.5)
    shapeDef.localRotation = .2
    bodyDef.AddShape(shapeDef)
    bodyDef.position.Set(320, 440)
    return bodyDef

compound = ->
    for i in [0..4]
        world.CreateBody(_compoundRect(i))
    world.CreateBody(_compoundBasket())
    for i in [0..4]
        world.CreateBody(_compoundPoly(i))
    for i in [0..4]
        world.CreateBody(_compoundCircle(i))
    return 'Compound Shapes'
