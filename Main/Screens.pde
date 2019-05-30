class Screen {
  
  public Screen(){
  }

  void startScreen() {
    background(0);
    textAlign(CENTER);
    text("Click to start", width/2, height/2);
  }

  void gameScreen(String str) {
    background(0, 0, 255);
    fill(50);
    textAlign(LEFT);
    text(str, 0, 10);
  }

  void deathScreen() {
    background(0);
    textAlign(CENTER);
    fill(255);
    textSize(30);
    text("You died! Game Over", height/2, width/2 - 20);
    textSize(15);
    text("Click to Restart", height/2, width/2 + 10);
  }
}
