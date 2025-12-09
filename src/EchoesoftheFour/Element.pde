class Element {
  //Member Variables
  int x, y, w, h, timer, speed;
  color c1;
  //PImage wheel, elements;

  //Constructor
  Element (int x, int y, color c1) {
    this.x = x;
    this.y = y;
    w = 100;
    h = 100;
    this.c1 = c1;
  }


  //Member Methods
  void display () {
    fill(c1);
    ellipseMode(CENTER);
    ellipse(x, y, w, h);
  }
}
