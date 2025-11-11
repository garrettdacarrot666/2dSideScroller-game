class Slope {
  //Member Variables
  int x, y, z, w, h, d;
  color c1;
  //PImage slope;

  //Constructor
  Slope (int x, int y, color c1) {
    this.x = x;
    this.y = y;
    z = 700;
    d = 200;
    w = 700;
    h = 700;
    this.c1 = c1;
  }


  //Member Methods
  void display () {
    fill(c1);
    triangle(x, y, z, d, w, h);
  }
}
