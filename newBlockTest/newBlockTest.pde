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

void setup() {
  size(800, 400);
  //blocks = new ArrayList<Block>();
  //blocks.add( new Block() );
  //blocks.add( new Block(400,450,400,400) );
  //levels = new DLList();
  //level = levels.get(0);
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