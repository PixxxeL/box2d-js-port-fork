// Generated by CoffeeScript 1.7.1
var Fps, TO_RAD, addBody, fps, ground, toInt;

fps = null;

TO_RAD = 180 / Math.PI;

Fps = (function() {
  function Fps(fpsEl) {
    this.fpsEl = fpsEl;
    this.lastTime = +(new Date);
    this.frameTime = 0;
    this.frame = 0;
  }

  Fps.prototype.render = function() {
    var elapsed, now;
    now = +(new Date);
    elapsed = now - this.lastTime;
    this.frameTime += (elapsed - this.frameTime) / 20;
    if (!(this.frame % 60) && this.frameTime > 5) {
      this.fpsEl.innerHTML = (1000 / this.frameTime) | 0;
    }
    this.lastTime = now;
    return this.frame++;
  };

  return Fps;

})();

addBody = function(params) {
  var body, bodyDef, height, i, p, points, radius, rotation, shapeDef, width, x, y, _i, _len;
  params || (params = {});
  x = params.x || 0;
  y = params.y || 0;
  width = params.width;
  height = params.height;
  radius = params.radius;
  points = params.points;
  rotation = params.rotation;
  bodyDef = new b2BodyDef;
  if (radius) {
    shapeDef = new b2CircleDef;
    shapeDef.radius = radius || 15;
    bodyDef.AddShape(shapeDef);
  } else if (points) {
    shapeDef = new b2PolyDef;
    shapeDef.vertexCount = points.length;
    for (i = _i = 0, _len = points.length; _i < _len; i = ++_i) {
      p = points[i];
      shapeDef.vertices[i].Set(p[0], p[1]);
    }
    bodyDef.AddShape(shapeDef);
  } else {
    shapeDef = new b2BoxDef;
    shapeDef.extents.Set((toInt(width) || 30) * .5, (toInt(height) || 30) * .5);
    bodyDef.AddShape(shapeDef);
  }
  if (rotation) {
    shapeDef.localRotation = rotation;
  }
  shapeDef.density = params.density || 0;
  shapeDef.friction = params.friction || 0;
  shapeDef.restitution = params.restitution || 0;
  bodyDef.position.Set(x, y);
  body = world.CreateBody(bodyDef);
  body.m_userData = {
    name: params.name,
    additional: params.additional || {}
  };
  return body;
};

ground = function() {
  addBody({
    name: 'floor',
    x: 320,
    y: 475,
    width: 640,
    height: 10,
    friction: .1,
    density: 0
  });
  addBody({
    name: 'ceiling',
    x: 320,
    y: 5,
    width: 640,
    height: 10,
    friction: .1,
    density: 0
  });
  addBody({
    name: 'left wall',
    x: 5,
    y: 240,
    width: 10,
    height: 480,
    friction: .1,
    density: 0
  });
  return addBody({
    name: 'right wall',
    x: 635,
    y: 240,
    width: 10,
    height: 480,
    friction: .1,
    density: 0
  });
};

toInt = function(value) {
  return parseInt(value, 10) || 0;
};
