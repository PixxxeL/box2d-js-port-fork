
world = null
fps = null
title = null
current = 0

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
    window.addEventListener 'keydown', keyDown
    ctx = canvas.getContext('2d')
    window.world.SetDebugDraw({
        ctx : ctx
        width : 640
        height : 480
    })
    fps = new Fps document.getElementById 'fps-value'

initWorld = ->
    cleanup()
    initBox2d()
    initDraw()
    ground()
    scene = getExamples()[current]
    document.getElementById('title-container').innerHTML = scene()

cleanup = ->
    canvas.removeEventListener 'mousedown', mouseDown
    canvas.removeEventListener 'mouseup', mouseUp
    canvas.removeEventListener 'mousemove', mouseMove
    window.removeEventListener 'keydown', keyDown

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

keyDown = (e) ->
    if e.keyCode is 37 # ←
        setCurrentExampleIndex(-1)
        initWorld()
    else if e.keyCode is 39 # →
        setCurrentExampleIndex(1)
        initWorld()
    else if e.keyCode is 82 # R
        initWorld()
    else if e.keyCode is 83 # S
        addBody({
            name : "square #{Math.random() * 100000 | 0}"
            x : Math.random() * 580 + 30
            y : Math.random() * 70 + 30,
            width : 30
            height : 30
            friction : .2
            density : 1
        })
    else if e.keyCode is 67 # C
        addBody({
            name : "circle #{Math.random() * 100000 | 0}"
            x : Math.random() * 580 + 30
            y : Math.random() * 70 + 30
            radius: 15
            friction : .2
            restitution : .2
            density : 2
        })

getExamples = ->
    return [
        ragdoll
        compound
        crankGearsPulley
        bridge
        stack
        pendulum
        simple
    ]

setCurrentExampleIndex = (step) ->
    len = getExamples().length - 1
    if step
        current += step
    if current > len
        current = 0
    else if current < 0
        current = len

animate = ->
    if not fps or not world
        return
    fps.render()
    world.Step(1 / 60, 4)
    world.DebugDraw()
    requestAnimationFrame animate

window.onload = ->
    initWorld()
    animate()
