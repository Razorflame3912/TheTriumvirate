ArrayList<Block> blocks;
ArrayList<Pig> pigs;
ArrayList<Birb> birbs;
//DLList levels;
DLLNode levelNode;
Level level;
float grav = 0.1;
float maxPull = 50;

void setup(){
  size(800,800);
  //blocks = new ArrayList<Block>();
  //blocks.add( new Block() );
  //blocks.add( new Block(400,450,400,400) );
  //levels = new DLList();
  //level = levels.get(0);
  levelNode = new DLLNode( new Level(), null, null);
  //levels.add( new Level() );
  level = levelNode.getCargo();
  level.blox.add( new Block() );
  level.blox.add( new Block(400,450,400,400) );
  blocks = level.blox;
  
  levelNode.setNext( new DLLNode( new Level(), levelNode, null) );
  Level two = levelNode.getNext().getCargo();
  two.blox.add( new Block() );
  two.blox.add( new Block(400,450,400,200) );
  
}

void draw(){
  background(0);
  nextLevel();
  for(Block bl : blocks){
    bl.update();
    rect(bl.left,bl.y,bl.xDim,bl.yDim);
  }
  prevLevel();
}

void nextLevel(){
  levelNode = levelNode.getNext();
  level = levelNode.getCargo();
  blocks = level.blox;
  pigs = level.porks;
  birbs = level.angerys;
}

void prevLevel(){
  levelNode = levelNode.getPrev();
  level = levelNode.getCargo();
  blocks = level.blox;
  pigs = level.porks;
  birbs = level.angerys;
}