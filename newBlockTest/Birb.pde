abstract class Birb{
 
  //used to calculate amount of pullback
  final float initX;
  final float initY;
  //current position
  float x;
  float y;
  //velocity in x and y directions
  float dx;
  float dy;
  //size
  float rad;
  //image
  PImage loadedBirb;
  int whichBirb;
  //state variables
  boolean pulled;
  boolean launched;
  boolean collided;
  boolean specialed;
  
  float mass; 
  
  Birb(){
    x = 100;
    y = height - 100;
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
  
  void drag(){
    //can't pull back on birb if it was already launched
    //must start pulling by having mouse on the birb
    if(launched || (!pulled && !onBirb() ) ){
      return;
    }
    //if in the process of pulling and max pullback range is exceeded, birb instead points towards mouse
    else if( pulled && dist(mouseX,mouseY,initX,initY) > maxPull ){
      towardsMouse(maxPull);
    }
    else{
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
  boolean onBirb(){
   return dist(x,y,mouseX,mouseY) <= 50; 
  }
  
  //repositions birb towards the mouse
  void towardsMouse(float pullback){
    float theta = asin( (mouseY - initY) / dist(initX,initY,mouseX,mouseY) );
    y = initY + (pullback * sin(theta));    
    x = initX - (pullback * cos(theta));
    //in the case that the player is aiming the wrong way (we'll still let you do that)
    if(mouseX > initX){
      x = initX + (pullback * cos(theta));      
    }
  }  
  
  void shoot(){
    //can't shoot if birb was never pulled back or already launched
    if( !pulled || launched ){
      return;
    }
    launched = true;
    dx = -(x - initX) / 5;
    dy = -(y - initY) / 5;
  }
  void move(){
    //bounced off bottom edge
    if ( y > height ){
      collided = true;
      y = height;
      dy *= -0.5;
    }
    //only have gravity act when birb is in the air, not on the "slingshot"
    if(launched)
      dy += grav;
    x += dx;
    y += dy;
    
    /*
    birbBall.x = x; 
    birbBall.y = y;
    birbBall.dx = dx; 
    birbBall.dy = dy;
    birbBall.collision();
    /*
    if (whichBirb == 0) {
      loadedBirb = loadImage("img/red_birb.png");
      loadedBirb.resize(50,50);
      image(loadedBirb, x, y);
    }
    if (whichBirb == 1) {
      loadedBirb = loadImage("img/blue_birb.png");
      loadedBirb.resize(50,50);
      image(loadedBirb, x, y);
    }
    if (whichBirb == 2) {
      loadedBirb = loadImage("img/yellow_birb.png");
      loadedBirb.resize(50,50);
      image(loadedBirb, x, y);
    }
    */
  }
  /*
  void hitStuff(){
    for(Ball ball : balls){
      if(dist(x,y,ball.x,ball.y) < 25 + ball.rad){
        balls.add(new Ball());
        Ball birbBall = balls.get(balls.size() -1);
        birbBall.x = x;
        birbBall.y = y;
        birbBall.dx = dx;
        birbBall.dy = dy;
        birbBall.collision();
        balls.remove(balls.size() - 1);
        return;
      }
    }
  }
  */
  
  void hitBlock(){
    for(Block bl : blocks){
      //is at right altitude to hit left or right side of a Block
      if( (y + rad/2 > bl.y) && (y - rad/2 < bl.y + bl.yDim) ){
        //passed into space occupied by the Block
        if( (x + rad/2 > bl.left) && (x - rad/2 < bl.right) ){ 
          //enough force to smash through Block and keep going
          float resultantVector = sqrt( sq(dx) + sq(dy) );
          if( (resultantVector * mass * frameRate) >= bl.health){ //acceleration = distance/time. In one second, a Birb travels (dx) distance (frameRate) times.
            dx *= 0.2;
            dy *= 0.2;
            breakBlock(bl);
          }
          else{            
            bl.health -= resultantVector * mass * frameRate;
            if(y - rad/2 < bl.y || y + rad/2 > bl.y + bl.yDim)
              dy *= -inelastic;
            else
              dx *= -inelastic; //change direction and lose some kinetic energy
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
            

  abstract void special();
}