class YellowBirb extends Birb{

  YellowBirb(){
   super();
   loadedBirb = loadImage("img/yellow_birb.png");
   loadedBirb.resize(50,50);
   image(loadedBirb, x, y);
   whichBirb = 2;
  }
  void special(){
    //unable to use special power after being hit or using it already
    if(!launched || collided || specialed)
      return;
    else{
      dx *= 3;
      dy *= 3;
      specialed = true;
    }
  }
}