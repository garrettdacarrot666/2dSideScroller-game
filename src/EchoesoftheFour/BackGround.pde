class BackGround {
  //Member Variables
  int x, y, w, h;
  color c1;
  //PImage platform, ground;
  
  //Constructor
  BackGround (int x, int y, color c1) {
    this.x = x;
    this.y = y;
    w = 750;
    h = 500;
    this.c1 = c1;
  }
  
  
  //Member Methods
  void display () {
    fill(c1);
    rectMode(CENTER);
    rect(x, y, w, h);
  }
  
  
}
