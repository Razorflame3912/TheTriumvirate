class YellowBirb extends Birb{

  YellowBirb(){
   super();
   loadedBirb = loadImage("img/yellow_birb.png");
   loadedBirb.resize(50,50);
   image(loadedBirb, x, y);
   whichBirb = 2;
  }
  void special(){
    if(collided)
      return;
   dx *= 3;
   dy *= 3;
  }
}