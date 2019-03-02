
class Player {
  int time = millis();

  int fuel = 100;

  float xVelocity = 0;
  float yVelocity = 0;
  float initialX, initialY;
  float speed;
  int size;
  float rotate = (2*PI);
  char left, right, boost, shoot;
  int lives = 3;
  int r, g, b;

  int mass = 500000;

  float x;
  float y;

  boolean immunityFrames = true; 
  int frameFade = 255;
  boolean frameFadeBool = false;
  boolean winner = false;

  String playerName;

  char[] keysDown = new char[4];

  Player(float inX, float inY, float speed, int size, char left, char right, char boost, char shoot, int r, int g, int b, String pName) {
    this.initialX = inX;
    this.initialY = inY;
    this.speed = speed;
    this.size = size;
    this.boost = boost;
    this.shoot = shoot;
    this.left = left;
    this.right = right;
    this.r = r;
    this.g = g;
    this.b = b;
    this.playerName = pName;
    x = inX;
    y = inY;
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(rotate);
    strokeWeight(2);
    fill(r, g, b, frameFade);
    triangle(size, size, 0, -size, -size, size);
    popMatrix();
  }
  
  void frameFade() {
    if (immunityFrames) {
      
      if(frameFadeBool) {
        frameFade += 255/25;
      } else if(frameFadeBool == false) {
        frameFade -= 255/25;
      }
      if(frameFade >= 255) {
        frameFadeBool = false;
      }
      if(frameFade <= 0) {
        frameFadeBool = true;
      }
    } else {
      frameFade = 255;
    }
  }

  void shoot() {
    if ( keysDown[3] == shoot) { 
      if (millis() > time + 500) 
      { 
        massBombs.add(new MassBomb(x + (sin(rotate) * 20), y - (cos(rotate) * 20), (-cos(rotate) * 3), (sin(rotate) * 3)));
        time = millis();
      }
    }
  }

  void spin() {
    if ( keysDown[0] == left) {
      rotate -= (2*PI)/100;
    }
    if ( keysDown[1] == right) {
      rotate += (2*PI)/100;
    }
  }

  void boost() {
    if ( keysDown[2] == boost) {
      // if (fuel > 0) {
      xVelocity += sin(rotate) * speed;
      yVelocity += -cos(rotate) * speed;
      // fuel -= 1;
      // }
    }
  }

  void applyVelocity() {
    x += xVelocity;
    y += yVelocity;
  }

  void playerKeyPressed() {
    if (key == left) {
      keysDown[0] = left;
      immunityFrames = false;
    }
    if (key == right) {
      keysDown[1] = right;
      immunityFrames = false;
    }
    if (key == boost) {
      keysDown[2] = boost;
      immunityFrames = false;
    }
    if (key == shoot) {
      keysDown[3] = shoot;
      immunityFrames = false;
    }
  }

  void playerKeyReleased() {
    if (key == left) {
      keysDown[0] = '/';
      immunityFrames = false;
    }
    if (key == right) {
      keysDown[1] = '/';
      immunityFrames = false;
    }
    if (key == boost) {
      keysDown[2] = '/';
      immunityFrames = false;
    }
    if (key == shoot) {
      keysDown[3] = '/';
      immunityFrames = false;
    }
  }

  void run() {
    display();
    applyVelocity();
    spin();
    shoot();
    boost();
    frameFade();
  }
}
