class Ghost {

  PVector ghostPos, startPos;
  Timer timer = new Timer();
  PImage left, right, up, down, spooked;
  PVector direction = new PVector(0, 1);//leftright, updown
  boolean scared=false;

  Ghost(float x, float y) {
    imageMode(CENTER);
    ghostPos = new PVector(x, y);
    startPos = new PVector(x, y);
    left = loadImage("leftghost.png");
    right = loadImage("rightghost.png");
    up = loadImage("upghost.png");
    down = loadImage("downghost.png");
    spooked = loadImage("scared.png");
  }

  void redraw() {
    if (timer.checkTimeDone()) {
      scared = false;
    }
    fill(255, 0, 0);
    if (scared) {//show different images if scared, and for diff directions
      image(spooked, ghostPos.x, ghostPos.y, p.getSize(), p.getSize());
    } else {
      if (direction.x == -1) {//left
        image(left, ghostPos.x, ghostPos.y, p.getSize(), p.getSize());
      } else if (direction.x == 1) {//right
        image(right, ghostPos.x, ghostPos.y, p.getSize(), p.getSize());
      } else if (direction.y == -1) {//up
        image(up, ghostPos.x, ghostPos.y, p.getSize(), p.getSize());
      } else if (direction.y == 1) {//down
        image(down, ghostPos.x, ghostPos.y, p.getSize(), p.getSize());
      }
    }
  }

  void move() {
    if (ghostPos.x > width) {//wrap around when going out of screen bounds
      ghostPos.x = 0;
    }
    if (ghostPos.x < 0) {
      ghostPos.x = width;
    }
    if (ghostPos.y > height) {
      ghostPos.y = 0;
    }
    if (ghostPos.y < 0) {
      ghostPos.y = height;
    }

    if (frameCount % 500 == 0) {//random movement change
      int dir = floor(random(-1, 2));//random 1 or -1, multiply vector contents by this
      if (dir == -1) {
        direction.mult(dir);
      } else {
        direction.rotate(HALF_PI);
      }
    }
    //step forward
    ghostPos.x += direction.x;
    ghostPos.y += direction.y;
  }

  void returnToStart() {//set back at start
    ghostPos.set(startPos);
    scared = false;
  }

  void setScared(boolean s) {
    scared = s;
    timer.startTimer(frameCount, 500);//set a timer for ghosts to remain scared for 500 frames
  }

  boolean isScared() {
    return scared;
  }

  PVector getPos() {
    return ghostPos;
  }
}
