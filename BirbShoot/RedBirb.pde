class RedBirb extends Birb{
 
  RedBirb(){
    super();
    whichBirb = 0;
  }
  
  void move(){
    //bounced off bottom edge
    if ( y > height ){
      y = height;
      dy *= -0.5;
    }
    //only have gravity act when birb is in the air, not on the "slingshot"  
    if(launched)
      dy += grav;
      
    x += dx;
    y += dy;
    
    loadedBirb = loadImage("img/red_birb.png");
    loadedBirb.resize(50,50);
    image(loadedBirb,x,y);
    whichBirb = 0;  
    
  }
  
  void special(){
    return;
  }
}