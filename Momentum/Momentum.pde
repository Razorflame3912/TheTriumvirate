Ball[] balls;
Block block;
float grav = 0;
float inelastic = .99;
void setup() {
  size(700, 700);
  background(0);
  stroke(0);
  balls = new Ball[1];
  for (int x=0; x < balls.length; x++) {
    balls[x] = new Ball();
    balls[x].x = 300;
    balls[x].y = 20;
    balls[x].dx = 0.5;
    balls[x].dy = 0.5;
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