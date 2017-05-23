class BlueBirb extends Birb{
 
  //BlueBirbs spawned by special move
  BlueBirb up;
  BlueBirb down;
  
  BlueBirb(){
    super();
    loadedBirb = loadImage("img/blue_birb.png");
    loadedBirb.resize(40,40);
    image(loadedBirb, x, y);
    whichBirb = 1;
  }
  //constructor for new BlueBirbs
  BlueBirb(float newx,float newy,float newdx,float newdy){
   super();
   loadedBirb = loadImage("img/blue_birb.png");
   loadedBirb.resize(40,40);
   whichBirb = 1;
   launched = true;
   x = newx;
   y = newy;
   dx = newdx;
   dy = newdy;
  }
  
  void move(){
    //bounced off bottom edge
    if ( y > height ){
      y = height;
      dy *= -1;
    }
    //only have gravity act when birb is in the air, not on the "slingshot"  
    if(launched)
      dy += grav;
    x += dx;
    y += dy;
    loadedBirb = loadImage("img/yellow_birb.png");
    loadedBirb.resize(40,40);
    whichBirb = 1;  
    if ( up != null && down != null ){
      up.move();
      down.move();
    }    
  }
  
  void special(){
    if(collided)
      return;
    up = new BlueBirb(x,y,dx,dy + 1);
    down = new BlueBirb(x,y,dx,dy - 1);    
  }
  
}