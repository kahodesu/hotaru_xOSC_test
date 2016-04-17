
int gameTime = 60000; //LENGTH OF GAME
int fireTime = 50; 
int flashTime = 10; 

//TIME VARS
Timer gameTimer, fireTimer, flashTimer; 

void setUpTimer() {
  fireTimer = new Timer(fireTime);
  flashTimer = new Timer(flashTime);

  fireTimer.start();
  flashTimer.start();
}

//////////////////////////////////////////////////////////
// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com
// Example 10-5: Object-oriented timer

class Timer {
 
  int savedTime; 
  int totalTime; 
  
  Timer(int tempTotalTime) {
    totalTime = tempTotalTime;
  }
  
  void start() {
    savedTime = millis(); 
  }
  
  boolean isFinished() { 
    int passedTime = millis()- savedTime;
    if (passedTime > totalTime) {
      return true;
    } else {
      return false;
    }
  }
}