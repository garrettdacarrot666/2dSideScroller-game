class Water {
  //Member Variables
  int x, y, w, h;
  color c1;
  //PImage platform, ground;

  //Constructor
  Water (int x, int y, int w, int h, color c1) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c1 = c1;
  }


  //Member Methods
  void display () {
    fill(c1);
    rectMode(CENTER);
    rect(x, y, w, h);
  }
}
