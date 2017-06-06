class Pig{
  
  float health,rad,mass,x,y,dx,dy;
  
  Pig(){
    //super();
    rad = 50;
    mass = 50;
    health = 25;
    dx = 0;
    dy = 0;
  }
  Pig(float xcor,float ycor){
    this();
    x = xcor;
    y = ycor;
  }
  /*      
  void getHit() {
    for(Ball b : balls) {
      if( dist( x , y , b.x , b.y) <= rad/2 + b.rad/2 ){
        health -= sqrt( sq(b.dx) + sq(b.dy) ) * b.mass;
        //impact was enough to kill pig
        if(health <= 0){
          //killPig(p);
          b.dx *= 0.5;
          b.dy *= 0.5;
        }
        //impact was not strong enough
        else{
          //ball's direction is opposite the side of pig hit (traveling right, hit left side)
          if( (b.x - x) * dx >= 0){ 
            b.dx *= -1 * inelastic;
            b.dy *= -1 * inelastic;
          }
          //ball traveling right and hit right side of pig, or left and left
          else
            b.dy *= -1;
        }
      }
    }
  }
  */
}