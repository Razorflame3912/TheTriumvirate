import java.util.LinkedList;
import java.util.Queue;
import java.util.Stack;

ArrayList<Ball> balls;
ArrayList<Block> blocks;
ArrayList<Pig> pigs;

Birb redBirb;
Birb yellowBirb;
Birb blueBirb;
Birb b;

float grav = .001;
float inelastic = .5;
float maxPull = 50;
int gameScreen;
int points;
Stack<Integer> pointsHistory = new Stack();
int hp;
int whichLevel = 1;
Queue<Birb> birbQueue = new LinkedList();

Level L;

PImage bg, bg2, bg3, bg4, red, blue, yellow, pig;
PImage slingshot;

void setup() {
  size(800, 400);
  frameRate(240);
  bg = loadImage("img/titlescreen.png");
  bg2 = loadImage("img/background.png");
  bg2.resize(800, 400);
  bg3 = loadImage("img/gameoverscreen.png");
  bg3.resize(800, 400);
  bg4 = loadImage("img/matchhistoryscreen.png");
  bg4.resize(800,400);
  slingshot= loadImage("img/slingshot.png");
  slingshot.resize(100, 100);
  blue = loadImage("img/blue_birb.png");
  blue.resize(40, 40);
  red = loadImage("img/red_birb.png");
  red.resize(50, 50);
  yellow = loadImage("img/yellow_birb.png");
  yellow.resize(50, 50);
  pig = loadImage("img/pig.png");
  pig.resize(40,40);
  gameScreen = 0;
  points = 0;
  hp = 100;
  redBirb = new RedBirb();
  yellowBirb = new YellowBirb();
  blueBirb = new BlueBirb();
  birbQueue.add(blueBirb);
  birbQueue.add(yellowBirb);
  birbQueue.add(redBirb);
  b = birbQueue.peek(); 
  
  balls = new ArrayList<Ball>();
  //for (int x=0; x < balls.size(); x++) {
  balls.add(new Ball());
  balls.get(0).x = 550;
  balls.get(0).y = 25;
  //balls.get(0).y = 1 + ((0%2+1));
  balls.get(0).dx = 0;
  balls.get(0).dy = .01;
  //balls.get(0).dy = 2 + ((0%2) * -6);
  balls.get(0).mass = 1;
  
  blocks = new ArrayList<Block>();  
  //blocks.add(new Block(50, 300, 100, 325, 1));
  blocks.add(new Block(50, 300, 400, 75,1) );
  blocks.add(new Block(50, 300, 650, 400,-1) );
  blocks.add(new Block(50, 300, 400, 400,-1) );
  
  L = new Level();
  L.addBlocks(blocks);
  
  pigs = new ArrayList<Pig>();
  pigs.add(new Pig(650,320));
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

//to remove a pig (preferably when it dies)
void killPig(Pig target) {
  int i = 0;
  for (Pig p : pigs){
    if (p == target){
      pigs.remove(i);
      return;
    }
    else
      i += 1;
  }
}

void removeBall(Ball target){
  for(int i = balls.size() - 1;i >= 0;i --){
    if(balls.get(i) == target){
      balls.remove(i);
    }
  }
}

void mouseDragged() {
  b.drag();
}

void mouseReleased() {
  b.shoot();
}

void mouseClicked() {
  b.special();
}

void mousePressed() {
  if (mouseX > 310 && mouseX < 495 && mouseY > 175 && mouseY < 250 
    && gameScreen == 0) {
    gameScreen = 1;
  }
  if (mouseX > 365 && mouseX < 435 && mouseY < 391 && mouseY > 345 
    && gameScreen == 0) {
    gameScreen = 3;
  }
  if (mouseX > 355 && mouseX < 450 && mouseY > 260 && mouseY < 317 && gameScreen == 2) {
    gameScreen = 0;
  }
  
  if (mouseX > 675 && mouseX < 760 && mouseY > 22 && mouseY < 88 && gameScreen == 3) {
    gameScreen = 0;
  }
}

void updateBirb() {
  if (b.x < 0 || b.y < 0 || b.x > 775 || b.y > 375 || hp <= 0 ) {
    birbQueue.remove();
    b = birbQueue.peek();
  }
}

void repopulateBirbQueue() {
  blueBirb = new BlueBirb();
  birbQueue.add(blueBirb);
  birbQueue.add(yellowBirb);
  birbQueue.add(redBirb);
  b = birbQueue.peek(); 
}

void draw() {

  if (gameScreen == 0) {
    titleScreen();
  }

  if (gameScreen == 1) {
    gameScreen();
    for (Ball ball : balls) {
    ball.collided = false;
  }
  for (int i = balls.size() - 1; i > -1; i--) {
    Ball ball = balls.get(i);
    //fill(b.c);
    if (!ball.inFloor) {
      if (!ball.collided || (ball.myBlock != null && !ball.myBlock.checkCollide())) {
        ball.collision();
        ball.hitPig();
      }
    }
    //ellipse(b.x, b.y, b.rad, b.rad);
  }
  
  for (Pig p : pigs) {
    print(p.health + " ");
    //p.getHit();
    if(p.bounce())
      p.health -= sqrt( sq(p.dx) + sq(p.dy) ) * p.mass;
    p.update();
    ellipse(p.x,p.y,p.rad,p.rad);
  }
  
  //Ball last = block.subs[block.subs.length - 1];  
  //float xcor = last.x;
  //float ycor = last.y;

  for (Block bl : blocks) {
    //print(bl.fallingOver); //for bug fixing
    //print(bl.health + " ");
    //for(int i = 0;i < bl.subs.length - 1;i++)
    //bl.subs[i].stickMe(bl.subs[i],bl.subs[i+1]);

    if (bl.reachedFloor()) { //hit the floor
      for (Ball ball : bl.subs) {
        //b.y = height - b.rad;
        ball.dy = 0; //stop passing through the floor oh my god
      }
      //print(bl.fallingOver);
      if (!bl.flatOnTheFloor) { //hit the floor but not horizontal yet
        bl.fallingOver = true; //keep falling over 
        bl.fallOver(); //fall over a lil bit
      } else { //flat on the floor
        bl.friction();
        if (!bl.isVertical()) {
          for (Ball ball : bl.subs)
            ball.y = height - ball.rad;
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
    for (Ball ball : bl.subs) {
      fill (ball.c);
      ellipse(ball.x, ball.y, ball.rad, ball.rad);
    }
  }
  /*
  for (Ball b : floor) {
   b.update();
   ellipse(b.x, b.y, b.rad, b.rad);
   }*/

  for (Ball ball : balls) {
    if (!ball.inBlock) {
      fill(ball.c);
      ball.update();
      ellipse(ball.x, ball.y, ball.rad, ball.rad);
    }
  }

  int i = 0;
  while(i < blocks.size()){
    if(blocks.get(i).health <= 0)
      breakBlock(blocks.get(i));
    else
      i += 1;
  }
  i = 0;
  while(i < pigs.size()){
    if(pigs.get(i).health <= 0)
      killPig(pigs.get(i));
    else
      i += 1;
  }

  //L.loadBlocks();
  //translate(last.x - xcor,last.y - ycor);
    if (b != null) {
      b.move();
      updateBirb();
    }
    else {
      gameScreen = 2;
      b = new RedBirb();
      if (pointsHistory.size() < 5) {
        pointsHistory.push(points);
      }
      else {
        pointsHistory.pop();
        pointsHistory.push(points);
      }
      points = 0;
    }
  }
  
  if (gameScreen == 2) {
    gameOverScreen();
  }
  
  if (gameScreen == 3) {
    matchHistoryScreen();
  }
  
}

void titleScreen() {
  background(bg);
}

void gameScreen() {

  text(points, 20, 20);
  background(bg2);
  image(slingshot, 50, 275);
  image(pig, 650, 320);
  textSize(20);
  text(points, 20, 30);
  fill(0);
  
}

void gameOverScreen() {
  background(bg3);
  textSize(20);
  text(points, 542, 175);
  fill(0);
}

void matchHistoryScreen() {
  int ctr = 75;
  background(bg4);
  textSize(20);
  while(!(pointsHistory.empty())) {
    text(pointsHistory.pop(), ctr, 330);
    ctr += 120;
  }
  fill(255,255,255);
}

int increasePoints(int incr) {
  points += incr;
  return points;
}

int decreaseHealth(int incr) {
  hp -= incr;
  return hp;
}