import java.util.LinkedList;
import java.util.Queue;
import java.util.Stack;


ArrayList<Block> blocks;
ArrayList<Pig> pigs;

Birb redBirb;
Birb yellowBirb;
Birb blueBirb;

Birb birb;

boolean birbLoaded; //whether there is a Birb in the slingshot
float grav = .05;
float inelastic = .5;
float maxPull = 25; //pullback length on slingshot
int gameScreen;
int points;
Stack<Integer> pointsHistory = new Stack();
int hp;
int whichLevel = 1;
boolean callPointsHistoryMethod = false;
boolean resetGame = false;
boolean callRepopulateMethod = false;
Queue<Birb> birbQueue = new LinkedList();
DLLNode levelNode;
Level level;

PImage bg, bg2, bg3, bg4, bg5, red, blue, yellow, pig, woodblock, iceblock, stoneblock;
PImage slingshot;

void setup() {
  size(800, 400);
  frameRate(100);
  bg = loadImage("img/titlescreen.png");
  bg2 = loadImage("img/background.png");
  bg2.resize(800, 400);
  bg3 = loadImage("img/gameoverscreen.png");
  bg3.resize(800, 400);
  bg4 = loadImage("img/matchhistoryscreen.png");
  bg4.resize(800, 400);
  bg5 = loadImage("img/gameoverscreenvictory.png");
  bg5.resize(800, 400);
  slingshot= loadImage("img/slingshot.png");
  slingshot.resize(100, 100);
  blue = loadImage("img/blue_birb.png");
  blue.resize(40, 40);
  red = loadImage("img/red_birb.png");
  red.resize(50, 50);
  yellow = loadImage("img/yellow_birb.png");
  yellow.resize(50, 50);
  pig = loadImage("img/pig.png");
  pig.resize(40, 40);
  woodblock = loadImage("img/woodblock.png");
  iceblock = loadImage("img/iceblock.png");
  stoneblock = loadImage("img/stoneblock.png");
  gameScreen = 0;
  points = 0;
  hp = 100;

  redBirb = new RedBirb();
  yellowBirb = new YellowBirb();
  blueBirb = new BlueBirb();
  birbQueue.add(blueBirb);
  birbQueue.add(yellowBirb);
  birbQueue.add(redBirb);
  birb = birbQueue.peek(); 
  birbLoaded = true;

  levelNode = new DLLNode( new Level(1), null, null);
  level = levelNode.getCargo();
  level.blox.add( new Block() ); //dimensions 300 x 50
  level.blox.add( new Block(300, 350, 300, 100) ); //dimensions 50 x 100
  level.blox.add( new Block(550, 600, 300, 100) ); //dimensions 50 x 100
  level.blox.add( new Block(350, 400, 50, 150) );
  level.blox.add( new Block(500, 550, 50, 150) );
  level.blox.add( new Block(350, 550, 0, 50) );
  blocks = level.blox;
  pigs = level.porks;
  //birbQueue = level.angerys;

  levelNode.setNext( new DLLNode( new Level(2), levelNode, null) );
  Level two = levelNode.getNext().getCargo();
  two.blox.add( new Block() );
  two.blox.add( new Block(400, 450, 300, 100) );

  //birb = birbQueue.peek();
}  

//to remove a Block with nonpositive health from the ArrayList of Blocks
void breakBlock(Block target) {
  //if (birbLoaded)
  //return;
  int i = 0;
  while (blocks.get(i) != target)
    i += 1;
  blocks.remove(i);
  increasePoints(1000);
}

//to remove a pig (preferably when it dies)
void killPig(Pig target) {
  int i = 0;
  for (Pig p : pigs) {
    if (p == target) {
      pigs.remove(i);
      return;
    } else
      i += 1;
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
    resetGame = true;
    if (resetGame) {
      setup();
      resetGame = false;
    }
    gameScreen = 1;
  }
  if (mouseX > 365 && mouseX < 435 && mouseY < 391 && mouseY > 345 
    && gameScreen == 0) {
    gameScreen = 3;
  }
  if (mouseX > 355 && mouseX < 450 && mouseY > 260 && mouseY < 317 && (gameScreen == 2 || gameScreen == 4)) {
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
  /*
  birbQueue.add(blueBirb);
   birbQueue.add(yellowBirb);
   birbQueue.add(redBirb);
   */
  birbQueue = level.angerys;
  birb = birbQueue.peek();
}


void nextLevel() {
  levelNode = levelNode.getNext();
  level = levelNode.getCargo();
  blocks = level.blox;
  pigs = level.porks;
  birbQueue = level.angerys;
}

void prevLevel() {
  levelNode = levelNode.getPrev();
  level = levelNode.getCargo();
  blocks = level.blox;
  pigs = level.porks;
  birbQueue = level.angerys;
}

void draw() {

  if (gameScreen == 0) {
    titleScreen();
  }

  if (gameScreen == 1) {
    gameScreen();

    for (Block bl : blocks) {
      bl.update();
      woodblock.resize((int) bl.xDim, (int) bl.yDim);
      iceblock.resize((int) bl.xDim, (int) bl.yDim);
      stoneblock.resize((int) bl.xDim, (int) bl.yDim);
      image(woodblock, bl.left, bl.y);
    }
    for (Pig p : pigs) {
      image(pig, p.x, p.y);
    }
    if (birb != null && pigs.size() != 0) {
      birb.move();
      birb.hitBlock();
      birb.hitPig();
      updateBirb();
    }
    /*
    for (Block bl : blocks) {
     }
     
     int i = 0;
     while (i < blocks.size()) {
     if (blocks.get(i).health <= 0)
     breakBlock(blocks.get(i));
     else
     i += 1;
     }
     i = 0;
     while (i < pigs.size()) {
     if (pigs.get(i).health <= 0)
     killPig(pigs.get(i));
     else
     i += 1;
     }
     
     if (birb != null) {
     birb.move();
     //birb.hitStuff();
     updateBirb();
     } 
     */
    else {
      if (pigs.size() == 0) {
        gameScreen = 4;
        if (levelNode.getNext() != null)
          nextLevel();
        else {
          callRepopulateMethod = true;
          if (callRepopulateMethod) {
            repopulateBirbQueue();
            callPointsHistoryMethod = false;
          }
        }
        pointsHistory.push(points);
      } else {
        gameScreen = 2;
        callRepopulateMethod = true;
        if (callRepopulateMethod) {
          repopulateBirbQueue();
          callPointsHistoryMethod = false;
        }
        pointsHistory.push(points);
      }
    }
  }


  if (gameScreen == 2) {
    gameOverScreen();
  }

  if (gameScreen == 3) {
    matchHistoryScreen();
  }

  if (gameScreen == 4) {
    gameOverScreenVictory();
  }
}

void titleScreen() {
  background(bg);
}

void gameScreen() {

  text(points, 20, 20);
  background(bg2);
  image(slingshot, 50, 275);
  //image(pig, 650, 320);
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

void gameOverScreenVictory() {
  background(bg5);
  textSize(20);
  text(points, 522, 175);
  fill(0);
}

void matchHistoryScreen() {
  int ctr = 60;
  int x = 0;
  background(bg4);
  while (x < pointsHistory.size() && x < 5) {
    callPointsHistoryMethod = true;
    if (callPointsHistoryMethod) {
      if (pointsHistory.peek() != null) {
        textSize(20);
        text(pointsHistory.peek(), ctr, 330);
        fill(255, 255, 255);
        ctr += 150;
        x+=1;
        callPointsHistoryMethod = false;
      } else {
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