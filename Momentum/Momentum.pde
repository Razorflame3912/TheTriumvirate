Ball[] balls;
float grav = 0.5;
float inelastic = .99;
void setup(){
  size(700,700);
  background(0);
  stroke(0);
  balls = new Ball[5];
  for(int x=0; x < balls.length; x++){
    balls[x] = new Ball();
  }
  
}

void draw(){
  background(0);
  for(Ball b: balls){
   fill(b.c);
   b.update();
   ellipse(b.x,b.y,b.rad,b.rad);
  }
  
}