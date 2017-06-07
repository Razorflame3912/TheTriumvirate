class Block{
  float left, right ; //xcor of left and right sides of the Block
  float y; //ycor of upper edge of Block;
  float xDim, yDim ; //horizontal and vertical dimensions of the Block

  float dy; //no horizontal movement cause that's too complicated (sadly)
  float health;

  Block() {
    left = 300;
    right = 600;
    y = 200;
    dy = .5;
    xDim = right - left;
    yDim = 50;
    health = 10000;
  }

  Block(float l, float r, float yCor,float yD) {
    left = l;
    right = r;
    y = yCor;
    xDim = r - l;
    yDim = yD;
    health = 1000;
  }
  
  void update(){
    if( freeToFall () && !reachedFloor() ){
      dy += grav;
      y += dy;
    }
    else{
      dy = 0;
      while(!freeToFall() || reachedFloor() ){
        y -= 1;
      }
    }
  }
  //returns whether there are any Blocks directly under this one  
  boolean freeToFall(){
    boolean ret = true;
    for(Block bl : blocks){
      if (bl != this)
        ret = (ret && !underMe(bl) );
    }
    return ret;
  }
  //returns whether a Block is under me (and touching)
  boolean underMe(Block bl){
    boolean ret = false;
    ret = ( (bl.left >= left && bl.left <= right) || (bl.right >= left && bl.right <= right) );
    ret = (ret && ( bl.y <= y + yDim && bl.y >= y ) );
    return ret;
  }
  //returns whether this Block has reached the bottom of the screen
  boolean reachedFloor(){
    return y + yDim >= height;
  }
  
}