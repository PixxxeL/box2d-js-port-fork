
fps = null

TO_RAD = 180 / Math.PI

class Fps
    constructor: (@fpsEl) ->
        @lastTime = +new Date
        @frameTime = 0
        @frame = 0
    render: ->
        now = +new Date
        elapsed = now - @lastTime
        @frameTime += (elapsed - @frameTime) / 20
        if not (@frame % 60) and @frameTime > 5
            @fpsEl.innerHTML = (1000 / @frameTime) | 0
        @lastTime = now
        @frame++

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
        for p, i in points
            shapeDef.vertices[i].Set(p[0], p[1])
        bodyDef.AddShape(shapeDef)
    else
        shapeDef = new b2BoxDef
        shapeDef.extents.Set(
            (toInt(width) || 30) * .5,
            (toInt(height) || 30) * .5
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
    return body

ground = ->
    # floor
    addBody({
        name : 'floor'
        x : 320
        y : 475
        width : 640
        height : 10
        friction : .1
        density : 0
    })
    # ceiling
    addBody({
        name : 'ceiling'
        x : 320
        y : 5
        width : 640
        height : 10
        friction : .1
        density : 0
    })
    # left wall
    addBody({
        name : 'left wall'
        x : 5
        y : 240
        width : 10
        height : 480
        friction : .1
        density : 0
    })
    # right wall
    addBody({
        name : 'right wall'
        x : 635
        y : 240
        width : 10
        height : 480
        friction : .1
        density : 0
    })

toInt = (value) ->
    parseInt(value, 10) or 0
