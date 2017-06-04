ArrayList<Ball> balls;
//Ball[] balls;
Ball[] floor;
ArrayList<Block> blocks;

float grav = 0.001;
float inelastic = 0.5;
Level L;
void setup() {
  size(1400, 700);
  background(0);
  stroke(0);
  frameRate(240);
  balls = new ArrayList<Ball>();
  //for (int x=0; x < balls.size(); x++) {
  balls.add(new Ball());
  balls.get(0).x = 200;
  balls.get(0).y = 300;
  //balls.get(0).y = 1 + ((0%2+1));
  balls.get(0).dx = 0;
  balls.get(0).dy = .01;
  //balls.get(0).dy = 2 + ((0%2) * -6);
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
  blocks.add(new Block(50, 300, 100, 325, 1));
  //blocks.add(new Block(50, 300, 100, 200,1) );
  blocks.add(new Block(50, 300, 350, 650,-1) );
  blocks.add(new Block(50, 300, 100, 650,-1) );

  //test breakBlock()
  //breakBlock(blocks.get(1));
  //breakBlock(blocks.get(0));
  L = new Level();
  L.addBlocks(blocks);
}

//to remove a Block with zero health from the ArrayList of Blocks
void breakBlock(Block target) {
  int i = 0;
  while (blocks.get(i) != target)
    i += 1;
  removeBalls(blocks.get(i)); //also remove all of that Block's balls from the ArrayList of Balls
  blocks.remove(i);
}

//to remove all Balls of a Block's array of Balls from the larger ArrayList of Balls
void removeBalls(Block target) {
  for (Ball deadBall : target.subs) { //for each Ball in that Block
    int i = 0;
    for (Ball b : balls) { //compare to each Ball in ArrayList of Balls until match
      if (deadBall == b) {
        balls.remove(i);
        break; //stop looping for this particular Ball if match was found
      } else
        i += 1;
    }
  }
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
    //print(bl.fallingOver); //for bug fixing
    print(bl.health + " ");
    //for(int i = 0;i < bl.subs.length - 1;i++)
    //bl.subs[i].stickMe(bl.subs[i],bl.subs[i+1]);

    if (bl.reachedFloor()) { //hit the floor
      for (Ball b : bl.subs) {
        //b.y = height - b.rad;
        b.dy = 0; //stop passing through the floor oh my god
      }
      //print(bl.fallingOver);
      if (!bl.flatOnTheFloor) { //hit the floor but not horizontal yet
        bl.fallingOver = true; //keep falling over 
        bl.fallOver(); //fall over a lil bit
      } else { //flat on the floor
        bl.friction();
        if (!bl.isVertical()) {
          for (Ball b : bl.subs)
            b.y = height - b.rad;
        }
        /*
        for(Ball b : bl.subs){
         b.dy = 0; //stop passing through the floor oh my god
         }
         */
      }
      bl.fallOver(); //fall over a lil bit
    }

    bl.update();
  }


  for (Block bl : blocks) {
    /*
    if (bl.reachedFloor()){
     bl.fallingOver = true;
     bl.fallOver();
     }
     */
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

  int i = 0;
  while(i < blocks.size()){
    if(blocks.get(i).health <= 0)
      breakBlock(blocks.get(i));
    else
      i += 1;
  }
  //Ball last = block.subs[block.subs.length - 1];

  //L.loadBlocks();
  //translate(last.x - xcor,last.y - ycor);
}