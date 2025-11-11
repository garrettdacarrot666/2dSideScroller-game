class Boss {
    //Member Variables
  int x, y, w, h, health;
  color c1;
  //PImage boss;
  
  //Constructor
  Boss (int x, int y, color c1) {
    this.x = x;
    this.y = y;
    w = 100;
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
