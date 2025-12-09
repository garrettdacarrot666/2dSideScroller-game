// Aidan Stephen | 28 Oct 2025 | Object Tester
Player gerald;
ArrayList<Platform> platforms;
ArrayList<Slope> slopes;
ArrayList<Water> water;
Button btnPlay, btnMenu, btnGiveUp;
Boss fascist;
Element e1;
Slope s1;
float x = 0;
boolean rightPress, leftPress, upPress, doubleJump, canJump, idleImageRight, idleImageLeft, canSwim;
import gifAnimation.*;
Gif walkRight, walkLeft, swimRight, swimLeft;
PImage baseWizardRight, baseWizardLeft, background, startscreen, grassBlock, grassSlope;
PFont font;
char screen = 's';

void setup() {
  size(1000, 750);
  gerald = new Player(width/2, height-25, color(0, 0, 255, 0));
  fascist = new Boss(width/2, height/2, color(255, 0, 0));
  e1 = new Element(75, height - 75, color(223, 115, 255));
  btnPlay = new Button("Start Game", width/2, height/2, 100, 50);
  btnMenu = new Button("Menu", 100, 50, 100, 50);
  btnGiveUp = new Button("Give Up", 100, 50, 100, 50);
  rightPress = false;
  leftPress = false;
  upPress = false;
  doubleJump = false;
  canJump = false;
  canSwim = false;
  idleImageRight = true;
  idleImageLeft = false;
  water = new ArrayList<Water>();
  water.add(new Water(1610, 500, 1000, 500, color(17, 215, 255)));
  slopes = new ArrayList<Slope>();
  slopes.add(new Slope(920, height, 1115, 185));
  platforms = new ArrayList<Platform>();
  platforms.add(new Platform(100, height-150, 100, 50, color(0)));
  platforms.add(new Platform(450, height-400, 100, 50, color(0)));
  platforms.add(new Platform(800, height-200, 100, 50, color(0)));
  walkRight = new Gif(this, "walkingWizardRight.gif");
  walkLeft = new Gif(this, "walkingWizardLeft.gif");
  baseWizardRight = loadImage("baseWizard.png");
  baseWizardLeft = loadImage("baseWizardleft.png");
  startscreen = loadImage("Startscreen.png");
  background = loadImage("forest.png");
  grassBlock = loadImage("grassBlock.png");
  grassSlope = loadImage("grassSlope.png");
  font = createFont("Herculanum-48.vlw", 64);
}

void draw() {
  textFont(font);
  background(0);
  //Screen Management
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
    background(130);
    drawGiveUp();
    break;
  }
}

void drawStart() {
  //Start Screen
  background(0);
  image(startscreen, 0, 0);
  startscreen.resize(1000, 750);
  btnPlay.clicked();
}


