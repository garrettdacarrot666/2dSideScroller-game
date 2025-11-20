PImage bg; //put in once you have image
float x = 0;

void setup() {
  size(800,600);
  bg = loadImage(""); //image put there
}

void draw() {
  background(135,206,255);
  
  image(bg, x, 0);   //draw image
  image(bg, x + bg.width, 0);     //draw second copy for seamless loop
  
  x -= 2;     //moves left
  
  //seamless wrap
  if (x <= -bg.width) x = 0;
}
