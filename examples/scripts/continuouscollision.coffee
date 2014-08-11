###
var bd:b2BodyDef;
var body:b2Body;
var fixtureDef:b2FixtureDef = new b2FixtureDef();
// These values are used for all the parts of the 'basket'
fixtureDef.density = 4.0; 
fixtureDef.restitution = 1.4;

// Create 'basket'
{
    bd = new b2BodyDef();
    bd.type = b2Body.b2_dynamicBody;
    bd.bullet = true;
    bd.position.Set( 150.0/m_physScale, 100.0/m_physScale );
    body = m_world.CreateBody(bd);
    var sd_bottom:b2PolygonShape = new b2PolygonShape();
    sd_bottom.SetAsBox( 45.0 / m_physScale, 4.5 / m_physScale );
    fixtureDef.shape = sd_bottom;
    body.CreateFixture( fixtureDef );
    
    var sd_left:b2PolygonShape = new b2PolygonShape();
    sd_left.SetAsOrientedBox(4.5/m_physScale, 81.0/m_physScale, new b2Vec2(-43.5/m_physScale, -70.5/m_physScale), -0.2);
    fixtureDef.shape = sd_left;
    body.CreateFixture( fixtureDef );
    
    var sd_right:b2PolygonShape = new b2PolygonShape();
    sd_right.SetAsOrientedBox(4.5/m_physScale, 81.0/m_physScale, new b2Vec2(43.5/m_physScale, -70.5/m_physScale), 0.2);
    fixtureDef.shape = sd_right;
    body.CreateFixture( fixtureDef );
}

// add some small circles for effect
for (var i:int = 0; i < 5; i++){
    var cd:b2CircleShape = new b2CircleShape((Math.random() * 10 + 5) / m_physScale);
    fixtureDef.shape = cd;
    fixtureDef.friction = 0.3;
    fixtureDef.density = 1.0;
    fixtureDef.restitution = 1.1;
    bd = new b2BodyDef();
    bd.type = b2Body.b2_dynamicBody;
    bd.bullet = true;
    bd.position.Set( (Math.random()*300 + 250)/m_physScale, (Math.random()*320 + 20)/m_physScale );
    body = m_world.CreateBody(bd);
    body.CreateFixture(fixtureDef);
}
###
