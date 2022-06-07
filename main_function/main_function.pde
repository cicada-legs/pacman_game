PacMan p;
State state = State.MENU;
ArrayList <Ghost> allGhosts = new ArrayList<Ghost>();
PFont arcadeClassic, pacFont;
float facingAngle;
Timer timer200 = new Timer();
Timer gameOver = new Timer();
Timer winTime = new Timer();
float pelletCount;
int scoreCount, currentTime;
Button restartButton, playButton, exitButton, menuButton, level2Button;
Maze maze;


void setup() {
  size(588, 705, P2D);
  allGhosts.clear();
  pelletCount = 0;
  maze = new Maze("levelmap.txt");//load txt file to draw maze
  scoreCount = 0;
  arcadeClassic = createFont("ARCADECLASSIC.TTF", 30);
  pacFont = createFont("PAC-FONT.TTF", 30);
  restartButton = new Button(width-100, height-30, 20, "restart");
  playButton = new Button(width/2, height/2 - 150, 80, "play");
  level2Button = new Button(width/2, height/2, 80, "level2");
  exitButton = new Button(width/2, height/2 +150, 80, "exit");
  menuButton = new Button(width-160, height-25, 40, "menu");
  p = new PacMan(maze.getBlockPos(1, 1).x, maze.getBlockPos(1, 1).y, maze.getBlockSize());//change later
}

void draw() {
  if (state == State.MENU) {//game menu
    background(0);
    fill(255);
    if (frameCount/40 % 2 == 0) {//alternating menu colours
      fill(0, 0, 255);
    } else {
      fill(255, 255, 0);
    }
    textFont(pacFont);
    textAlign(CENTER);
    text("90000000000 pac-man 00000000009", width/2, 100);
    text("90000000000 but worse 00000000009", width/2, height-100);
    playButton.redraw();
    level2Button.redraw();
    exitButton.redraw();
  }
  if (state == State.LEVEL_1) {//level1
    background(0);
    fill(255);
    textFont(arcadeClassic);
    textAlign(CENTER);
    text("score      " +scoreCount, 90, height-20);
    menuButton.redraw();
    restartButton.redraw();
    maze.redraw();
    if (pelletCount == 0) {//when all pellets have been eaten
      if (state == State.LEVEL_1) {//advance to next level, keeping score
        state = State.LEVEL_2;
        return;
      }
      if (state == State.LEVEL_2) {//end the game and go to win screen
        winTime.startTimer(frameCount, 660);
        state = State.WIN;
      }
    }
    p.move();
    forAllGhosts("touchPac");//check if any ghosts are touching pacman
    forAllGhosts("move");
    forAllGhosts("redraw");
    p.redraw(facingAngle);
    p.drawLives();
    if (!timer200.checkTimeDone()) {//display points when ghost is eaten
      maze.displayPoints("200");
    }
  }
  if (state == State.LEVEL_2) {//load new txt file into maze, then run same game functions as lvl1
    pelletCount = 0;
    maze = new Maze("levelmap2.txt");
    state = State.LEVEL_1;
  }
  if (state == State.GAME_OVER) {
    if (!gameOver.checkTimeDone()) {
      background(0);
      textAlign(CENTER);
      textFont(pacFont);
      fill(0, 0, 255);
      text("game over", width/2, 150);
      text("1 9 9 9", width/2, 250);
      fill(255);
      textFont(arcadeClassic);
      text("high score      " +scoreCount, width/2, height/2);
      if (frameCount/40 % 2 == 0) {//flashing colours
        fill(255);
      } else {
        fill(255, 255, 0);
      }
      text("returning to main menu in ", width/2, height/2 + 100);
      text(gameOver.getRemainingTime()/60, width/2, height/2 + 150);
    } else {//return to menu after 10 seconds
      state = State.MENU;
      frameCount = -1;
    }
  }
  if (state == State.WIN) {
    if (!winTime.checkTimeDone()) {
      background(0);
      textAlign(CENTER);
      textFont(pacFont);
      fill(255, 255, 0);
      text("you win!", width/2, 150);
      text("1 0 0 0", width/2, 250);
      fill(255);
      textFont(arcadeClassic);
      text("high score      " +scoreCount, width/2, height/2);
      if (frameCount/40 % 2 == 0) {//flashing menu colours
        fill(255);
      } else {
        fill(255, 255, 0);
      }

      text("returning to main menu in ", width/2, height/2 + 100);
      text(winTime.getRemainingTime()/60, width/2, height/2 + 150);
    } else {//return to menu after 10 seconds
      state = State.MENU;
      frameCount = -1;
    }
  }
}

void forAllGhosts(String action) {//apply actions to all ghosts in a level
  for (int i = 0; i < allGhosts.size(); i++) {
    if (action.equals("redraw")) {//redraw in correct position
      allGhosts.get(i).redraw();
    } else if (action.equals("move")) {//move one step
      allGhosts.get(i).move();
    } else if (action.equals("touchPac")) {
      if (p.hitGhost(allGhosts.get(i))) {//check if intersecting with pacman
        if (p.eatGhost(allGhosts.get(i))) {//if ghost is scared, eat it and +200 points
          scoreCount+=200;
          fill(255);
          timer200.startTimer(frameCount, 30);//display points for a few frames
          maze.displayPoints("200");
          allGhosts.get(i).returnToStart();//respawn eaten ghost back to start position
        } else {
          p.die();
          forAllGhosts("restart");//reset all ghosts back to start when pacman dies
          if (p.getLives()>0) {
            p.revive();//redraw pacman in start position
          } else {
            gameOver.startTimer(frameCount, 660);
            state = State.GAME_OVER;//game over
          }
          delay(1000);
          return;//exit //////////////////////////////////////////////
        }
      }
    } else if (action.equals("restart")) {
      allGhosts.get(i).returnToStart();//return all ghosts to start position
    }
  }
}

void keyPressed() {
  p.goUp(false);
  p.goDown(false);
  p.goLeft(false);
  p.goRight(false);
  p.toggleStop();
  if (key == 'w') {//up
    p.goUp(true); 
    facingAngle = 3*PI/2;//changes angle pacman is facing
  }
  if (key == 'a') {//left
    p.goLeft(true);
    facingAngle = PI;
  }
  if (key == 's') {//down
    p.goDown(true);
    facingAngle = PI/2;
  }
  if (key == 'd') {//right
    p.goRight(true);
    facingAngle = 0;
  }
}

void mousePressed() {//button control
  if (state == State.MENU) {
    if (playButton.checkOn()) {//play level 1 when lvl 1 button is pressed
      state = State.LEVEL_1;
    }
    if (level2Button.checkOn()) {//likewise for lvl 2
      state = State.LEVEL_2;
      frameCount = -1;
    }
    if (exitButton.checkOn()) {//exit program
      exit();
    }
  }
  if (menuButton.checkOn()) {//return to menu
    state = State.MENU;
    frameCount = -1;
  }
  if (restartButton.checkOn()) {//reset to the beginning of level 1
    frameCount = -1;
  }
}
