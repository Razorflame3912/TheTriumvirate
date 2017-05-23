class Block {
  Ball[] subs;

  Block() {
    subs = new Ball[1];
    subs[1] = new Ball();
  }

  Block(int w, int l, int xcor, int ycor) {
    int rad = w;
    int xnow = xcor;
    subs = new Ball[l/rad];
    for (int x = 0; x < subs.length; x++) {
      subs[x] = new Ball();
      Ball b =  subs[x];
      b.mass = 10;
      b.rad = rad;
      b.y = ycor;
      b.x = xnow;
      xnow += rad;
      b.dx = 0;
      b.dy = 0;
    }
  }

  boolean collision() {
    float xincrement = 0;
    float yincrement = 0;
    Ball b = subs[subs.length-1];
    if (b.collision()) {
      xincrement = abs(2 * b.dx/subs.length);
      yincrement = abs(2 * b.dy/subs.length);

      if (b.dx > 0) {
        xincrement *= -1;
      }
      if (b.dy > 0) {
        yincrement *= -1;
      }

      for (int x = subs.length-1; x>=0; x--) {
        Ball now = subs[x];
        now.dx += b.dx + (xincrement * (subs.length - 1 - x));
        now.dy += b.dy + (yincrement * (subs.length - 1 - x));
        //    now.x += now.dx;
        //    now.y += now.dy;
      }
      return true;
    }
    return false;
  }

  void stickMe(Ball me, Ball you, int dir) {
    float slope = (me.y - you.y)/(me.x - you.x);
    you.x = me.x;
    you.y = me.y;
    while (dist(me.x, me.y, you.x, you.y) < (me.rad / 2 + you.rad / 2)) {
      if (dir > 0) {
        you.x += 1;
        you.y += slope;
      } else {
        you.x -= 1;
        you.y -= slope;
      }
    }
  }

  void update() {
    if (!collision()) {
      for (Ball b : subs) {
        b.x += b.dx;
        b.y += b.dy;
      }
      int i = 0;
      while (subs.length/2 + i + 1 < subs.length) {
        stickMe(subs[subs.length/2 + i], subs[subs.length/2 + i + 1], 1);
        i++;
      }
      int j = 0;
      while ((subs.length/2) - j - 1 >= 0) {
        stickMe(subs[(subs.length/2) - j], subs[(subs.length/2) - j - 1], -1);
        j++;
      }
    }
  }
}