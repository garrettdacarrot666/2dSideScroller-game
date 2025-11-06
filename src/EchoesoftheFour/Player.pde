class Player {
  // Member Variable
  int x, y, w, h, speed;
  color c1;
  boolean isOnGround;
  PVector location, velocity, gravity, rightFriction, leftFriction;

  // Constructor
  Player(int x, int y, color c1) {
    this.x = x;
    this.y = y;
    w = 50;
    h = 50;
    speed = 5;
    this.c1 = c1;
    location = new PVector(100, 100);
    velocity = new PVector(0, 2.1);
    gravity = new PVector(0, 1);
    rightFriction = new PVector(0.5, 0);
    leftFriction = new PVector(-0.5, 0);
    isOnGround = false;
  }

  // Member Methods
  void display() {
    fill(c1);
    rectMode(CENTER);
    rect(location.x, location.y, w, h);
    location.add(velocity);
    velocity.add(gravity);
    if (isOnGround && velocity.x < 0) {
      velocity.add(rightFriction);
    }
    if (isOnGround && velocity.x > 0) {
      velocity.add(leftFriction);
    }
    if (velocity.x < -8) {
      velocity.x = -8;
    }
    if (velocity.x > 8) {
      velocity.x = 8;
    }
    if (location.y > height - 50 || location.y == height - 50) {
      velocity.y = 0;
      location.y = height - 50;
      isOnGround = true;
    } else {
      isOnGround = false;
    }
  }

  void moveLeft () {
    if (isOnGround) {
      velocity.add(-4, 0);
    }
  }

  void moveRight () {
    velocity.add(4, 0);
  }

  void jump () {
    if (isOnGround) {
      velocity.add(0, -15);
    }
  }
  void doubleJump () {
    if (isOnGround == false) {
      velocity.add(0, -13);
      //stop
    }
  }
}
