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

  void gameScreen(Room room, Player person){
    room.update();
    update();
    room.move();
    
    room.display();
    person.display();
    fill(255);
    textSize(20);
    textAlign(LEFT);
    text(room.toString(),room.getX(), room.getY());
    text("Room X: " + room.getX(), 0, 500);
    text("Room Y: " + room.getY(), 0, 530);
    text("NUMDOORS: " + current.getDoors().size(), 0, 560);
    text("UP: " + room.hasUp, 0, 590);
    text("DOWN: " + room.hasDown, 0, 620);
    text("LEFT: " + room.hasLeft, 0, 650);
    text("RIGHT: " + room.hasRight, 0, 680);
    text("CURRENT ROW: " + currentRoomRow, 0, 710);
    text("CURRENT COL: " + currentRoomCol, 0, 740);
    text("lowx : " + current.lowX, 0, 770);
    text("highx : " + current.highX, 0, 800);
    text("lowy : " + current.lowY, 0, 830);
    text("highy : " + current.highY, 0, 860);
  }
}
//after the player dies a death screen comes up
