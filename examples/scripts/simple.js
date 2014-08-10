// Generated by CoffeeScript 1.7.1
var simple;

simple = function() {
  var jointDef, tri;
  addBody({
    name: 'square',
    x: 260,
    y: 50,
    width: 30,
    height: 30,
    friction: .2,
    density: 1
  });
  addBody({
    name: 'circle',
    x: 370,
    y: 100,
    radius: 15,
    friction: .2,
    restitution: .2,
    density: 2
  });
  tri = addBody({
    name: 'static triangle',
    x: 320,
    y: 300,
    points: [[0, 0], [100, 100], [-100, 125]],
    friction: .1,
    density: .25
  });
  jointDef = new b2RevoluteJointDef;
  jointDef.body1 = tri;
  jointDef.body2 = window.world.GetGroundBody();
  jointDef.anchorPoint = tri.m_position;
  window.world.CreateJoint(jointDef);
};
