class RedBirb extends Birb {

  RedBirb() {
    super();
    whichBirb = 0;
    //loadedBirb = red;
  }

  void move() {
    //bounced off bottom edge
    if ( y > height ) {
      y = height;
      dy *= -0.5;
    }
    //only have gravity act when birb is in the air, not on the "slingshot"  
    if (launched)
      dy += grav;

    x += dx;
    y += dy;


    //image(loadedBirb, x, y);
    ellipse(x,y,50,50);
    whichBirb = 0;
  }

  void special() {
    return;
  }
}