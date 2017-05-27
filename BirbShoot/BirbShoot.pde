Birb b;

float grav = .2;
float maxPull = 50;
int gameScreen;
int points;

PImage bg, bg2;
PImage slingshot;

void setup() {
  size(800, 400);
  bg = loadImage("img/titlescreen.png");
  bg2 = loadImage("img/background.png");
  bg2.resize(800, 400);
  slingshot= loadImage("img/slingshot.png");
  slingshot.resize(100, 100);
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
  }
}



void titleScreen() {
  background(bg);
}

void gameScreen() {
  text(points, 20, 20);
  background(bg2);
  image(slingshot, 50, 275);
}

void gameOverScreen() {
}