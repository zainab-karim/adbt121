class countDown {
  int startTime = 0, stopTime = 0;
  boolean running = false; 
  
  void start() {
    startTime = millis();
    running = true;
  }
  void stop() {
    stopTime = millis();
    running = false;
  }
  int getElapsedTime() {
    int elapsed;
    if (running) {
      elapsed = (millis() - startTime);
    } else {
      elapsed = (stopTime - startTime);
    }
    return elapsed;
  }
  int sec() {
    int second = getElapsedTime()/1000;

    return second;
  }
}
