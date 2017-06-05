import java.util.LinkedList;
import java.util.Queue;
import java.util.Stack;

Birb redBirb;
Birb yellowBirb;
Birb blueBirb;
Birb b;

float grav = .2;
float maxPull = 50;
int gameScreen;
int points;
Stack<Integer> pointsHistory = new Stack();
int hp;
int whichLevel = 1;
Queue<Birb> birbQueue = new LinkedList();

PImage bg, bg2, bg3, bg4, red, blue, yellow, pig;
PImage slingshot;

void setup() {
  size(800, 400);
  bg = loadImage("img/titlescreen.png");
  bg2 = loadImage("img/background.png");
  bg2.resize(800, 400);
  bg3 = loadImage("img/gameoverscreen.png");
  bg3.resize(800, 400);
  bg4 = loadImage("img/matchhistoryscreen.png");
  bg4.resize(800,400);
  slingshot= loadImage("img/slingshot.png");
  slingshot.resize(100, 100);
  blue = loadImage("img/blue_birb.png");
  blue.resize(40, 40);
  red = loadImage("img/red_birb.png");
  red.resize(50, 50);
  yellow = loadImage("img/yellow_birb.png");
  yellow.resize(50, 50);
  pig = loadImage("img/pig.png");
  pig.resize(40,40);
  gameScreen = 0;
  points = 0;
  hp = 100;
  redBirb = new RedBirb();
  yellowBirb = new YellowBirb();
  blueBirb = new BlueBirb();
  birbQueue.add(blueBirb);
  birbQueue.add(yellowBirb);
  birbQueue.add(redBirb);
  b = birbQueue.peek(); 
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
  if (mouseX > 365 && mouseX < 435 && mouseY < 391 && mouseY > 345 
    && gameScreen == 0) {
    gameScreen = 3;
  }
  if (mouseX > 355 && mouseX < 450 && mouseY > 260 && mouseY < 317 && gameScreen == 2) {
    gameScreen = 0;
  }
  
  if (mouseX > 675 && mouseX < 760 && mouseY > 22 && mouseY < 88 && gameScreen == 3) {
    gameScreen = 0;
  }
}

void updateBirb() {
  if (b.x < 0 || b.y < 0 || b.x > 775 || b.y > 375 || hp <= 0 ) {
    birbQueue.remove();
    b = birbQueue.peek();
  }
}

void repopulateBirbQueue() {
  blueBirb = new BlueBirb();
  birbQueue.add(blueBirb);
  birbQueue.add(yellowBirb);
  birbQueue.add(redBirb);
  b = birbQueue.peek(); 
}

void draw() {

  if (gameScreen == 0) {
    titleScreen();
  }

  if (gameScreen == 1) {
    gameScreen();
    if (b != null) {
      b.move();
      updateBirb();
    }
    else {
      gameScreen = 2;
      b = new RedBirb();
      if (pointsHistory.size() < 5) {
        pointsHistory.push(points);
      }
      else {
        pointsHistory.pop();
        pointsHistory.push(points);
      }
      points = 0;
    }
  }
  
  if (gameScreen == 2) {
    gameOverScreen();
  }
  
  if (gameScreen == 3) {
    matchHistoryScreen();
  }
  
}

void titleScreen() {
  background(bg);
}

void gameScreen() {

  text(points, 20, 20);
  background(bg2);
  image(slingshot, 50, 275);
  image(pig, 650, 320);
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

void matchHistoryScreen() {
  int ctr = 75;
  background(bg4);
  textSize(20);
  while(!(pointsHistory.empty())) {
    text(pointsHistory.pop(), ctr, 330);
    ctr += 120;
  }
  fill(255,255,255);
}

int increasePoints(int incr) {
  points += incr;
  return points;
}

int decreaseHealth(int incr) {
  hp -= incr;
  return hp;
}