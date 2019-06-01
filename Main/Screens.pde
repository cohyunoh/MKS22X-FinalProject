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
  void gameScreen(Room room) {
    
    
    /*
    fill(50);
    textSize(10);
    textAlign(LEFT);
    text(str, 0, 10);
    */
    
    room.move();
    room.display();
    rectMode(CENTER);
    fill(225,0,0);
    rect(1000,500,50,50);
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
