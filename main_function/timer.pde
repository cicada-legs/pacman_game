class Timer {

  int startTime, waitFor;
  boolean start;

  Timer() {
    start = true;
  }

  void startTimer(int t, int w) {//start timer using current time and how long to wait for
    startTime = t;
    waitFor = w;
  }
  
  int getRemainingTime(){//get remaining time on timer
    return startTime+waitFor-frameCount;
  }

  boolean checkTimeDone() {//check if timer is finished
    if (frameCount > startTime + waitFor) {
      startTime = 0;
      waitFor = 0;
      start = false;
      return true;
    }
    return false;
  }
}
