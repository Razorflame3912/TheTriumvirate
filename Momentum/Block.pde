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
      b.inBlock = true;
    }
  }

  /*boolean collision() {
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
   }*/

  void influenceOthers(int index, float centerdxb, float centerdyb) {
    int center  = subs.length/2;
    float bigdx = 0;
    float bigdy = 0;
    float xincrement = 0;
    float yincrement = 0;
    float dxtemp = 0;
    float dytemp = 0;
    float centerdx = subs[center].dx;
    float centerdy = subs[center].dy;
    if (center == index) {
      for (int x = 0; x<subs.length; x++) {
        if (x != center) {
          subs[x].dx += (centerdx - centerdxb);
          subs[x].dy += (centerdy - centerdyb);
        }
      }
    } else {
      bigdx = (index-center)*(subs[index].dx/center); 
      bigdy = (index-center)*(subs[index].dy/center);
      if (subs[index].dx < 0) {
        bigdx*=-1;
      }
      if (subs[index].dy < 0) {
        bigdy*=-1;
      }


      xincrement = subs[index].dx/center;
      yincrement = subs[index].dy/center;
      if (bigdx > 0) {
        xincrement *= -1;
      }
      if (bigdy > 0) {
        yincrement *= -1;
      }
      dxtemp = subs[center].dx + subs[index].dx;
      dytemp = subs[center].dy + subs[index].dy;
      subs[index].dx = 0;
      subs[index].dy = 0;
      for (int i = subs.length-1; i>=0; i--) {
        Ball now = subs[i];
        now.dx = bigdx + (xincrement * (subs.length - 1 - i)) + dxtemp;
        now.dy = bigdy + (yincrement * (subs.length - 1 - i)) + dytemp;
      }
    }
  }

  void influenceOthersB(int index, float centerdxb, float centerdyb, float currentxb, float currentyb) {
    float changex, changey;
    float xdiff = 0;
    float ydiff = 0;
    changex = changey = 0;
    if (subs[index].x == subs[index].rad/2 || subs[index].x == width - subs[index].rad/2) {
      changex = centerdxb * -1;
      xdiff = subs[index].x - currentxb;
    } else {
      changey = centerdyb * -1;
      ydiff = subs[index].y - currentyb;
    }
    for (int i = 0; i < subs.length; i++) {
      subs[i].dx += changex;
      subs[i].dy += changey;
      if (i != index) {
        if (changex < 0) {
          subs[i].x += xdiff;
        } else {
          subs[i].x -= xdiff;
        }
        if (changey < 0) {
          subs[i].y += ydiff;
        } else {
          subs[i].y-=ydiff;
        }
      }
    }
  }

  void stickMe(Ball me, Ball you) {
    float distance = dist(me.x, me.y, you.x, you.y);
    float x1 = you.x - me.x;
    float y1 = you.y - me.y;
    float x2 = (me.rad * x1)/distance;
    float y2 = (me.rad * y1)/distance;
    you.x = me.x + x2;
    you.y = me.y + y2;
  }

  void update() {
    //if (!collision()) {
    int center = subs.length/2;
    float centerdx = subs[center].dx;
    float centerdy = subs[center].dy;
    float currentx, currenty;
    for (int x = 0; x<subs.length; x++) {
      currentx = subs[x].x;
      currenty = subs[x].y;
      if (subs[x].collision()) {
        influenceOthers(x, centerdx, centerdy);
      } /*else if (subs[x].bounce()) {
        influenceOthersB(x, centerdx, centerdy, currentx, currenty);
      }*/ else {
        subs[x].x += subs[x].dx;
        subs[x].y += subs[x].dy + grav;
      }
    }
    int i = 0;
    while (subs.length/2 + i + 1 < subs.length) {
      stickMe(subs[subs.length/2 + i], subs[subs.length/2 + i + 1]);
      i++;
    }
    int j = 0;
    while ((subs.length/2) - j - 1 >= 0) {
      stickMe(subs[(subs.length/2) - j], subs[(subs.length/2) - j - 1]);
      j++;
    }
    // }
  }
}