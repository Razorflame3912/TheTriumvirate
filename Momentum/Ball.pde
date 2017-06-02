class Ball {
  float x, y, dx, dy, mass, rad, red, blue, green;
  color c;
  boolean inBlock, inFloor, collided;
  Block myBlock;

  Ball() {
    x = random(height);
    y = random(width);
    dx = 10 - random(20);
    dy = 10 - random(20);
    mass = random(10) + 1;
    rad = 20;
    red = random(255);
    blue = random(255);
    green = random(255);
    c = color(red, blue, green);
    inBlock = false;
    inFloor = false;
    collided = false;
  }

  boolean bounce() {
    if (x + rad/2 > width || x - rad/2 < 0) {
      if (!inBlock) {
        dx *= -1 * inelastic;
      }
      if (x + rad/2 > width) {
        x = width - rad/2;
      } else {
        x = 0 + rad/2;
      }
      return true;
    }

    if (y + rad/2 > height || y - rad/2 < 0) {
      if (!inBlock) {
        dy *= -1 * inelastic;
      }
      if (y + rad/2 > height) {
        y = height - rad/2;
      } else {
        y = 0 + rad/2;
      }
      return true;
    }
    return false;
  }

  boolean collision() {
    float dxtemp, dytemp;
    //boolean hit = false;
    dxtemp = dytemp = 0;
    for (Ball b : balls) {
      if (b.inFloor || (b != this && (myBlock == null || b.myBlock != myBlock) && !b.collided && !collided)) {
        if (b.myBlock != null && !b.myBlock.checkCollide()) {
          if (dist(x, y, b.x, b.y) < (rad/2 + b.rad/2)) {
            if (inBlock && myBlock != b.myBlock && b.myBlock.subs[0].y - b.myBlock.subs[b.myBlock.subs.length - 1].y == 0) {
              myBlock.fallingOver = true;
              myBlock.fallOver();
              stickMe(b,this);
              for(Ball ball: myBlock.subs){
               ball.y -= 5; 
              }
            } else {
              //if(!b.inFloor){
              dxtemp = dx;
              dytemp = dy;
              //}
              dx = (((mass-b.mass)/(mass+b.mass)) * dx ) + (((2*b.mass)/(mass+b.mass)) * b.dx) * inelastic;
              dy = (((mass-b.mass)/(mass+b.mass)) * dy ) + (((2*b.mass)/(mass+b.mass)) * b.dy) * inelastic;
              if (!b.inFloor) {
                b.dx = (((b.mass-mass)/(mass+b.mass)) * b.dx ) + (((2*mass)/(mass+b.mass)) * dxtemp) * inelastic;
                b.dy = (((b.mass-mass)/(mass+b.mass)) * b.dy ) + (((2*mass)/(mass+b.mass)) * dytemp) * inelastic;
              }

              if (!b.inBlock) {
                b.dx = (((b.mass-mass)/(mass+b.mass)) * b.dx ) + (((2*mass)/(mass+b.mass)) * dxtemp) * inelastic;
                b.dy = (((b.mass-mass)/(mass+b.mass)) * b.dy ) + (((2*mass)/(mass+b.mass)) * dytemp) * inelastic;
              }
              if (!inFloor && !inBlock && (b.inBlock || b.inFloor)) {
                stickMe(b, this);
              }

              if (inBlock && (b.inFloor || b.inBlock)) {
                stickMe(b, this);
              }




              b.collided = true;
              collided = true;
              return true;
            }
          }
        }
      }
    }
    /*
      for (Ball b : floor) {
     if (b != this) {
     if (dist(x, y, b.x, b.y) < (rad/2 + b.rad/2)) {
     dxtemp = dx;
     dytemp = dy;
     dx = (((mass-b.mass)/(mass+b.mass)) * dx ) + (((2*b.mass)/(mass+b.mass)) * b.dx) * inelastic;
     dy = (((mass-b.mass)/(mass+b.mass)) * dy ) + (((2*b.mass)/(mass+b.mass)) * b.dy) * inelastic;
     b.dx = (((b.mass-mass)/(mass+b.mass)) * b.dx ) + (((2*mass)/(mass+b.mass)) * dxtemp) * inelastic;
     b.dy = (((b.mass-mass)/(mass+b.mass)) * b.dy ) + (((2*mass)/(mass+b.mass)) * dytemp) * inelastic;
     stickMe(b,this );
     
     
     return true;
     }
     }
     }
     
     for (Block bl : blocks) {
     for (Ball b : bl.subs) {
     if (b != this) {
     if (dist(x, y, b.x, b.y) < (rad/2 + b.rad/2)) {
     dxtemp = dx;
     dytemp = dy;
     dx = (((mass-b.mass)/(mass+b.mass)) * dx ) + (((2*b.mass)/(mass+b.mass)) * b.dx) * inelastic;
     dy = (((mass-b.mass)/(mass+b.mass)) * dy ) + (((2*b.mass)/(mass+b.mass)) * b.dy) * inelastic;
     b.dx = (((b.mass-mass)/(mass+b.mass)) * b.dx ) + (((2*mass)/(mass+b.mass)) * dxtemp) * inelastic;
     b.dy = (((b.mass-mass)/(mass+b.mass)) * b.dy ) + (((2*mass)/(mass+b.mass)) * dytemp) * inelastic;
     stickMe(this, b);
     
     
     return true;
     }
     }
     }
     }*/
    return false;
  }

  void stickMe(Ball me, Ball you) {
    float distance = dist(me.x, me.y, you.x, you.y);
    float x1 = you.x - me.x;
    float y1 = you.y - me.y;
    float x2 = (me.rad * x1)/distance;
    float y2 = (me.rad * y1)/distance;
    float changex = me.x + x2 - you.x;
    float changey = me.y + y2 - you.y;
    you.x = me.x + x2;
    you.y = me.y + y2;
    if (you.inBlock) {
      for (Ball b : you.myBlock.subs) {
        if (b != you) {
          b.x += changex;
          b.y += changey;
        }
      }
    }
  }

  void update() {
    if (!inFloor) {
      //collision();
      if (!collided) {
        dy += grav;
        x += dx;
        y += dy;
      }
    }
  }
}