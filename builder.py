
import os


VERBOSE_YUI = False
YUI_APP_PATH = os.path.join('d:\\', 'www', 'yuicompressor-2.4.8.jar')
SOURCE = ('origin', 'fork',)[1]
MIN_SUFF = 'min'
LIB_URL_PREFIX = os.path.join('src', '%s' % SOURCE)
RESULT_PATH = os.path.join(LIB_URL_PREFIX, 'box2d.js')
RESULT_MIN_PATH = os.path.join(LIB_URL_PREFIX, 'box2d.min.js')
LIBLIST = (
    'box2d/common/b2Settings.js',
    'box2d/common/math/b2Vec2.js',
    'box2d/common/math/b2Mat22.js',
    'box2d/common/math/b2Math.js',
    'box2d/collision/b2AABB.js',
    'box2d/collision/b2Bound.js',
    'box2d/collision/b2BoundValues.js',
    'box2d/collision/b2Pair.js',
    'box2d/collision/b2PairCallback.js',
    'box2d/collision/b2BufferedPair.js',
    'box2d/collision/b2PairManager.js',
    'box2d/collision/b2BroadPhase.js',
    'box2d/collision/b2Collision.js',
    'box2d/collision/Features.js',
    'box2d/collision/b2ContactID.js',
    'box2d/collision/b2ContactPoint.js',
    'box2d/collision/b2Distance.js',
    'box2d/collision/b2Manifold.js',
    'box2d/collision/b2OBB.js',
    'box2d/collision/b2Proxy.js',
    'box2d/collision/ClipVertex.js',
    'box2d/collision/shapes/b2Shape.js',
    'box2d/collision/shapes/b2ShapeDef.js',
    'box2d/collision/shapes/b2BoxDef.js',
    'box2d/collision/shapes/b2CircleDef.js',
    'box2d/collision/shapes/b2CircleShape.js',
    'box2d/collision/shapes/b2MassData.js',
    'box2d/collision/shapes/b2PolyDef.js',
    'box2d/collision/shapes/b2PolyShape.js',
    'box2d/dynamics/b2Body.js',
    'box2d/dynamics/b2BodyDef.js',
    'box2d/dynamics/b2CollisionFilter.js',
    'box2d/dynamics/b2Island.js',
    'box2d/dynamics/b2TimeStep.js',
    'box2d/dynamics/contacts/b2ContactNode.js',
    'box2d/dynamics/contacts/b2Contact.js',
    'box2d/dynamics/contacts/b2ContactConstraint.js',
    'box2d/dynamics/contacts/b2ContactConstraintPoint.js',
    'box2d/dynamics/contacts/b2ContactRegister.js',
    'box2d/dynamics/contacts/b2ContactSolver.js',
    'box2d/dynamics/contacts/b2CircleContact.js',
    'box2d/dynamics/contacts/b2Conservative.js',
    'box2d/dynamics/contacts/b2NullContact.js',
    'box2d/dynamics/contacts/b2PolyAndCircleContact.js',
    'box2d/dynamics/contacts/b2PolyContact.js',
    'box2d/dynamics/b2ContactManager.js',
    'box2d/dynamics/b2World.js',
    'box2d/dynamics/b2WorldListener.js',
    'box2d/dynamics/joints/b2JointNode.js',
    'box2d/dynamics/joints/b2Joint.js',
    'box2d/dynamics/joints/b2JointDef.js',
    'box2d/dynamics/joints/b2DistanceJoint.js',
    'box2d/dynamics/joints/b2DistanceJointDef.js',
    'box2d/dynamics/joints/b2Jacobian.js',
    'box2d/dynamics/joints/b2GearJoint.js',
    'box2d/dynamics/joints/b2GearJointDef.js',
    'box2d/dynamics/joints/b2MouseJoint.js',
    'box2d/dynamics/joints/b2MouseJointDef.js',
    'box2d/dynamics/joints/b2PrismaticJoint.js',
    'box2d/dynamics/joints/b2PrismaticJointDef.js',
    'box2d/dynamics/joints/b2PulleyJoint.js',
    'box2d/dynamics/joints/b2PulleyJointDef.js',
    'box2d/dynamics/joints/b2RevoluteJoint.js',
    'box2d/dynamics/joints/b2RevoluteJointDef.js',
)

def _yui_compress(src, dst):
    cmd = [
        YUI_APP_PATH,
        '-v' if VERBOSE_YUI else '',
        src,
        '-o', dst,
        '--charset utf-8',
        '--line-break 1000'
    ]
    cmd = ' '.join(cmd)
    os.system(cmd)

def _read(path):
    with open(path) as fh:
        data = fh.read()
        print 'read file', path, len(data)
        fh.close()
    return data or ''

def _proc_src(src):
    data = []
    min_data = []
    src = os.path.join(LIB_URL_PREFIX, src)
    dst = src.split('.')
    dst.insert(-1, MIN_SUFF)
    dst = '.'.join( dst )
    _yui_compress(src, dst)
    _proc_dst(src, dst, data, min_data)
    with open(RESULT_PATH, 'a') as fh:
        fh.write( '\n\n'.join(data) )
        fh.close()
    with open(RESULT_MIN_PATH, 'a') as fh:
        fh.write( u'\n'.join(min_data) )
        fh.close()

def _proc_dst(src, dst, data, min_data):
    text = _read(src)
    data.append(text)
    text = _read(dst)
    min_data.append(text)
    os.remove(dst)

def main():
    if os.path.isfile(RESULT_PATH):
        os.remove(RESULT_PATH)
    if os.path.isfile(RESULT_MIN_PATH):
        os.remove(RESULT_MIN_PATH)
    for item in LIBLIST:
        _proc_src(item.replace('/', os.sep))


if __name__ == '__main__':
    main()
