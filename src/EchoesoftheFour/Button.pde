class Button {
  String label;
  float x, y, w, h;
  boolean buttonHover;

  Button(String label, float x, float y, float w, float h) {
    this.label = label;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    buttonHover = false;
  }

  void display() {
    fill(255);
    stroke(0);
    rect(x, y, w, h, 10);

    fill(0);
    textAlign(CENTER, CENTER);
    textSize(16);
    text(label, x, y);
  }

  boolean clicked() {
    return (keyCode == ENTER);
  }
  boolean buttonHover() {
    return (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h);
  }
}
