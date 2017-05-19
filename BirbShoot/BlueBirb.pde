class BlueBirb extends Birb{
 
  //BlueBirbs spawned by special move
  BlueBirb up;
  BlueBirb down;
  
  BlueBirb(){
    super();
    c = color(0,0,255);
    fill(c);
    ellipse(x,y,rad,rad);
  }
  //constructor for new BlueBirbs
  BlueBirb(float newx,float newy,float newdx,float newdy){
   super();
   c = color(0,0,255);
   fill(c);
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
    ellipse(x,y,rad,rad);  
    if ( up != null && down != null ){
      up.move();
      down.move();
    }    
  }
  
  void special(){
    up = new BlueBirb(x,y,dx,dy + 1);
    down = new BlueBirb(x,y,dx,dy - 1);    
  }
  
}