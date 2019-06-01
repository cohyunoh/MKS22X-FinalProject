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
  void gameScreen(Room room, Player person) {
    
    
    /*
    fill(50);
    textSize(10);
    textAlign(LEFT);
    text(str, 0, 10);
    */
    
    room.move();
    room.display();
    person.display(items);
    /*
    for(int i = 0; i < items.size(); i++){
      Item item = items.get(i);
      item.display();
    }
    
    for(int i = 0; i < enemies.size(); i++){
      Gorlag enemy = enemies.get(i);
      enemy.setMove(person);
      enemy.move();
      if(dist(person.getX(), person.getY(),enemy.getX(), enemy.getY()) < 50){
        enemy.attack(person);
      }
      enemy.display();
    }
    */
    
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
