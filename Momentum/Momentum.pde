ArrayList<Ball> balls;
//Ball[] balls;
Ball[] floor;
ArrayList<Block> blocks;

float grav = 0;
float inelastic = 0.5;
Level L;
void setup() {
  size(700, 700);
  background(0);
  stroke(0);
  frameRate(120);
  balls = new ArrayList<Ball>();
  //for (int x=0; x < balls.size(); x++) {
  balls.add(new Ball());
  balls.get(0).x = 100;
  balls.get(0).y = 1 + ((0%2+1));
  balls.get(0).dx = 2;
  balls.get(0).dy = 2 + ((0%2) * -6);
  balls.get(0).mass = 1;
  //}

  floor = new Ball[0];
  for (int i = 0; i < floor.length; i ++) {
    floor[i] = new Ball();
    floor[i].x = 70 * i;
    floor[i].y = height - 10;
    floor[i].rad = 70;
    floor[i].dx = 0;
    floor[i].dy = 0;
    floor[i].mass = 10;
    floor[i].inFloor = true;
  }
  for (Ball b : floor) {
    balls.add(b);
  }
  blocks = new ArrayList<Block>();  
  blocks.add(new Block(50, 300, 100, 100));
  blocks.add(new Block(50, 300, 100, 200) );
  blocks.add(new Block(50, 300, 100, 300) );

  L = new Level();
  L.addBlocks(blocks);
}

void draw() {
  background(0);

  for (Ball b : balls) {
    b.collided = false;
  }
  for (Ball b : balls) {
    //fill(b.c);
    if (!b.inFloor) {
      if (!b.collided || (b.myBlock != null && !b.myBlock.checkCollide())) {
        b.collision();
      }
    }
    //ellipse(b.x, b.y, b.rad, b.rad);
  }

  //Ball last = block.subs[block.subs.length - 1];  
  //float xcor = last.x;
  //float ycor = last.y;

  for (Block bl : blocks) {
    bl.update();
  }

  for (Block bl : blocks) {
    if (!bl.checkCollide()) {
      bl.progress();
    }
    bl.stickEmAll();
    for (Ball b : bl.subs) {
      fill (b.c);
      ellipse(b.x, b.y, b.rad, b.rad);
    }
  }
  /*
  for (Ball b : floor) {
   b.update();
   ellipse(b.x, b.y, b.rad, b.rad);
   }*/

  for (Ball b : balls) {
    if (!b.inBlock) {
      fill(b.c);
      b.update();
      ellipse(b.x, b.y, b.rad, b.rad);
    }
  }
  //Ball last = block.subs[block.subs.length - 1];

  //L.loadBlocks();
  //translate(last.x - xcor,last.y - ycor);
}