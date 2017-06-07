class YellowBirb extends Birb {

  YellowBirb() {
    super();
    whichBirb = 2;
    //loadedBirb = yellow;
  }

  void move() {
    //bounced off bottom edge
    if ( y > height ) {
      y = height;
      dy *= -0.5;
    }
    //only have gravity act when birb is in the air, not on the "slingshot"  
    if (launched) {
      dy += grav;
    }

    x += dx;
    y += dy;


    //image(loadedBirb, x, y);
    whichBirb = 2;
  }

  void special() {
    //unable to use special power after being hit or using it already
    if (!launched || collided || specialed) {
      return;
    }
    else {
      dx *= 3;
      dy *= 3;
      specialed = true;
    }
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
}