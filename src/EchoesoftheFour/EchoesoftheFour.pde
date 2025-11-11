// Aidan Stephen | 28 Oct 2025 | Object Tester
Player gerald;
BackGround b1;
Boss fascist;
Element e1;
Platform p1;
Slope s1;
boolean rightPress, leftPress, upPress, doubleJump, canJump;

void setup() {
  size(750, 500);
  gerald = new Player(width/2, height-25, color(0, 0, 255));
  fascist = new Boss(width/2, height/2, color(255, 0, 0));
  b1 = new BackGround(width/2, height/2, color(0, 0, 0, 125));
  e1 = new Element(75, height - 75, color(223, 115, 255));
  p1 = new Platform(375, height, color(0));
  s1 = new Slope(200, 700, color(0));
  rightPress = false;
  leftPress = false;
  upPress = false;
  doubleJump = false;
  canJump = false;
}

void draw() {
  background(130);
  //fill(0);
  //rect(250, height, width, 50);
  p1.display();
  e1.display();
  s1.display();
  fascist.display();
  b1.display();
  gerald.display();
  if (leftPress == true) {
    gerald.moveLeft();
  }
  if (rightPress == true) {
    gerald.moveRight();
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
}

void keyPressed() {
  if (keyCode == UP) {
    upPress = true;
  }
  if (keyCode == LEFT) {
    leftPress = true;
  }
  if (keyCode == RIGHT) {
    rightPress = true;
  }
  if (keyCode == UP && gerald.isOnGround == false && canJump == true) {
    doubleJump = true;
    canJump = false;
  }
}
void keyReleased() {
  if (keyCode == LEFT) {
    leftPress = false;
  }
  if (keyCode == RIGHT) {
    rightPress = false;
  }
  if (keyCode == UP) {
    upPress = false;
  }
}
