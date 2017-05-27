Birb b;

float grav = .2;
float maxPull = 50;
int gameScreen;
int points;


PImage bg, bg2, bg3, red, blue, yellow;
PImage slingshot;

void setup() {
  size(800, 400);
  bg = loadImage("img/titlescreen.png");
  bg2 = loadImage("img/background.png");
  bg2.resize(800, 400);
  bg3 = loadImage("img/gameoverscreen.png");
  bg3.resize(800, 400);
  slingshot= loadImage("img/slingshot.png");
  slingshot.resize(100, 100);
  blue = loadImage("img/blue_birb.png");
  blue.resize(40, 40);
  red = loadImage("img/red_birb.png");
  red.resize(50, 50);
  yellow = loadImage("img/yellow_birb.png");
  yellow.resize(50, 50);
  gameScreen = 0;
  points = 0;
  b = new BlueBirb();
}

void mouseDragged() {
  b.drag();
}

void mouseReleased() {
  b.shoot();
}

void mouseClicked() {
  b.special();
}

void mousePressed() {
  if (mouseX > 310 && mouseX < 495 && mouseY > 175 && mouseY < 250 
    && gameScreen == 0) {
    gameScreen = 1;
  }
  if (mouseX > 355 && mouseX < 450 && mouseY > 260 && mouseY < 317 && gameScreen == 2) {
    gameScreen = 1;
  }
}



void draw() {

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



void titleScreen() {
  background(bg);
}

void gameScreen() {

  text(points, 20, 20);
  background(bg2);
  image(slingshot, 50, 275);
  textSize(20);
  text(points, 20, 30);
  fill(0);
}

void gameOverScreen() {
  background(bg3);
  textSize(20);
  text(points, 542, 175);
  fill(0);
}