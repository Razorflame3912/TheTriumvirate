class Block {
  Ball[] subs;
  boolean fallingOver;
  boolean flatOnTheFloor;
  float health;
  Block() {
    subs = new Ball[1];
    subs[1] = new Ball();
  }

  Block(int w, int l, int xcor, int ycor, int direction) {
    int rad = w;
    int xnow = xcor;
    int ynow = ycor;
    subs = new Ball[l/rad];
    for (int x = 0; x < subs.length; x++) {
      subs[x] = new Ball();
      Ball b =  subs[x];
      b.mass = 10;
      b.rad = rad;
      b.y = ynow;
      b.x = xnow;
      if (direction > 0) {
        xnow += rad;
      } else {
        ynow -= rad;
      }
      b.dx = 0;
      b.dy = 0;
      b.inBlock = true;
      b.inFloor = false;
      b.myBlock = this;
      balls.add(b);
    }
    fallingOver = false;
    flatOnTheFloor = false;
    health = 1000;
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

  /*  void influenceOthersB(int index, float centerdxb, float centerdyb, float currentxb, float currentyb) {
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
   }*/

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
      //subs[x].collision();
      if (subs[x].collided) {
        if (x == center) {
          influenceOthers(x-1, centerdx, centerdy);
        } else {
          influenceOthers(x, centerdx, centerdy);
        }
      } //else if (subs[x].bounce()) {
      //influenceOthersB(x, centerdx, centerdy, currentx, currenty);
    }
    // }
  }

  void stickEmAll() {
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
  }

  void progress() {
    for (Ball b : subs) {
      if (!flatOnTheFloor)
        b.dy += grav;
      b.x += b.dx;
      b.y += b.dy;
    }
  }

  boolean checkCollide() {
    boolean ret = false;
    for (Ball b : subs) {
      ret  = ret && b.collided;
    }
    return ret;
  }

  boolean reachedFloor() //as in the bottom of the screen, not the highly experimental "ball-wall"
  {
    return subs[0].y + subs[0].rad >= height || subs[subs.length - 1].y + subs[0].rad >= height;
  }
  boolean isVertical()
  {
    return subs[0].x == subs[subs.length-1].x;
  }
  void friction()
  {
    //if (flatOnTheFloor)
    for (Ball b : subs) {
      b.dx *= 0.99;
      if (b.dx < 0.01)
        b.dx = 0;
    }
  }

  void fallOver()
  {

    if (fallingOver)
    {
      
      if (subs[0].x == subs[subs.length - 1].x){ //block is vertical
        fallingOver = false;
        flatOnTheFloor = true;
        return;
      }
      
      float theta = abs(atan( (subs[subs.length - 1].y - subs[0].y)/(subs[subs.length - 1].x - subs[0].x) ));
      theta -= radians(.1);//fall over 0.1 degrees at a time
      float len;

      //leftmost ball contacted with ground
      if (subs[0].y > subs[subs.length - 1].y && theta > 0)
      {
        //subs[0].y = height - subs[0].rad;
        subs[0].dy = 0;
        for (int i = subs.length - 1; i > 0; i --)
        {
          len = i * subs[0].rad;
          subs[i].x = subs[0].x + len * cos(theta);
          subs[i].y = subs[0].y - len * sin(theta);
        }
      }
      //right most ball contacted with ground
      else if (subs[subs.length - 1].y > subs[0].y && theta > 0)
      {
        subs[subs.length - 1].dy = 0;
        for (int i = 0; i < subs.length - 1; i ++)
        {
          len = (subs.length - 1 - i) * subs[0].rad;
          subs[i].x = subs[subs.length - 1].x - len * cos(theta);
          subs[i].y = subs[subs.length - 1].y - len * sin(theta);
        }
      } else {
        fallingOver = false;
        flatOnTheFloor = true;
        fallOverDamage();
      }
    } else {
      return;
    }
  }//end fallOver
  void fallOverDamage()
  {
    float len = subs.length * subs[0].rad;
    float circumferenceOfCircularPathOfTheOuterMostBall = 2 * len * PI; //circ of the circle that has bl as its radius
    //outermost ball is traveling at 1 degree per 1/frameRate seconds
    float velocity = (1/circumferenceOfCircularPathOfTheOuterMostBall) / (1/frameRate);
    //accelerates to a stop in a single frame
    float a = velocity / (1/frameRate);
    //f=ma, no mass variable for now
    health -= abs(a); //abs just in case;
  }
    
    
  void vertFallOver(float dir)
  {
    int angle = 80; //variable gives me easy way to change all the values in the following lines
    float len;
    if(subs[0].y > subs[subs.length - 1].y)
    {      
      for(int i = 1;i < subs.length;i ++){
        len = i * subs[0].rad;
        if(dir > 0){
          subs[i].x = subs[0].x + len * cos(radians(angle));  
          subs[i].y = subs[0].y - len * sin(radians(angle));
        }
        else if(dir < 0){
          subs[i].x = subs[0].x - len * cos(radians(angle));
          subs[i].y = subs[0].y - len * sin(radians(angle));
        }
        else{ //dir == 0, block was struck by an object moving straight down
          //for(Ball b : subs)
            //b.dy = 0;
          return;
        }
      }
    }
    // in the case that the block flipped end over end, and subs[0] is on top
    else
    {
      for(int i = subs.length - 2;i >= 0;i --){
        len = (subs.length - 1 - i) * subs[0].rad;
        if(dir > 0){
          subs[i].x = subs[0].x + len * cos(radians(angle));
          subs[i].y = subs[0].y - len * sin(radians(angle));
        }
        else if(dir < 0){
          subs[i].x = subs[0].x - len * cos(radians(angle));
          subs[i].y = subs[0].y - len * sin(radians(angle));
        }  
        else{
          return;
        }
      }    
    }
    fallingOver = true;
    flatOnTheFloor = false;
  }
          
}