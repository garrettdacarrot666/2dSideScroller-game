class Platform {
  //Member Variables
  int x, y, w, h, timer, speed;
  color c1;
  //PImage platform, ground;

  //Constructor
  Platform (int x, int y, color c1) {
    this.x = x;
    this.y = y;
    w = width;
    h = 100;
    this.c1 = c1;
  }


  //Member Methods
  void display () {
    fill(c1);
    rectMode(CENTER);
    rect(x, y, w, h);
  }
}
