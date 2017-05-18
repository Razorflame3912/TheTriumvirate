Birb b;
float grav = .5;

void setup(){
  background(0);
  size(400,400);
  b = new Birb();
}

void mouseDragged(){
 b.drag(); 
}

void mouseReleased(){
 b.shoot(); 
}

void draw(){
 background(0);
 b.move();
}