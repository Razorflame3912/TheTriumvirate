Ball[] balls;
Block block;
float grav = 0;
float inelastic = 0.99;
void setup() {
  size(700, 700);
  background(0);
  stroke(0);
  frameRate(120);
  balls = new Ball[1];
  for (int x=0; x < balls.length; x++) {
    balls[x] = new Ball();
    balls[x].x = 150;
    balls[x].y = 50 + ((x%2+1) * 300);
    balls[x].dx = 3;
    balls[x].dy = 1 + ((x%2+1) * -6);
    balls[x].mass = 1;
  }
  block = new Block(50, 300, 100, 100);
}

void draw() {
  background(0);
  for (Ball b : balls) {
    fill(b.c);
    b.update();
    ellipse(b.x, b.y, b.rad, b.rad);
  }
  block.update();
  for (Ball b : block.subs) {
    fill (b.c);
    ellipse(b.x, b.y, b.rad, b.rad);
  }
}