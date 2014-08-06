
b2World.prototype.DebugDraw = function () {
    var item, shape;
    this.ctx.clearRect(0, 0, this.ctx.width, this.ctx.height);
    for (item = world.m_jointList; item; item = item.m_next) {
        this._drawJoint(item);
    }
    for (item = world.m_bodyList; item; item = item.m_next) {
        for (shape = item.GetShapeList(); shape != null; shape = shape.GetNext()) {
            this._drawShape(shape);
        }
    }
};

b2World.prototype.SetDebugDraw = function (params) {
    params = params || {};
    this.ctx = params.ctx; 
    this.ctx.width = params.width; 
    this.ctx.height = params.height;
};

b2World.prototype._drawJoint = function (joint) {
    var b1 = joint.m_body1,
        b2 = joint.m_body2,
        x1 = b1.m_position,
        x2 = b2.m_position,
        p1 = joint.GetAnchor1(),
        p2 = joint.GetAnchor2();
    this.ctx.strokeStyle = '#ffffff';
    this.ctx.beginPath();
    switch (joint.m_type) {
        case b2Joint.e_distanceJoint:
            this.ctx.moveTo(p1.x, p1.y);
            this.ctx.lineTo(p2.x, p2.y);
            break;

        case b2Joint.e_pulleyJoint:
            // TODO
            break;

        default:
            if (b1 == world.m_groundBody) {
                this.ctx.moveTo(p1.x, p1.y);
                this.ctx.lineTo(x2.x, x2.y);
            }
            else if (b2 == world.m_groundBody) {
                this.ctx.moveTo(p1.x, p1.y);
                this.ctx.lineTo(x1.x, x1.y);
            }
            else {
                this.ctx.moveTo(x1.x, x1.y);
                this.ctx.lineTo(p1.x, p1.y);
                this.ctx.lineTo(x2.x, x2.y);
                this.ctx.lineTo(p2.x, p2.y);
            }
            break;
    }
    this.ctx.stroke();
};

b2World.prototype._drawShape = function (shape) {
    var i, v, tV, pos, r, segments, theta, dtheta, d, ax;
    this.ctx.strokeStyle = 'rgba(255,255,255,.75)';
    this.ctx.fillStyle = 'rgba(255,255,255,.33)';
    this.ctx.beginPath();
    switch (shape.m_type) {
        case b2Shape.e_circleShape:
            pos = shape.m_position;
            r = shape.m_radius;
            segments = 16.0;
            theta = 0.0;
            dtheta = 2.0 * Math.PI / segments;
            // draw circle
            this.ctx.moveTo(pos.x + r, pos.y);
            for (i = 0; i < segments; i++) {
                d = new b2Vec2(r * Math.cos(theta), r * Math.sin(theta));
                v = b2Math.AddVV(pos, d);
                this.ctx.lineTo(v.x, v.y);
                theta += dtheta;
            }
            this.ctx.lineTo(pos.x + r, pos.y);
            // draw radius
            this.ctx.moveTo(pos.x, pos.y);
            ax = shape.m_R.col1;
            pos = new b2Vec2(pos.x + r * ax.x, pos.y + r * ax.y);
            this.ctx.lineTo(pos.x, pos.y);
            break;
        case b2Shape.e_polyShape:
            tV = b2Math.AddVV(
                shape.m_position,
                b2Math.b2MulMV(shape.m_R, shape.m_vertices[0])
            );
            this.ctx.moveTo(tV.x, tV.y);
            for (i = 0; i < shape.m_vertexCount; i++) {
                v = b2Math.AddVV(
                    shape.m_position,
                    b2Math.b2MulMV(shape.m_R, shape.m_vertices[i])
                );
                this.ctx.lineTo(v.x, v.y);
            }
            this.ctx.lineTo(tV.x, tV.y);
            break;
    }
    this.ctx.stroke();
    this.ctx.fill();
};