void drawPlay() {
  //What you see when you play
  imageMode(CORNER);
  background.resize(1000, 750);
  //Makes background image loop
  image(background, x, 0);
  image(background, x + background.width, 0);
  image(background, x - background.width, 0);
  if (x <= -background.width || x >= background.width) x = 0;
  //e1.display();
  //fascist.display();
  gerald.update();
  //gerald.display();

  //Makes platform have graphic
  for (Platform p : platforms) {
    imageMode(CENTER);
    image(grassBlock, p.x, p.y);
    grassBlock.resize(100, 50);
    //p.display();
    //if (p.offScreen()) {
    //  platforms.remove(p);
    //}
  }

  for (Slope s : slopes) {
    imageMode(CENTER);
    image(grassSlope, (s.x1 + s.x2) / 2, (s.y1 + s.y2) / 2);
    grassSlope.resize(s.x2 - s.x1, s.y2 + s.y1);
    //s.display();
  }

  for (Water m : water) {
    m.display();
  }

  //Walking animations, background moving with player, terrain moving with player
  if (leftPress == true) {
    gerald.moveLeft();
    imageMode(CENTER);
    image(walkLeft, gerald.location.x, gerald.location.y);
    walkLeft.play();
    if (gerald.location.x <= 250) {
      gerald.location.x = 250;
      x += 0.5;
      for (Platform p : platforms) {
        p.x -= gerald.velocity.x;
      }
      for (Slope s : slopes) {
        s.x1 -= gerald.velocity.x;
        s.x2 -= gerald.velocity.x;
      }
      for (Water m : water) {
        m.x -= gerald.velocity.x;
      }
    }
  }
  if (rightPress == true) {
    gerald.moveRight();
    imageMode(CENTER);
    image(walkRight, gerald.location.x, gerald.location.y);
    walkRight.play();
    if (gerald.location.x >= 750) {
      gerald.location.x = 750;
      x -= 0.5;
      for (Platform p : platforms) {
        p.x -= gerald.velocity.x;
      }
      for (Slope s : slopes) {
        s.x1 -= gerald.velocity.x;
        s.x2 -= gerald.velocity.x;
      }
      for (Water m : water) {
        m.x -= gerald.velocity.x;
      }
    }
  }
  if (rightPress == true && gerald.isInWater == true) {
    gerald.moveRight();
    imageMode(CENTER);
    image(swimRight, gerald.location.x, gerald.location.y);
    swimRight.play();
    if (gerald.location.x >= 750) {
      gerald.location.x = 750;
      x -= 0.5;
      for (Platform p : platforms) {
        p.x -= gerald.velocity.x;
      }
      for (Slope s : slopes) {
        s.x1 -= gerald.velocity.x;
        s.x2 -= gerald.velocity.x;
      }
      for (Water m : water) {
        m.x -= gerald.velocity.x;
      }
    }
  }
  if (leftPress == true && gerald.isInWater == true) {
    gerald.moveLeft();
    imageMode(CENTER);
    image(swimLeft, gerald.location.x, gerald.location.y);
    swimLeft.play();
    if (gerald.location.x >= 750) {
      gerald.location.x = 750;
      x -= 0.5;
      for (Platform p : platforms) {
        p.x -= gerald.velocity.x;
      }
      for (Slope s : slopes) {
        s.x1 -= gerald.velocity.x;
        s.x2 -= gerald.velocity.x;
      }
      for (Water m : water) {
        m.x -= gerald.velocity.x;
      }
    }
  }

  //This is the check for how player moves, if can jump and double jump
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
  btnGiveUp.buttonHover();
}


//Give up Button
void mousePressed() {
  switch(screen) {
  case 'p':
    if (btnGiveUp.buttonHover()) {
      screen = 'g';
    }
  }
}

//Give up screen
void drawGiveUp() {
  background(0);
  textAlign(CENTER);
  textSize(32);
  text("You Coward", width/2, height/2);
  fill(255);
}

//Start to play
void keyPressed() {
  switch(screen) {
  case 's':
    if (btnPlay.clicked()) {
      screen = 'p';
    }
  }

  //More checks for movement
  if (keyCode == UP) {
    upPress = true;
  }
  if (keyCode == LEFT) {
    leftPress = true;
    idleImageRight = false;
    idleImageLeft = false;
    walkRight.pause();
    swimRight.pause();
  }
  if (keyCode == RIGHT) {
    rightPress = true;
    idleImageRight = false;
    idleImageLeft = false;
    walkLeft.pause();
    swimLeft.pause();
  }
  if (keyCode == UP && gerald.isOnGround == false && canJump == true) {
    doubleJump = true;
    canJump = false;
  }
}

//Even more movement checks
void keyReleased() {
  if (keyCode == LEFT) {
    leftPress = false;
    idleImageLeft = true;
    idleImageRight = false;
    walkLeft.pause();
    swimLeft.pause();
  }
  if (keyCode == RIGHT) {
    rightPress = false;
    idleImageRight = true;
    idleImageLeft = false;
    walkRight.pause();
    swimRight.pause();
  }
  if (keyCode == UP) {
    upPress = false;
  }
}
