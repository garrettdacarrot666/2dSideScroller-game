class Slope {
  //Member Variables
  int x1, y1, x2, y2;
  //PImage platform, ground;

  //Constructor
  Slope (int x1, int y1, int x2, int y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }


  //Member Methods
  void display () {
    stroke(255);
    strokeWeight(3);
    line(x1, y1, x2, y2);
  }
}
