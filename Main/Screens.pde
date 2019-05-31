class Screen {

  public Screen() {
  }

  //This produces a start screen 
  void startScreen() {
    background(0);
    textAlign(CENTER);
    textSize(50);
    text("Click the mouse to start", width/2, height/2);
  }

  //this prints out the current room 
  void gameScreen(String str) {
    background(0, 0, 255);
    fill(50);
    textAlign(LEFT);
    text(str, 0, 10);
  }

  //after the player dies a death screen comes up
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
