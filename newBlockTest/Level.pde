import java.util.Queue;
import java.util.LinkedList;

class Level{
  
  ArrayList<Block> blox; //to differentiate between blocks in driver
  ArrayList<Pig> porks; 
  Queue<Birb> angerys; //birbs given for this level
  
  Birb redBirb = new RedBirb();
  Birb blueBirb = new BlueBirb();
  Birb yellowBirb = new YellowBirb();
  
  Pig pig = new Pig();
  
  Level(){
    blox = new ArrayList<Block>();
    porks = new ArrayList<Pig>();
    angerys = new LinkedList<Birb>();
  }
  
  //overloaded constructor, x determines what the level number is
  Level(int x) {
    this();
    if (x == 1) {
      for (int i = 0; i < 3; i++) {
        porks.add(pig);
      }
      angerys.add(redBirb);
      angerys.add(redBirb);
      angerys.add(redBirb);
    }
    if (x == 2) {
      for (int i = 0; i < 4; i++) {
        porks.add(pig);
      }
      angerys.add(blueBirb);
      angerys.add(yellowBirb);
      angerys.add(redBirb);
    }
  }
}