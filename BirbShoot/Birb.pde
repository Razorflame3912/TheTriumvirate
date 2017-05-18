class Birb{
 
  final float initX;
  final float initY;
  float x;
  float y;
  float dx;
  float dy;
  float rad;
  color c;
  boolean launched;
  
  Birb(){
    x = 200;
    y = 200;
    initX = x;
    initY = y;
    dx = 0;
    dy = 0;
    rad = 20;
    c = color(255);
    launched = false;
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
    launched = true;
    dx = -(x - initX) / 10;
    dy = -(y - initY) / 10;
  }
  
  void move(){
    if ( y > height ){
      y = height;
      dy *= -1;
    }
    if(launched)
      dy += grav;
    x += dx;
    y += dy;
    ellipse(x,y,rad,rad);
  }
  
}