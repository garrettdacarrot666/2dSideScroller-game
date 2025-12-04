class Player {
  // Member Variable
  int x, y, w, h, speed;
  color c1;
  boolean isOnGround;
  PVector location, velocity, gravity, rightFriction, leftFriction, airFrictionRight, airFrictionLeft;
  Platform currentPlatform;
  Slope currentSlope;

  // Constructor
  Player(int x, int y, color c1) {
    this.x = x;
    this.y = y;
    w = 53;
    h = 93;
    speed = 5;
    this.c1 = c1;
    location = new PVector(100, 100);
    velocity = new PVector(0, 2.1);
    gravity = new PVector(0, 1);
    rightFriction = new PVector(0.5, 0);
    leftFriction = new PVector(-0.5, 0);
    airFrictionRight = new PVector(0.25, 0);
    airFrictionLeft = new PVector(-0.25, 0);
    isOnGround = false;
    //currentPlatform = null;
  }

  // Member Methods
  void display() {
    fill(c1);
    rectMode(CENTER);
    rect(location.x, location.y, w, h);
  }
  void update() {
    location.add(velocity);
    velocity.add(gravity);
    if (isOnGround && velocity.x < 0) {
      velocity.add(rightFriction);
    }
    if (isOnGround && velocity.x > 0) {
      velocity.add(leftFriction);
    }
    if (isOnGround == false && velocity.x < 0) {
      velocity.add(airFrictionRight);
    } else if (velocity.x >= 0) {
      velocity.sub(airFrictionRight);
    }
    if (isOnGround == false && velocity.x > 0) {
      velocity.add(airFrictionLeft);
    } else if (velocity.x <= 0) {
      velocity.sub(airFrictionLeft);
    }
    if (velocity.x < -6) {
      velocity.x = -6;
    }
    if (velocity.x > 6) {
      velocity.x = 6;
    }
    isOnGround = false;
    currentPlatform = null;
    //currentSlope = null;

    if (location.x >= width) {
      location.x = 0;
    } else if (location.x <= 0) {
      location.x = width;
    }

    int groundLevel = height - 50;
    if (location.y >= groundLevel) {
      location.y = groundLevel;
      velocity.y = 0;
      isOnGround = true;
    }

    for (Platform p : platforms) {
      if (isCollidingWith(p)) {
        if (velocity.y > 0 && location.y + h/2 >= p.y - p.h/2 && location.y + h/2 <= p.y - p.h/2 + 25) {
          location.y = p.y - p.h/2 - h/2;
          velocity.y = 0;
          isOnGround = true;
          currentPlatform = p;
        }
      }
    }
    for (Slope s : slopes) {
      if (location.x >= min(s.x1, s.x2) && location.x <= max(s.x1, s.x2) && location.y >= min(s.y1, s.y2) && location.y <= max(s.y1, s.y2)) {
        float t = (location.x - s.x1) / (s.x2 - s.x1);
        float slopeY = s.y1 + t * (s.y2 - s.y1);
        if (location.y + w/2 > slopeY) {
        location.y = slopeY - w/2;
          velocity.y = 0;
          isOnGround = true;
          currentSlope = s;
        }
      }
    }
  }

  boolean isCollidingWith(Platform p) {
    return location.x + w/2 > p.x - p.w/2 && // Horizontal overlap
      location.x - w/2 < p.x + p.w/2 && location.y + h/2 > p.y - p.w/2 && location.y - h/2 < p.y + p.w/2;
  }

  //boolean isTouching(Slope s) {
  //  return location.x >= min(s.x1, s.x2) && location.x <= max(x1, x2))
  //}

  void moveLeft () {
    velocity.add(-3, 0);
  }

  void moveRight () {
    velocity.add(3, 0);
  }

  void jump () {
    if (isOnGround) {
      velocity.add(0, -15);
    }
  }
  void doubleJump () {
    if (isOnGround == false) {
      velocity.add(0, -13);
    }
  }
}
