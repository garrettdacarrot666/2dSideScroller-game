// Aidan Stephen | 28 Oct 2025 | Object Tester
Player gerald;
ArrayList<Platform> platforms;
BackGround b1;
Button btnPlay, btnMenu, btnGiveUp;
Boss fascist;
Element e1;
Slope s1;
boolean rightPress, leftPress, upPress, doubleJump, canJump, idleImageRight, idleImageLeft;
import gifAnimation.*;
Gif walkRight, walkLeft;
PImage baseWizardRight, baseWizardLeft, background;
char screen = 's';

void setup() {
  size(750, 500);
  gerald = new Player(width/2, height-25, color(0, 0, 255, 0));
  fascist = new Boss(width/2, height/2, color(255, 0, 0));
  b1 = new BackGround(width/2, height/2, color(0, 0, 0, 125));
  e1 = new Element(75, height - 75, color(223, 115, 255));
  s1 = new Slope(200, 700, color(0));
  btnPlay = new Button("Start Game", width/2, height/2, 100, 50);
  btnMenu = new Button("Menu", 100, 50, 100, 50);
  btnGiveUp = new Button("Give Up", 100, 50, 100, 50);
  rightPress = false;
  leftPress = false;
  upPress = false;
  doubleJump = false;
  canJump = false;
  idleImageRight = true;
  idleImageLeft = false;
  platforms = new ArrayList<Platform>();
  platforms.add(new Platform(100, height-150, 100, 50, color(0)));
  platforms.add(new Platform(450, height-400, 100, 50, color(0)));
  walkRight = new Gif(this, "walkingWizardRight.gif");
  walkLeft = new Gif(this, "walkingWizardLeft.gif");
  baseWizardRight = loadImage("baseWizard.png");
  baseWizardLeft = loadImage("baseWizardleft.png");
  background = loadImage("backGround.png");
}

void draw() {
  background(0);
  switch(screen) {
  case 's':
    background(0);
    drawStart();
    break;
  case 'p':
    background(130);
    drawPlay();
    break;
  case 'g':
    drawGiveUp();
    break;
  }
}
//Garrett Nelson
void drawStart() {
  background(0);
  image(background, 0, 0);
  btnPlay.clicked();
}

//Aidan Stephen
void drawPlay() {
  background(130);
  //fill(0);
  //rect(250, height, width, 50);
  //e1.display();
  //s1.display();
  //fascist.display();
  gerald.update();
  //gerald.display();
  b1.display();


  for (Platform p : platforms) {
    p.display();
  }

  if (leftPress == true) {
    gerald.moveLeft();
    imageMode(CENTER);
    image(walkLeft, gerald.location.x, gerald.location.y);
    walkLeft.play();
  }
  if (rightPress == true) {
    gerald.moveRight();
    //myAnimation.resize(50, 50);
    imageMode(CENTER);
    image(walkRight, gerald.location.x, gerald.location.y);
    walkRight.play();
  }
  if (upPress == true) {
    gerald.jump();
    upPress = false;
  }
  if (doubleJump == true) {
    gerald.doubleJump();
    doubleJump = false;
  }
  if (gerald.isOnGround == true) {
    canJump = true;
  }
  if (idleImageRight == true) {
    imageMode(CENTER);
    image(baseWizardRight, gerald.location.x, gerald.location.y);
  }
  if (idleImageLeft == true) {
    imageMode(CENTER);
    image(baseWizardLeft, gerald.location.x, gerald.location.y);
  }
  btnGiveUp.display();
  btnGiveUp.clicked();
}

void mousePressed() {
  switch(screen) {
  case 'p':
    if (btnGiveUp.buttonHover()) {
      screen = 'g';
    }
  }
}
//Aidan Stephen
void drawGiveUp() {
  background(0);
  textAlign(CENTER);
  textSize(32);
  text("You Coward", width/2, height/2);
}

void keyPressed() {
  switch(screen) {
  case 's':
    if (btnPlay.clicked()) {
      screen = 'p';
    }
  }

  if (keyCode == UP) {
    upPress = true;
  }
  if (keyCode == LEFT) {
    leftPress = true;
    idleImageRight = false;
    idleImageLeft = false;
    walkRight.pause();
  }
  if (keyCode == RIGHT) {
    rightPress = true;
    idleImageRight = false;
    idleImageLeft = false;
    walkLeft.pause();
  }
  if (keyCode == UP && gerald.isOnGround == false && canJump == true) {
    doubleJump = true;
    canJump = false;
  }
}
void keyReleased() {
  if (keyCode == LEFT) {
    leftPress = false;
    idleImageLeft = true;
    idleImageRight = false;
    walkLeft.pause();
  }
  if (keyCode == RIGHT) {
    rightPress = false;
    idleImageRight = true;
    idleImageLeft = false;
    walkRight.pause();
  }
  if (keyCode == UP) {
    upPress = false;
  }
}
