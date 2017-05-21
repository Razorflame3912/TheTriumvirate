class RedBirb extends Birb{
 
  RedBirb(){
    super();
    loadedBirb = loadImage("img/red_birb.png");
    loadedBirb.resize(50,50);
    image(loadedBirb, x, y);
    whichBirb = 0;
  }
  void special(){
    return;
  }
}