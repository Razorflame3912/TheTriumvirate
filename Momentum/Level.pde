import java.util.ArrayList;

class Level {
  ArrayList<Block> blocks;
  ArrayList<Pig> pigs;

  Level()
  {
    blocks = new ArrayList<Block>();
  }
  
  void addBlocks(ArrayList<Block> blcks)
  {
    for (Block bl : blcks) {
      blocks.add(bl);
    }
  }
  void loadBlocks()
  {
    for (Block b : blocks)
    {

      Ball first = b.subs[0];
      Ball last = b.subs[b.subs.length - 1];
      float tanTheta = (last.x - first.x)/(first.y - last.y);
      float theta = atan(tanTheta);
      translate( last.x, last.y );
      rotate(theta);
      //float heck = last.x * tanTheta;
      //translate(0,-heck);
      //float xcor = last.x;
      //float ycor = last.y;
      //rotate(theta);
      //float dist = dist(0,0,last.x,last.y);
      //translate(dist * sin(theta) * tanTheta, -dist * sin(theta) );
      translate( -last.x, -last.y );
      rect(last.x - last.rad/2, last.y - last.rad/2, last.rad, last.rad * b.subs.length);
      //rotate(-theta);
      //translate(last.x - xcor,last.y - ycor);
    }
  }
}