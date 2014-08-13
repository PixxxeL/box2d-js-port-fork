
stack = ->
    world = window.world
    ground = world.GetGroundBody()
    # 3 x 10 stacks
    for i in [0..29]
        addBody({
            name : "box #{i + 1}"
            x : 320 + 100 * (i / 10 | 0)
            y : 480 - 5 - (1 + i % 10) * 25
            width : 20
            height : 20
            friction : .5
            restitution : .1
            density : 1
        })
    # ramp
    addBody({
        name : 'ramp'
        x : 10
        y : 470
        points : [[0, 0], [0, -100], [200, 0]]
        friction : .5
        restitution : .1
    })
    # ball
    addBody({
        name : 'ball'
        x : 60
        y : 100
        radius : 40
        friction : .5
        restitution : .2
        density : 3
    })
    return 'Stacked Boxes'
