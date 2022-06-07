Timer timer50 = new Timer();
class Maze {
  private ArrayList <ArrayList<Block>> allBlocks;
  float  blockSize, mazeXSize, mazeYsize;
  String[] allLines;

  Maze(String filename) {//initialize new maze level from text file
    allLines = loadStrings(filename);
    allBlocks = new ArrayList(allLines.length);
    for (int i=0; i < allLines.length; i++) {
      allBlocks.add(new ArrayList());
    }
    blockSize = width/(allLines[0].length());//fit blocks to screen
    for (int i = 0; i < allLines.length; i++) {
      String line = allLines[i];
      for (int j = 0; j < line.length(); j++) {
        char current = line.charAt(j);
        Block b = new Block(j*blockSize + blockSize/2, i*blockSize +blockSize/2, current, blockSize);
        allBlocks.get(i).add(b);
        if (b.getBlockType() == 'O') {//add pellets for O
          if (random(100) > 99) {//random probablility of spawning power pellets
            b.setBlockType('P');
          }
          pelletCount++;
        } else if (b.getBlockType() == 'G') {//add ghost for G
          Ghost g = new Ghost(b.getBoxPos().x, b.getBoxPos().y);
          allGhosts.add(g);
        }
      }
    }
  }

  void redraw() {//redraw teh maze
    Block currentBlock;
    for (int x = 0; x < allBlocks.size(); x++) {
      for (int y = 0; y < allBlocks.get(x).size(); y++) {
        currentBlock = allBlocks.get(x).get(y);
        if (currentBlock.checkEat(p.getPacPos())) {//check if pacman eats a pellet
          allBlocks.get(x).remove(currentBlock);
          pelletCount--;//update stats
          if (currentBlock.getBlockType() == 'P') {//if power pellet (big pellet)
            scoreCount += 50;//display points for few frames
            timer50.startTimer(frameCount, 30);
            for (int g = 0; g < allGhosts.size(); g++) {//make all ghosts scared
              allGhosts.get(g).setScared(true);
            }
          } else {
            scoreCount += 10;//+10 for normal pellets
          }
        } else {
          if (currentBlock.intersects(p.getPacPos())  && currentBlock.isWall()) {//if currentBlock intersects pacman
            p.stop();
          }
          currentBlock.redraw();
        }
      }
    }
    if (!timer50.checkTimeDone()) {//display points when ghost is eaten
      maze.displayPoints("50");
    }
  }

  void displayPoints(String text) {//display points when special objects are eaten
    fill(255);
    textFont(arcadeClassic);
    text(text, p.getPacPos().x, p.getPacPos().y);
  }

  PVector getBlockPos(int x, int y) {//get positon of a block
    return allBlocks.get(x).get(y).getBoxPos();
  }

  float getBlockSize() {
    return blockSize;
  }

  float mazeXSize() {
    return allBlocks.size();
  }

  float mazeYSize() {
    return allLines.length;
  }
}
