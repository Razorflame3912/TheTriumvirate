Birb b;

float grav = .2;
float maxPull = 50;
int gameScreen;

void setup(){
  background(0);
  size(800,400);
  b = new YellowBirb();
}

void mouseDragged(){
 b.drag(); 
}

void mouseReleased(){
 b.shoot(); 
}

void mouseClicked(){
  b.special();
}

void mousePressed(){
  if (mouseX > 310 && mouseX < 495 && mouseY > 175 && mouseY < 250 
  && gameScreen == 0) {
    gameScreen = 1;
  }
}

PImage bg;
PImage slingshot;

void draw(){
 
 if (gameScreen == 0) {
   bg = loadImage("img/titlescreen.png");
   
   bg.resize(800,400);
   
   background(bg);
   
 }
  
 if (gameScreen == 1) {
   bg = loadImage("img/background.png");
   slingshot = loadImage("img/slingshot.png");
   
   bg.resize(800,400);
   slingshot.resize(100,100);
   
   background(bg);
   image(slingshot, 50, 275);
   b.move();
 }
 
 if (gameScreen == 2) {
   
 }
 
}