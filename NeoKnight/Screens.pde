class Screen {

  public Screen() {
  }

  void deathScreen() {
    background(0);
    textAlign(CENTER);
    fill(255);
    textSize(30);
    text("You died! Game Over", width/2, height/2 - 20);
    textSize(15);
    text("Click to Restart", width/2, height/2 + 10);
  }

  //This produces a start screen 
  void startScreen() {
    background(0);
    textAlign(CENTER);
    textSize(50);
    text("Click the mouse to start", width/2, height/2);
  }

  //this prints out the current room 
  void gameScreen(Room room, Player person) {
    room.move();
    room.display();
    person.display(items);
    if(arrows != null){
      for (i = arrows.size()-1; i >= 0; i--) {
        //you need a seperate var to get the object from the bullets arraylist then use that variable to call the functions
        Arrow arrow = arrows.get(i);
        arrow.display();
      }
    }
    fill(50);
    textSize(20);
    textAlign(LEFT);
    text("Room X: " + room.getX(), 0, 500);
    text("Room Y: " + room.getY(), 0, 530);
  }

  //after the player dies a death screen comes up
}
