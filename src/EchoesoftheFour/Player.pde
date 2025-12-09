class Player {
  // Member Variable
  int x, y, w, h, speed;
  color c1;
  boolean isOnGround, isOnSlope, isInWater;
  PVector location, velocity, gravity, waterGravity, rightFriction, leftFriction, airFrictionRight, airFrictionLeft, waterFrictionRight, waterFrictionLeft;
  Platform currentPlatform;
  Slope currentSlope;
  Water currentWater;

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
    waterGravity = new PVector(0, 0.5);
    rightFriction = new PVector(0.5, 0);
    leftFriction = new PVector(-0.5, 0);
    airFrictionRight = new PVector(0.25, 0);
    airFrictionLeft = new PVector(-0.25, 0);
    waterFrictionRight = new PVector(0.75, 0);
    waterFrictionLeft = new PVector(-0.75, 0);
    isOnGround = false;
    isOnSlope = false;
    isInWater = false;
    //currentPlatform = null;
  }

  // Member Methods
  void display() {
    fill(c1);
    rectMode(CENTER);
    rect(location.x, location.y, w, h);
  }
  void update() {
    if (isInWater == false) {
      location.add(velocity);
      velocity.add(gravity);
    }
    if (isOnGround && velocity.x < 0) {
      velocity.add(rightFriction);
    }
    if (isOnGround && velocity.x > 0) {
      velocity.add(leftFriction);
    }
    if (isOnGround == false && isInWater == false && velocity.x < 0) {
      velocity.add(airFrictionRight);
    } else if (velocity.x >= 0) {
      velocity.sub(airFrictionRight);
    }
    if (isOnGround == false && isInWater == false && velocity.x > 0) {
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
    if (isInWater) {
      location.add(velocity);
      velocity.add(waterGravity);
      if (velocity.x < 0) {
        velocity.add(waterFrictionRight);
      }
      if (velocity.x > 0) {
        velocity.add(waterFrictionLeft);
      }
      if (velocity.x < -4) {
        velocity.x = -4;
      }
      if (velocity.x > 4) {
        velocity.x = 4;
      }
    }
    isOnGround = false;
    isOnSlope = false;
    isInWater = false;
    currentPlatform = null;
    currentSlope = null;
    currentWater = null;

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
          velocity.y = 7;
          velocity.x = -7;
          isOnSlope = true;
          isOnGround = false;
          currentSlope = s;
        }
      }
    }
    for (Water m : water) {
      if (isTouching(m)) {
        if (location.y + h/2 >= m.y - m.h/2 && location.y - h/2 >= m.y - m.h/2) {
          isOnGround = false;
          isInWater = true;
          currentWater = m;
        }
      }
    }
  }

  boolean isCollidingWith(Platform p) {
    return location.x + w/2 > p.x - p.w/2 && // Horizontal overlap
      location.x - w/2 < p.x + p.w/2 && location.y + h/2 > p.y - p.w/2 && location.y - h/2 < p.y + p.w/2;
  }
  boolean isTouching(Water m) {
    return location.x + w/2 > m.x - m.w/2 && // Horizontal overlap
      location.x - w/2 < m.x + m.w/2 && location.y + h/2 > m.y - m.w/2 && location.y - h/2 < m.y + m.w/2;
  }


  void moveLeft () {
    if (isOnSlope == true) {
      velocity.add(0, 0);
    } else if (isInWater == true) {
      velocity.add(-1.5, 0);
    } else if (isInWater == true && isOnGround == true) {
      velocity.add(-1.75, 0);
    } else {
      velocity.add(-3, 0);
    }
  }

  void moveRight () {
    if (isOnSlope == true) {
      velocity.add(0, 0);
    } else if (isInWater == true) {
      velocity.add(1.5, 0);
    } else if (isInWater == true && isOnGround == true) {
      velocity.add(1.75, 0);
    } else {
      velocity.add(3, 0);
    }
  }

  void jump () {
    if (isOnGround && isInWater == false) {
      velocity.add(0, -15);
    }
    if (isInWater && isOnGround) {
      velocity.add(0, -10);
    }
    if (isInWater && isOnGround == false) {
      velocity.add(0, -8);
    }
  }
  void doubleJump () {
    if (isOnGround == false && isInWater == false) {
      velocity.add(0, -13);
    }
  }
}
