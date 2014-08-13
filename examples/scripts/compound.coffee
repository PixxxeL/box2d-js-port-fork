
_compoundPoly = (i) ->
    ###
    var points = [[-30, 0], [30, 0], [0, 15]];
    var polySd1 = new b2PolyDef();
    polySd1.vertexCount = points.length;
    for (var i = 0; i < points.length; i++) {
        polySd1.vertices[i].Set(points[i][0], points[i][1]);
    }
    polySd1.localRotation = 0.3524 * Math.PI;
    var R1 = new b2Mat22(polySd1.localRotation);
    polySd1.localPosition = b2Math.b2MulMV(R1, new b2Vec2(30, 0));
    polySd1.density = 1.0;
    var polySd2 = new b2PolyDef();
    polySd2.vertexCount = points.length;
    for (var i = 0; i < points.length; i++) {
        polySd2.vertices[i].Set(points[i][0], points[i][1]);
    }
    polySd2.localRotation = -0.3524 * Math.PI;
    var R2 = new b2Mat22(polySd2.localRotation);
    polySd2.localPosition = b2Math.b2MulMV(R2, new b2Vec2(-30, 0));
    var polyBd = new b2BodyDef();
    polyBd.AddShape(polySd1);
    polyBd.AddShape(polySd2);
    polyBd.position.Set(x,y);
    ###

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

_compoundBasket = ->

compound = ->
    for i in [0..4]
        world.CreateBody(_compoundRect(i))
    _compoundBasket()
    #for i in [0..4]
    #    world.CreateBody(_compoundPoly(i))
    for i in [0..4]
        world.CreateBody(_compoundCircle(i))



###
var bd:b2BodyDef;
var body:b2Body;
var i:int;
var x:Number;
{
    var xf1:b2Transform = new b2Transform();
    xf1.R.Set(0.3524 * Math.PI);
    xf1.position = b2Math.MulMV(xf1.R, new b2Vec2(1.0, 0.0));
    
    var sd1:b2PolygonShape = new b2PolygonShape();
    sd1.SetAsArray([
        b2Math.MulX(xf1, new b2Vec2(-30.0/m_physScale, 0.0)),
        b2Math.MulX(xf1, new b2Vec2(30.0/m_physScale, 0.0)),
        b2Math.MulX(xf1, new b2Vec2(0.0, 15.0 / m_physScale)),
        ]);
    
    var xf2:b2Transform = new b2Transform();
    xf2.R.Set(-0.3524 * Math.PI);
    xf2.position = b2Math.MulMV(xf2.R, new b2Vec2(-30.0/m_physScale, 0.0));
    
    var sd2:b2PolygonShape = new b2PolygonShape();
    sd2.SetAsArray([
        b2Math.MulX(xf2, new b2Vec2(-30.0/m_physScale, 0.0)),
        b2Math.MulX(xf2, new b2Vec2(30.0/m_physScale, 0.0)),
        b2Math.MulX(xf2, new b2Vec2(0.0, 15.0 / m_physScale)),
        ]);
    
    bd = new b2BodyDef();
    bd.type = b2Body.b2_dynamicBody;
    bd.fixedRotation = true;
    
    for (i = 0; i < 5; ++i)
    {
        x = 320.0 + b2Math.RandomRange(-3.0, 3.0);
        bd.position.Set(x/m_physScale, (-61.5 + 55.0 * -i + 300)/m_physScale);
        bd.angle = 0.0;
        body = m_world.CreateBody(bd);
        body.CreateFixture2(sd1, 2.0);
        body.CreateFixture2(sd2, 2.0);
    }
}

{
    var sd_bottom:b2PolygonShape = new b2PolygonShape();
    sd_bottom.SetAsBox( 45.0/m_physScale, 4.5/m_physScale );
    
    var sd_left:b2PolygonShape = new b2PolygonShape();
    sd_left.SetAsOrientedBox(4.5/m_physScale, 81.0/m_physScale, new b2Vec2(-43.5/m_physScale, -70.5/m_physScale), -0.2);
    
    var sd_right:b2PolygonShape = new b2PolygonShape();
    sd_right.SetAsOrientedBox(4.5/m_physScale, 81.0/m_physScale, new b2Vec2(43.5/m_physScale, -70.5/m_physScale), 0.2);
    
    bd = new b2BodyDef();
    bd.type = b2Body.b2_dynamicBody;
    bd.position.Set( 320.0/m_physScale, 300.0/m_physScale );
    body = m_world.CreateBody(bd);
    body.CreateFixture2(sd_bottom, 4.0);
    body.CreateFixture2(sd_left, 4.0);
    body.CreateFixture2(sd_right, 4.0);
}
###
