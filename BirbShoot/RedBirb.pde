class RedBirb extends Birb{
 
  RedBirb(){
    super();
    c  = color(255,0,0);
    fill(c);
    ellipse(x,y,rad,rad);
  }
  void special(){
    return;
  }
}