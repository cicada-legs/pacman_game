class Block {

  char blockType;
  float size;
  PVector boxPos;
  boolean eaten;

  Block(float x, float y, char type, float s) {
    boxPos = new PVector(x, y);
    blockType = type;
    size = s;
  }

  void redraw() {//redraw depending on blocktype
    rectMode(CENTER);
    if (blockType == 'W') {
      fill(25, 25, 166);
      stroke(33, 33, 222);
      rect(boxPos.x, boxPos.y, size, size);
    } else if (blockType == 'O') {
      rectMode(CENTER);
      fill(222, 161, 133);
      stroke(255);
      rect(boxPos.x, boxPos.y, size/6, size/6);
    } else if (blockType == 'P') {
      ellipseMode(CENTER);
      fill(222, 161, 133);
      stroke(255);
      ellipse(boxPos.x, boxPos.y, size*0.8, size*0.8);
    }
  }

  boolean isWall() {
    if (blockType == 'W') {//check if a block is a wall
      return true;
    }
    return false;
  }

  void setBlockType(char t) {//set blocktype, used for random power pellet generation
    blockType = t;
  }

  boolean intersects(PVector pos) {//check if pacman is intersecting a block, used for walls
    if (boxPos.dist(pos) < size/2) {
      return true;
    }
    return false;
  }

  boolean checkEat(PVector pos) {//check if pacman is intersecting an edible block
    if ((blockType == 'O' || blockType == 'P') && boxPos.dist(pos) < 10) {
      return true;
    } else {
      return false;
    }
  }

  PVector getBoxPos() {
    return boxPos.set(boxPos.x, boxPos.y +1) ;//get position of a block
  }

  char getBlockType() {
    return blockType;
  }
}
