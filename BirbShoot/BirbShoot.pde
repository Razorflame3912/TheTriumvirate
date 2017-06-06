import java.util.LinkedList;
import java.util.Queue;
import java.util.Stack;

ArrayList<Ball> balls;
ArrayList<Block> blocks;
ArrayList<Pig> pigs;
Ball birbBall; //ball hidden behind a birb


Birb redBirb;
Birb yellowBirb;
Birb blueBirb;
Birb birb;

boolean birbLoaded; //whether there is a Birb in the slingshot
float grav = .001;
float inelastic = .5;
float maxPull = 25;
int gameScreen;
int points;
Stack<Integer> pointsHistory = new Stack();
int hp;
int whichLevel = 1;
boolean callPointsHistoryMethod = false;
Queue<Birb> birbQueue = new LinkedList();

Level L;

PImage bg, bg2, bg3, bg4, red, blue, yellow, pig;
PImage slingshot;

void setup() {
  size(800, 400);
  frameRate(10);
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
  points = 100;
  hp = 100;
  redBirb = new RedBirb();
  yellowBirb = new YellowBirb();
  blueBirb = new BlueBirb();
  birbQueue.add(blueBirb);
  birbQueue.add(yellowBirb);
  birbQueue.add(redBirb);
  birb = birbQueue.peek(); 
  birbLoaded = true;
  
  balls = new ArrayList<Ball>();
  //for (int x=0; x < balls.size(); x++) {
  balls.add(new Ball());
  //balls.get(0).x = 575;
  balls.get(0).x = 575;
  balls.get(0).y = 140;
  //balls.get(0).y = 1 + ((0%2+1));
  balls.get(0).dx = 0;
  balls.get(0).dy = 5;
  //balls.get(0).dy = 2 + ((0%2) * -6);
  balls.get(0).mass = 1;

  
  blocks = new ArrayList<Block>();  
  //blocks.add(new Block(50, 300, 100, 325, 1));
  blocks.add(new Block(50, 250, 475, 175,1) );
  blocks.add(new Block(50, 100, 575, 400,-1) );
  blocks.add(new Block(50, 100, 475, 400,-1) );
  blocks.add(new Block(50, 100, 675, 400,-1) );
  //blocks.add(new Block(50, 100, 475, 225,-1) );
  //blocks.add(new Block(50, 100, 675, 225,-1) );
  //blocks.add(new Block(50, 150, 525,  0,1) );
  
  //breakBlock(blocks.get(0));
  
  L = new Level();
  L.addBlocks(blocks);
  
  pigs = new ArrayList<Pig>();
  //pigs.add(new Pig(650,320));
  
  //birbBall = new Ball();
  
}

//to remove a Block with nonpositive health from the ArrayList of Blocks
void breakBlock(Block target) {
  if(birbLoaded)
    return;
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
  birb.drag();
}

void mouseReleased() {
  birb.shoot();
  //birbLoaded = false;
}

void mouseClicked() {
  birb.special();
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
  if (birb.x < 0 || birb.y < 0 || birb.x > 775 || birb.y > 375 || hp <= 0 ) {
    birbQueue.remove();
    birb = birbQueue.peek();
    birbLoaded = true;
  }
}

void repopulateBirbQueue() {
  blueBirb = new BlueBirb();
  birbQueue.add(blueBirb);
  birbQueue.add(yellowBirb);
  birbQueue.add(redBirb);
  birb = birbQueue.peek(); 
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
  //print(birbLoaded);
  //print(blocks.get(0).health + " ");
  //print(blocks.get(0).fallingOver);
  //print(blocks.get(1).reachedFloor());
  //print(blocks.size());
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
    //print(bl.flatOnTheFloor);
    
    if (bl.reachedFloor()) { //hit the floor
      for (Ball ball : bl.subs) {
        //b.y = height - b.rad;
        ball.dy = 0; //stop passing through the floor oh my god        
      }
      //if u pass thru the floor for some dumb reason move back up
      /* commented out because it doesn't work for some dumb reason
      if (bl.subs[0].y > height){
        float diff = bl.subs[0].y - height;
        for (Ball ball : bl.subs) {
          ball.y -= diff;
        }
      }
      */
      
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
    //else{
      bl.update();
    //}
  }
  //print(" ");

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
    if (birb != null) {
      birb.collision();
      birb.move();
      //birb.collision();
      //birb.hitStuff();
      updateBirb();
    }
    else {
      gameScreen = 2;
      b = new RedBirb();
      pointsHistory.push(points);
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
  text(points, 522, 175);
  fill(0);
}

void matchHistoryScreen() {
  int ctr = 65;
  int x = 0;
  background(bg4);
  while(x < pointsHistory.size() && x < 5) {
    callPointsHistoryMethod = true;
    textSize(20);
    fill(255,255,255);
    text(pointsHistory.peek(), ctr, 330);
    ctr += 120;
    x+=1;
    if (callPointsHistoryMethod) {
      if (pointsHistory.peek() != null) {
        pointsHistory.pop();
        callPointsHistoryMethod = false;
      }
      else {
        callPointsHistoryMethod = false;
      }
    }
  }
}

int increasePoints(int incr) {
  points += incr;
  return points;
}

int decreaseHealth(int incr) {
  hp -= incr;
  return hp;
}
