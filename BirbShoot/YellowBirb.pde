class YellowBirb extends Birb{
 
  YellowBirb(){
   super();
   c = color(255,255,0);
   fill(c);
   ellipse(x,y,rad,rad);
  }
  void special(){
   dx *= 3;
   dy *= 3;
  }
}