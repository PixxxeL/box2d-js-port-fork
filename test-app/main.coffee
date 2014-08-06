
world = null
ctx = null

initBox2d = ->
    aabb = new b2AABB
    aabb.minVertex.Set(0, 0)
    aabb.maxVertex.Set(640, 480)
    window.world = new b2World(aabb, new b2Vec2(0, 300), true)

initDraw = ->
    canvas = document.getElementById 'canvas'
    window.ctx = canvas.getContext('2d')

addBody = (params) ->
    params ||= {}
    x = params.x or 0
    y = params.y or 0
    width = params.width
    height = params.height
    radius = params.radius
    points = params.points
    rotation = params.rotation
    bodyDef = new b2BodyDef
    if radius
        shapeDef = new b2CircleDef
        shapeDef.radius = radius || 15
        bodyDef.AddShape(shapeDef)
    else if points
        shapeDef = new b2PolyDef
        shapeDef.vertexCount = points.length
        for p in points
            shapeDef.vertices[i].Set(p[0], p[1])
        bodyDef.AddShape(shapeDef)
    else
        shapeDef = new b2BoxDef
        shapeDef.extents.Set(
            (parseInt(width, 10) || 30) * .5,
            (parseInt(height, 10) || 30) * .5
        );
        bodyDef.AddShape(shapeDef)
    if rotation
        shapeDef.localRotation = rotation
    shapeDef.density = params.density || 0
    shapeDef.friction = params.friction || 0
    shapeDef.restitution = params.restitution || 0
    bodyDef.position.Set(x, y)
    body = world.CreateBody(bodyDef);
    body.m_userData =
        name : params.name,
        additional : params.additional || {}

ground = ->
    console.log 'ground'

bodies = ->
    console.log 'bodies'

animate = ->
    window.world.Step(1 / 60, 4)
    window.world.DebugDraw(window.ctx)
    requestAnimationFrame animate

window.onload = ->
    initBox2d()
    initDraw()
    ground()
    bodies()
    animate()
