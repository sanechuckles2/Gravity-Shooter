
class MassBomb {
  float x, y;
  float xVelocity = 0;
  float yVelocity = 0;
  float size = 10;

  int mass = 700000;

  MassBomb(float x, float y, float yVel, float xVel) {
    this.x = x;
    this.y = y;
    this.xVelocity = xVel;
    this.yVelocity = yVel;
  }

  void display() {
    fill(100, 100, 100);
    strokeWeight(2);
    ellipse(x, y, size, size);
  }

  void applyVelocity() {
    x += xVelocity;
    y += yVelocity;
  }

  void run() {
    display();
    applyVelocity();
  }
}