enum State {//states
  MENU, LEVEL_1, LEVEL_2, GAME_OVER, WIN
}

class Button {

  float xButton, yButton, size;
  String type;

  Button(float x, float y, float s, String t) {
    xButton = x;
    yButton = y;
    size = s;
    type = t;
  }
  void redraw() {//redraw depending on button type
    fill(150);
    rectMode(CENTER);
    if (checkOn()) {//if mouse is over the button, draw like this
      if (type.equals("play")) {
        fill(255, 255, 0);
        text("1", xButton, yButton+size/2);
        text("level one", xButton, yButton);
      }
      if (type.equals("level2")) {
        fill(255, 255, 0);
        text("1", xButton, yButton+size/2);
        text("level two", xButton, yButton);
      }
      if (type.equals("exit")) {
        fill(255, 255, 0);
        text("1", xButton, yButton+size/2);
        text("exit", xButton, yButton);
      }
      if (type.equals("menu")) {
        fill(255);
        textFont(pacFont);
        textAlign(CENTER);
        textSize(20);
        text("menu", xButton, yButton);
      }
      if (type.equals("restart")) {
        fill(255, 0, 0);
        rect(xButton, yButton, size, size);
      }
    } else {//if button is not hovered over or clicked
      if (type.equals("play")) {
        fill(255);
        textFont(pacFont);
        textAlign(CENTER);
        text("LEVEL ONE", xButton, yButton);
      }
      if (type.equals("level2")) {
        fill(255);
        text("LEVEL TWO", xButton, yButton);
      }
      if (type.equals("exit")) {
        fill(255);
        textFont(pacFont);
        textAlign(CENTER);
        text("EXIT", xButton, yButton);
      }
      if (type.equals("menu")) {
        fill(255);
        textFont(pacFont);
        textAlign(CENTER);
        textSize(20);
        text("MENU", xButton, yButton);
      }
      if (type.equals("restart")) {
        rect(xButton, yButton, size, size);
      }
    }
  }

  boolean checkOn() {//check if mouse is over the button
    return (mouseX > xButton-size/2 && mouseX < xButton+size/2) && (mouseY > yButton-size/2 && mouseY < yButton+size/2);
  }
}
