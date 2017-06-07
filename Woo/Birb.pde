abstract class Birb {

  //used to calculate amount of pullback
  final float initX;
  final float initY;
  //other properties
  float rad; //actually the diameter
  float mass;
  //current position
  float x;
  float y;
  //velocity in x and y directions
  float dx;
  float dy;
  //image
  PImage loadedBirb;
  int whichBirb;
  //state variables
  boolean pulled;
  boolean launched;
  boolean collided;
  boolean specialed;

  Birb() {
    x = 100;
    y = 260;
    initX = x;
    initY = y;
    dx = 0;
    dy = 0;
    pulled = false;
    launched = false;
    collided = false;
    specialed = false;
    rad = 40;
    mass = 1;
  }

  void drag() {
    //can't pull back on birb if it was already launched
    //must start pulling by having mouse on the birb
    if (launched || (!pulled && !onBirb() ) ) {
      return;
    }
    //if in the process of pulling and max pullback range is exceeded, birb instead points towards mouse
    else if ( pulled && dist(mouseX, mouseY, initX, initY) > maxPull ) {
      towardsMouse(maxPull);
    } else {
      pulled = true;
      x = mouseX;
      y = mouseY;
      /*
      if (whichBirb == 0) {
       loadedBirb = loadImage("img/red_birb.png");
       loadedBirb.resize(50,50);
       image(loadedBirb, x, y);
       }
       if (whichBirb == 1) {
       loadedBirb = loadImage("img/blue_birb.png");
       loadedBirb.resize(40,40);
       image(loadedBirb, x, y);
       }
       if (whichBirb == 2) {
       loadedBirb = loadImage("img/yellow_birb.png");
       loadedBirb.resize(50,50);
       image(loadedBirb, x, y);
       }*/
    }
  }
  //returns whether the mouse is over the birb
  boolean onBirb() {
    return dist(x, y, mouseX, mouseY) <= 50;
  }

  //repositions birb towards the mouse
  void towardsMouse(float pullback) {
    float theta = asin( (mouseY - initY) / dist(initX, initY, mouseX, mouseY) );
    y = initY + (pullback * sin(theta));    
    x = initX - (pullback * cos(theta));
    //in the case that the player is aiming the wrong way (we'll still let you do that)
    if (mouseX > initX) {
      x = initX + (pullback * cos(theta));
    }
  }  

  void shoot() {
    //can't shoot if birb was never pulled back or already launched
    if ( !pulled || launched ) {
      return;
    }
    launched = true;
    dx = -(x - initX) / 5;
    dy = -(y - initY) / 5;
  }
  void move() {
    //bounced off bottom edge
    if ( y > height ) {
      collided = true;
      y = height;
      dy *= -0.5;
    }
    //only have gravity act when birb is in the air, not on the "slingshot"
    if (launched)
      dy += grav;
    x += dx;
    y += dy;
  }
  void hitBlock(){
    for(Block bl : blocks){
      //is at right altitude to hit left or right side of a Block
      if( (y + rad/2 > bl.y) && (y - rad/2 < bl.y + bl.yDim) ){
        //passed into space occupied by the Block
        if( (x + rad/2 > bl.left) && (x - rad/2 < bl.right) ){ 
          collided = true; //can no longer use special move
          //enough force to smash through Block and keep going
          float resultantVector = sqrt( sq(dx) + sq(dy) );
          if( (resultantVector * mass * frameRate) >= bl.health){ //acceleration = distance/time. In one second, a Birb travels (dx) distance (frameRate) times.
            increasePoints(100);
            dx *= 0.2;
            dy *= 0.2;
            breakBlock(bl);
            return; 
          }
          else{
            if (resultantVector * mass * frameRate > 100){
              bl.health -= resultantVector * mass * frameRate;
              increasePoints(100);
            }
            if(y - rad/2 < bl.y + bl.yDim || y + rad/2 > bl.y){
              //y = bl.y - rad/2 - 1;
              dy *= -inelastic;
            }
            else{
              x = bl.left - rad/2 - 1;
              dx *= -inelastic; //change direction and lose some kinetic energy
            }
          }
          return;
        }
      }
      /*
      //is at right x-coordinate to hit Block on its top or bottom sides
      else if( (x + rad/2 > bl.left) && (x - rad/2 < bl.right) ){
        if( (y + rad/2 > bl.y) && (y - rad/2 < bl.y + bl.yDim) ){
          */
    }
  }
  void hitPig() {
    for (Pig p : pigs) {
      if ( dist(x, y, p.x, p.y) <= rad/2 + p.rad/2) {
        increasePoints(100);
        float resultantVector = sqrt( sq(dx) + sq(dy) );
        if ( resultantVector * mass * frameRate > p.health ) {
          dx *= 0.2;
          dy *= 0.2;
          killPig(p);
          return; //stop after killing the pig, avoid concurrent modification exception
        } else {
          p.health -= resultantVector * mass * frameRate;
          if ( x <= p.x ) {
            dx *= -1;
          } else {
            dy *= -1;
          }
        }
      }
    }
  }

  abstract void special();
}