Birb b;

float grav = .2;
float maxPull = 50;
int gameScreen;
int points;

void setup(){
  size(800,400);
  gameScreen = 0;
  points = 0;
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
  if (mouseX > 355 && mouseX < 450 && mouseY > 260 && mouseY < 317 && gameScreen == 2){
    gameScreen = 1;
  }
}

void draw(){
 
 if (gameScreen == 0) {
   titleScreen();
 }
  
 if (gameScreen == 1) {
   gameScreen();
   b.move();
 }
 
 if (gameScreen == 2) {
   gameOverScreen();
 }
 
}

PImage bg;
PImage slingshot;

void titleScreen() {
  bg = loadImage("img/titlescreen.png");
  background(bg);
}

void gameScreen() {
  bg = loadImage("img/background.png");
  bg.resize(800,400);
  background(bg);
  slingshot = loadImage("img/slingshot.png");
  slingshot.resize(100,100);
  image(slingshot, 50, 275);
  textSize(20);
  text(points, 20, 30);
  fill(0);
}

void gameOverScreen() {
  bg = loadImage("img/gameoverscreen.png");
  bg.resize(800,400);
  background(bg);
  textSize(20);
  text(points, 542, 175);
  fill(0);
}