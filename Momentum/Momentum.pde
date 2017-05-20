Block[] blocks;
float grav = .3;
void setup(){
  size(700,700);
  background(0);
  stroke(0);
  blocks = new Block[50];
  for(int x=0; x < blocks.length; x++){
    blocks[x] = new Block();
  }
  
}

void draw(){
  background(0);
  for(Block b: blocks){
   fill(b.c);
   b.update();
   ellipse(b.x,b.y,b.rad,b.rad);
  }
  
}