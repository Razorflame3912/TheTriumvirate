Birb b;

float grav = .2;
float maxPull = 50;

void setup(){
  background(0);
  size(800,400);
  b = new YellowBirb();
}

void mouseDragged(){
 b.drag(); 
}

void mouseReleased(){
 b.shoot(); 
}

void mouseClicked(){
  b.special();
}
void draw(){
 background(0);
 b.move();
}