class PacMan {

  float pacStartRad, pacEndRad;
  PVector pacPos, startPos;
  boolean up, down, left, right, stop;
  float vx = 1, vy = 1;
  int lives = 3;
  float nomvx = 0.03;//pacman mouth speed
  float pacSize, squareSize;
  float facingAngle = 0;
  final float maxOpenAngle = (45*PI)/180;//how wide pacman can open its mouth

  PacMan(float x, float y, float s) {
    pacPos = new PVector(x, y);
    startPos = new PVector(x, y);
    pacStartRad = (27.5*PI)/180;
    pacEndRad = (332.5*PI)/180;
    pacSize = s*0.75;
    squareSize = s;
  }

  void redraw(float angle) {
    noStroke();
    if (pacPos.x > width) {//wrap around
      pacPos.x = 0;
    }
    if (pacPos.x < 0) {
      pacPos.x = width;
    }
    pushMatrix();
    translate(pacPos.x, pacPos.y);
    rotate(angle);//rotate to show facing correct direction
    pacStartRad-=nomvx;//animate mouth
    pacEndRad+=nomvx;
    if (pacStartRad < 0 || pacStartRad > maxOpenAngle) {//open/close mouth when too wide or closed
      nomvx = nomvx*-1;
    }
    fill(255, 255, 0);
    arc(0, 0, pacSize, pacSize, pacStartRad, pacEndRad);
    fill(0);
    ellipse(-pacSize/6, -pacSize/8, pacSize/5, pacSize/5);
    popMatrix();
  }

  PVector getPacPos() {//get position
    return pacPos;
  }

  void revive() {//send back to start position
    pacPos.set(startPos);
  }

  float getSize() {//get size of pacman
    return pacSize;
  }

  void goUp(boolean u) {//set direction booleans
    up = u;
  }

  void goDown(boolean d) {
    down = d;
  }

  void goLeft(boolean l) {
    left = l;
  }
  void goRight(boolean r) {
    right = r;
  }

  boolean hitGhost(Ghost goo) {//return true if too close to a ghost
    return (pacPos.dist(goo.getPos()) < 15);
  }

  boolean eatGhost(Ghost goo) {//check if ghost is scared, if yes, eat it
    return goo.isScared();
  }

  void stop() {//stop and step back
    stop = true;
    if (left || right) {//step back 
      p.getPacPos().x = p.getPacPos().x - vx*5;
    } else if (up || down) {
      p.getPacPos().y = p.getPacPos().y - vy*5;
    }
  }

  void toggleStop() {//set stop to false
    stop = false;
  }

  void move() {//check if wall is hit 
    if (!stop) {//only move if not touching wall
      if (left) {
        vx = -1;
      } else if (right) {
        vx = 1;
      } else if (down) {
        vy = 1;
      } else if (up) {
        vy = -1;
      }
      if (left || right) {//take step
        pacPos.x += vx;
      } else if (up || down) {
        pacPos.y += vy;
      }
    }
  }

  void drawLives() {//show remaining lives
    for (int i = 0; i <lives; i++) {
      fill(255, 255, 0);
      arc(width/2 + 2*i*squareSize-30, height-30, squareSize, squareSize, pacStartRad, pacEndRad);
    }
  }

  int getLives() {
    return lives;
  }

  void die() {
    lives--;
    stop = true;
  }
}
