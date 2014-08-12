
world = null
fps = null

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
    fps = new Fps document.getElementById 'fps-value'

mouseDown = (e) ->
    world = window.world
    joint = world.m_jointList
    while joint
        if joint.m_userData is 'mouseJoint'
            return
        joint = joint.m_next
    mouseX = (e.clientX - (@.offsetLeft - @.scrollLeft))
    mouseY = (e.clientY - (@.offsetTop - @.scrollTop))
    worldPoint = new b2Vec2(mouseX, mouseY)
    world.QueryPoint( (body) ->
        mass = body.GetMass()
        if not mass
            return
        jointDef = new b2MouseJointDef
        jointDef.body1 = world.GetGroundBody()
        jointDef.body2 = body
        jointDef.target = worldPoint
        jointDef.maxForce = 10000 * mass
        jointDef.collideConnected = true
        mouseJoint = world.CreateJoint(jointDef)
        mouseJoint.m_userData = 'mouseJoint'
    , worldPoint)

mouseUp = (e) ->
    world = window.world
    joint = world.m_jointList
    while joint
        if joint.m_userData is 'mouseJoint'
            world.DestroyJoint joint
            joint = null
            return
        joint = joint.m_next

mouseMove = (e) ->
    mouseX = (e.clientX - (@.offsetLeft - @.scrollLeft))
    mouseY = (e.clientY - (@.offsetTop - @.scrollTop))
    worldPoint = new b2Vec2(mouseX, mouseY)
    world = window.world
    joint = world.m_jointList
    while joint
        if joint.m_userData is 'mouseJoint'
            joint.SetTarget worldPoint
            return
        joint = joint.m_next

bodies = ->
    #simple()
    #ragdoll()
    #crankGearsPulley()
    #bridge()
    #stack()
    walker()

animate = ->
    fps.render()
    window.world.Step(1 / 60, 4)
    window.world.DebugDraw()
    requestAnimationFrame animate

window.onload = ->
    initBox2d()
    initDraw()
    ground()
    bodies()
    animate()
