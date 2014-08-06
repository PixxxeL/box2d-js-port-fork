Box2d-js Port Fork
==================

Fork of [port](http://box2d-js.sourceforge.net/index.html) (from Flash to js)
of [Box2D Physics Engine](http://box2d.org/) for Javascript.
Port was created by Ando Yasushi (and/or Erin Catto) (sorry if i'm wrong)
and located at http://box2d-js.sourceforge.net/index.html
where was some more information.

I found some features of this port is inconvenient and try to correct it.

List of changes:
----------------

  * Add builder for concatenate files of lib in one because them total count is 64.
    Now you add lib just place script tag with `box2d.min.js` from `src/origin` dir
    if you want original version or from `src/fork` if you want new version.
  * Add DebugDraw method of b2World class. This method call every frame
    for draw shapes and joints on canvas element. For install it
    set `SetDebugDraw` where pass 2d-context, width and height of canvas-2d.
