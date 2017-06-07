import java.util.Queue;
import java.util.LinkedList;
import java.util.Stack;

ArrayList<Block> blocks;
ArrayList<Pig> pigs;
Stack<Integer> pointsHistory = new Stack();
Queue<Birb> birbQueue = new LinkedList();
Birb birb;
//DLList levels;
DLLNode levelNode;
Level level;
float grav = 0.1;
float inelastic = 0.75;
float maxPull = 50;
//Game screens
int gameScreen = 0;
//booleans
boolean resetGame = false;
//Images
PImage bg, bg2, bg3, bg4, red, blue, yellow, pig, slingshot;

void setup() {
  size(800, 400);
  //blocks = new ArrayList<Block>();
  //blocks.add( new Block() );
  //blocks.add( new Block(400,450,400,400) );
  //levels = new DLList();
  //level = levels.get(0);
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
  levelNode = new DLLNode( new Level(1), null, null);
  //levels.add( new Level() );
  level = levelNode.getCargo();
  level.blox.add( new Block() );
  level.blox.add( new Block(400, 450, 400, 400) );
  blocks = level.blox;
  pigs = level.porks;
  birbQueue = level.angerys;

  levelNode.setNext( new DLLNode( new Level(2), levelNode, null) );
  Level two = levelNode.getNext().getCargo();
  two.blox.add( new Block() );
  two.blox.add( new Block(400, 450, 300, 100) );

  birb = birbQueue.peek();
  //birb = new RedBirb();
  
  nextLevel();
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

void breakBlock(Block target) {
  int i = 0;
  while (blocks.get(i) != target)
    i += 1;
  blocks.remove(i);
}

void updateBirb() {
  if (birb.x < 0 || birb.y < 0 || birb.x > 775 || birb.y > 375) {
    birbQueue.remove();
    birb = birbQueue.peek();
    //birbLoaded = true;
  }
}


void draw() {
  background(0);
  //nextLevel();
  for (Block bl : blocks) {
    bl.update();
    rect(bl.left, bl.y, bl.xDim, bl.yDim);
  }
  if (birb != null) {
    //birb.collision();
    //ellipse(birb.x,birb.y,birb.rad,birb.rad);
    birb.move();
    //birb.collision();
    //birb.hitStuff();
    print(sqrt( sq(birb.dx) + sq(birb.dy) )*birb.mass  + " ");
    birb.hitBlock();
    updateBirb();
  }
  
  //prevLevel();
}

int decreaseHealth(int incr) {
  birbQueue.peek().hp -= incr;
  return birbQueue.peek().hp;
}

void updateBirb() {
  if ((birbQueue.peek().x < 0 || birbQueue.peek().y < 0 || birbQueue.peek().x > 775 || birbQueue.peek().y > 375 || 
  birbQueue.peek().hp <= 0) && birbQueue.peek() != null ) {
    birbQueue.remove();
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
