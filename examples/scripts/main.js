// Generated by CoffeeScript 1.7.1
var animate, cleanup, current, fps, getExamples, initBox2d, initDraw, initWorld, keyDown, mouseDown, mouseMove, mouseUp, setCurrentExampleIndex, world;

world = null;

fps = null;

current = 0;

initBox2d = function() {
  var aabb;
  aabb = new b2AABB;
  aabb.minVertex.Set(0, 0);
  aabb.maxVertex.Set(640, 480);
  return window.world = new b2World(aabb, new b2Vec2(0, 300), true);
};

initDraw = function() {
  var canvas, ctx;
  canvas = document.getElementById('canvas');
  canvas.addEventListener('mousedown', mouseDown);
  canvas.addEventListener('mouseup', mouseUp);
  canvas.addEventListener('mousemove', mouseMove);
  window.addEventListener('keydown', keyDown);
  ctx = canvas.getContext('2d');
  window.world.SetDebugDraw({
    ctx: ctx,
    width: 640,
    height: 480
  });
  return fps = new Fps(document.getElementById('fps-value'));
};

initWorld = function() {
  initBox2d();
  initDraw();
  ground();
  return getExamples()[current]();
};

cleanup = function() {
  canvas.removeEventListener('mousedown', mouseDown);
  canvas.removeEventListener('mouseup', mouseUp);
  canvas.removeEventListener('mousemove', mouseMove);
  return window.removeEventListener('keydown', keyDown);
};

mouseDown = function(e) {
  var joint, mouseX, mouseY, worldPoint;
  world = window.world;
  joint = world.m_jointList;
  while (joint) {
    if (joint.m_userData === 'mouseJoint') {
      return;
    }
    joint = joint.m_next;
  }
  mouseX = e.clientX - (this.offsetLeft - this.scrollLeft);
  mouseY = e.clientY - (this.offsetTop - this.scrollTop);
  worldPoint = new b2Vec2(mouseX, mouseY);
  return world.QueryPoint(function(body) {
    var jointDef, mass, mouseJoint;
    mass = body.GetMass();
    if (!mass) {
      return;
    }
    jointDef = new b2MouseJointDef;
    jointDef.body1 = world.GetGroundBody();
    jointDef.body2 = body;
    jointDef.target = worldPoint;
    jointDef.maxForce = 10000 * mass;
    jointDef.collideConnected = true;
    mouseJoint = world.CreateJoint(jointDef);
    return mouseJoint.m_userData = 'mouseJoint';
  }, worldPoint);
};

mouseUp = function(e) {
  var joint;
  world = window.world;
  joint = world.m_jointList;
  while (joint) {
    if (joint.m_userData === 'mouseJoint') {
      world.DestroyJoint(joint);
      joint = null;
      return;
    }
    joint = joint.m_next;
  }
};

mouseMove = function(e) {
  var joint, mouseX, mouseY, worldPoint;
  mouseX = e.clientX - (this.offsetLeft - this.scrollLeft);
  mouseY = e.clientY - (this.offsetTop - this.scrollTop);
  worldPoint = new b2Vec2(mouseX, mouseY);
  world = window.world;
  joint = world.m_jointList;
  while (joint) {
    if (joint.m_userData === 'mouseJoint') {
      joint.SetTarget(worldPoint);
      return;
    }
    joint = joint.m_next;
  }
};

keyDown = function(e) {
  if (e.keyCode === 37) {
    setCurrentExampleIndex(-1);
    return initWorld();
  } else if (e.keyCode === 39) {
    setCurrentExampleIndex(1);
    return initWorld();
  } else if (e.keyCode === 82) {
    return initWorld();
  }
};

getExamples = function() {
  return [ragdoll, crankGearsPulley, bridge, stack, pendulum];
};

setCurrentExampleIndex = function(step) {
  var len;
  len = getExamples().length - 1;
  if (step) {
    current += step;
  }
  if (current > len) {
    return current = 0;
  } else if (current < 0) {
    return current = len;
  }
};

animate = function() {
  if (!fps || !world) {
    return;
  }
  fps.render();
  world.Step(1 / 60, 4);
  world.DebugDraw();
  return requestAnimationFrame(animate);
};

window.onload = function() {
  initWorld();
  return animate();
};
