
world = null

initBox2d = ->
    aabb = new b2AABB
    aabb.minVertex.Set(0, 0)
    aabb.maxVertex.Set(640, 480)
    window.world = new b2World(aabb, new b2Vec2(0, 300), true)

initDraw = ->
    canvas = document.getElementById 'canvas'
    canvas.addEventListener 'mousedown', mouseDown
    canvas.addEventListener 'mouseup', mouseUp
    canvas.addEventListener 'mousemove', mouseMove
    ctx = canvas.getContext('2d')
    window.world.SetDebugDraw({
        ctx : ctx
        width : 640
        height : 480
    })

mouseDown = (e) ->
    mouseX = (e.clientX - (@.offsetLeft - @.scrollLeft))
    mouseY = (e.clientY - (@.offsetTop - @.scrollTop))
    worldPoint = new b2Vec2(mouseX, mouseY)
    world = window.world
    joint = world.m_jointList
    while joint = joint.m_next
        if joint.m_userData is 'mouseJoint'
            return
    world.QueryPoint( (body) ->
        jointDef = new b2MouseJointDef
        jointDef.body1 = world.GetGroundBody()
        jointDef.body2 = body
        jointDef.target = worldPoint
        jointDef.maxForce = 10000 * body.GetMass()
        mouseJoint = world.CreateJoint(jointDef)
        mouseJoint.m_userData = 'mouseJoint'
    , worldPoint)

mouseUp = (e) ->
    mouseX = (e.clientX - (@.offsetLeft - @.scrollLeft))
    mouseY = (e.clientY - (@.offsetTop - @.scrollTop))
    worldPoint = new b2Vec2(mouseX, mouseY)
    world = window.world
    joint = world.m_jointList
    while joint = joint.m_next
        if joint.m_userData is 'mouseJoint'
            world.DestroyJoint joint
            joint = null
            return

mouseMove = (e) ->
    mouseX = (e.clientX - (@.offsetLeft - @.scrollLeft))
    mouseY = (e.clientY - (@.offsetTop - @.scrollTop))
    worldPoint = new b2Vec2(mouseX, mouseY)
    world = window.world
    joint = world.m_jointList
    while joint = joint.m_next
        if joint.m_userData is 'mouseJoint'
            joint.SetTarget worldPoint
            return

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

bodies = ->
    # square
    addBody({
        name : 'square'
        x : 260
        y : 50,
        width : 30
        height : 30
        friction : .2
        #restitution : ,
        density : 1
    })
    # circle
    addBody({
        name : 'circle'
        x : 370
        y : 100
        radius: 15
        friction : .2
        restitution : .2
        density : 2
    })
    # static triangle
    tri = addBody({
        name : 'static triangle'
        x : 320
        y : 300
        points: [[0, 0], [100, 100], [-100, 125]]
        friction : .1
        #restitution : ,
        density : .25
    })
    jointDef = new b2RevoluteJointDef
    jointDef.body1 = tri;
    jointDef.body2 = window.world.GetGroundBody()
    jointDef.anchorPoint = tri.m_position
    window.world.CreateJoint(jointDef)

animate = ->
    window.world.Step(1 / 60, 4)
    window.world.DebugDraw()
    requestAnimationFrame animate

window.onload = ->
    initBox2d()
    initDraw()
    ground()
    bodies()
    animate()
