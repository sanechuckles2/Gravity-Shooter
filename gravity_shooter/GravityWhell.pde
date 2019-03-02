
class GravityWhell {
  float x, y;
  float mass;
  float radius;
  float xVelocity, yVelocity;

  GravityWhell(float x, float y, float mass, float radius, float xVelocity, float yVelocity) {
    this.x = x;
    this.y = y;
    this.mass = mass;
    this.radius = radius;
    this.xVelocity = xVelocity;
    this.yVelocity = yVelocity;
  }

  void display() {
    noFill();
    strokeWeight(2);
    stroke(255 - ((mass/1500000000) * 255));
    
    ellipse(x, y, radius, radius);
    ellipse(x, y, 1, 1);
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
