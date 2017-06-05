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
    bounce();
    for (Ball b : balls) {
      if (b.inFloor || (b != this && (myBlock == null || b.myBlock != myBlock) && !b.collided && !collided)) {
        if (b.myBlock != null && !b.myBlock.checkCollide()) {
          if (dist(x, y, b.x, b.y) < (rad/2 + b.rad/2)) {
            //if hitting a Block that is horizontal, fall over as if you hit the floor, only if you're in a Block of course
            if (inBlock && myBlock != b.myBlock && b.myBlock.subs[0].y - b.myBlock.subs[b.myBlock.subs.length - 1].y == 0) {
              //F = ma, decrement health based on velocity, which accelerates (or decelerates, for all you laymen) to zero
              //in a single frame, which takes 1/frameRate seconds
              myBlock.health -= (sqrt( sq(dx) + sq(dy) ) ) / (1/frameRate); 
              b.myBlock.health -= (sqrt( sq(dx) + sq(dy) ) ) / (1/frameRate);
              myBlock.fallingOver = true;
              myBlock.fallOver();            
              //stickMe(b,this);
              for(Ball ball: myBlock.subs){
               ball.y -= 5; //to prevent overlapping or whatever's causing all of our bugs
              }
            }
            
            //colliding with a vertical block resting on the floor
            //else if(b.myBlock.flatOnTheFloor && b.myBlock.subs[0].x == b.myBlock.subs[b.myBlock.subs.length - 1].x){
            else if(b.myBlock.isVertical()){
              //decrementing health is the first step since dx and dy will be manipulated in the following lines
              if(inBlock)
                myBlock.health -= (sqrt( sq(dx) + sq(dy) ) ) / (1/frameRate);
              b.myBlock.health -= (sqrt( sq(dx) + sq(dy) ) ) / (1/frameRate);
              Block vert = b.myBlock;
              //vert.fallingOver = true;
              //vert.flatOnTheFloor = false;
              //vert.fallOver();
              vert.vertFallOver(dx); //if ball is moving right, the block it contacts will fall over to the right
              for(Ball ball : myBlock.subs){
                ball.dy = 0;
              }
              myBlock.fallingOver = true;
              myBlock.fallOver();
                
              /*
              float len; //dist between a certain ball and a ball on the end
              if (this.dx > 0){
                //offset b.myBlock a bit to the right
                //if "first" ball of b.myBlock is on the floor
                if(vert.subs[0].y > vert.subs[vert.subs.length - 1].y){
                  vert.subs[0].dy = 0;
                  for(int i = 1;i < vert.subs.length;i ++){
                    len = i * vert.subs[0].rad; //Ball 1 is 1 rad away from Ball 0
                    vert.subs[i].x = vert.subs[0].x + len * cos(radians(85));
                    vert.subs[i].y = vert.subs[0].y - len * sin(radians(85));
                  }
                }
                //b.myBlock falls over as usual
                //"last" ball of b.myBlock is on the floor
                else{ 
                  for(int i = vert.subs.length - 2;i >= 0;i ++){
                    len = (vert.subs.length - 1 - i) * vert.subs[0].rad; //for each index away, one rad farther away
                    vert.subs[i].x = vert.subs[vert.subs.length - 1].x + len * cos(radians(85));
                    vert.subs[i].y = vert.subs[vert.subs.length - 1].y - len * sin(radians(85));
                  }
                }
                //b.myBlock falls over as usual                
                vert.fallingOver = true;
                vert.flatOnTheFloor = false;
                
              }
              else if (this.dx < 0){
                //offset b.myBlock a bit to the left
                //b.myBlock falls over as usual
              }
              else{ //this.dx == 0
                //remove b.myBlock from the game (vertical hits are its weakness)
              }
              */
            }
            /*
            else if(b.myBlock.fallingOver){
              for(Ball ball : myBlock.subs)
                ball.y -= 10;
            }
            */
            else {
              //if(!b.inFloor){
              dxtemp = dx;
              dytemp = dy;
              //}
              dx = (((mass-b.mass)/(mass+b.mass)) * dx ) + (((2*b.mass)/(mass+b.mass)) * b.dx) * inelastic;
              dy = (((mass-b.mass)/(mass+b.mass)) * dy ) + (((2*b.mass)/(mass+b.mass)) * b.dy) * inelastic;
              //health decrementation (is that a word?)
              //calculate change in velocity over time (acceleration)
              //time is one frame, which is 1 second over the frameRate
              if (inBlock){
                myBlock.health -= abs(sqrt( sq(dx) + sq(dy) ) - sqrt( sq(dxtemp) + sq(dytemp) )) / (1 / frameRate);
              }
              if (b.inBlock){
                b.myBlock.health -= abs(sqrt( sq(dx) + sq(dy) ) - sqrt( sq(dxtemp) + sq(dytemp) )) / (1 / frameRate);
              }
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
              if(!inBlock){
                removeBall(this);
              }
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
  void hitPig() {
    for(Pig p : pigs) {
    //int i = 0;
    //while( i < pigs.size() ){
      //Pig p = pigs.get(i);
      if( dist( x , y , p.x , p.y) <= rad/2 + p.rad/2 ){
        p.health -= ( sqrt( sq(dx) + sq(dy) ) + sqrt( sq(p.dx) + sq(p.dy) ) ) * (mass + p.mass);
        //impact was enough to kill pig
        if(p.health <= 0){
          //killPig(p);
          dx *= 0.5;
          dy *= 0.5;
        }
        //impact was not strong enough
        else{
          //ball's direction is opposite the side of pig hit (traveling right, hit left side)
          if( (p.x - x) * dx >= 0){ 
            dx *= -1 * inelastic;
            dy *= -1 * inelastic;
          }
          //ball traveling right and hit right side of pig, or left and left
          else
            dy *= -1;
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