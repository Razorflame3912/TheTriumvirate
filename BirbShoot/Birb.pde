class Birb{
 
  float x;
  float y;
  float dx;
  float dy;
  float rad;
  color c;
  
  Birb(){
    x = 200;
    y = 200;
    dx = 0;
    dy = -10;
    rad = 20;
    c = color(255);
    ellipse(x,y,rad,rad);
  }
  
  void drag(){
    if( dist(x,y,mouseX,mouseY) > rad){
      return;
    }
    background(0);
    x = mouseX;
    y = mouseY;
    fill(c);
    ellipse(x,y,rad,rad);
  }
  
  void shoot(){
    if( dist(x,y,mouseX,mouseY) > rad ){
      return;
    }
    dx = 5;
    dy = -5;
  }
  
  void move(){
    if ( y > height ){
      y = height;
      dy *= -1;
    }
    dy += grav;
    x += dx;
    y += dy;
    ellipse(x,y,rad,rad);
  }
  
}