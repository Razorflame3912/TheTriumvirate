class Block {
  float x, y, dx, dy, mass, rad, red, blue, green;
  color c;

  Block() {
    x = random(height);
    y = random(width);
    dx = 10 - random(20);
    dy = 10 - random(20);
    mass = random(10) + 1;
    rad = 15;
    red = random(255);
    blue = random(255);
    green = random(255);
    c = color(red, blue, green);
  }

  boolean bounce() {
    if (x + rad/2 > width || x - rad/2 < 0) {
      dx *= -.95;
      if (x + rad/2 > width) {
        x = width - rad/2;
      } else {
        x = 0 + rad/2;
      }
      return true;
    }

    if (y + rad/2 > height || y - rad/2 < 0) {
      dy *= -.95;
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
    dxtemp = dytemp = 0;
    for (Block b : blocks) {
      if (b != this) {
        if (dist(x, y, b.x, b.y) < (rad/2 + b.rad/2)) {
          dxtemp = dx;
          dytemp = dy;
          dx = (((mass-b.mass)/(mass+b.mass)) * dx ) + (((2*b.mass)/(mass+b.mass)) * b.dx) * 0.95;
          dy = (((mass-b.mass)/(mass+b.mass)) * dy ) + (((2*b.mass)/(mass+b.mass)) * b.dy) * 0.95;
          b.dx = (((b.mass-mass)/(mass+b.mass)) * b.dx ) + (((2*mass)/(mass+b.mass)) * dxtemp) * 0.95;
          b.dy = (((b.mass-mass)/(mass+b.mass)) * b.dy ) + (((2*mass)/(mass+b.mass)) * dytemp) * 0.95;
          if (x > b.x && y > b.y) {
            while (dist(x, y, b.x, b.y) < (rad/2 + b.rad/2)) {
              x++;
              y++;
            }
          } else if (x < b.x && y > b.y) {
            while (dist(x, y, b.x, b.y) < (rad/2 + b.rad/2)) {
              x--;
              y++;
            }
          } else if (x < b.x && y < b.y) {
            while (dist(x, y, b.x, b.y) < (rad/2 + b.rad/2)) {
              x--;
              y--;
            }
          } else {
            while (dist(x, y, b.x, b.y) < (rad/2 + b.rad/2)) {
              x++;
              y--;
            }
          }    


          return true;
        }
      }
    }
    return false;
  }

  void update() {
    if (!bounce() && !collision()) {
      dy += grav;
      x += dx;
      y += dy;
    }
  }
}