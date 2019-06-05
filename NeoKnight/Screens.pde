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

  void shopScreen() {
    background(0);
    text("Press 1 to buy Health Potion", width/6, (height / 6)-80);
    text("Press 2 to buy Armor Potion", width/6, (height / 3)-60);
    text("Press 3 to buy Bow", width/6, (height / 2)-40);
    text("Press 4 to buy Arrow", width/6, (height * 2 / 3)-40);
    text("Press 5 to buy Sword", width/6, (height * 5 /6)-40);
    text("Press 6 to buy Shield", width/6, height -40);
  }

  void setInput(int k) {
    switch(k) {
    case '1':
      Item healthPotion = new Item(3, 0, 0);
      healthPotion.display = false;
      if (person.money >= healthPotion.getPrice()) {
        person.money -= healthPotion.getPrice();
        person.inv.add(healthPotion);
      } else {
        text("You are missing " + (healthPotion.getPrice() - person.money + ""), 0, 20);
      }
      break;
    case '2':
      Item armorPotion = new Item(4, 0, 0);
      armorPotion.display = false;
      if (person.money >= armorPotion.getPrice()) {
        person.money -= armorPotion.getPrice();
        person.inv.add(armorPotion);
      } else {
        text("You are missing " + (armorPotion.getPrice() - person.money + ""), 0, 20);
      }
      break;
    case '3':
      Item bow = new Item(6, 0, 0);
      bow.display = false;
      if (person.money >= bow.getPrice()) {
        person.money -= bow.getPrice();
        person.inv.add(bow);
      } else {
        text("You are missing " + (bow.getPrice() - person.money + ""), 0, 20);
      }
      break;
    case '4':
      Item arrow = new Item(7, 0, 0);
      arrow.display = false;
      if (person.money >= arrow.getPrice()) {
        person.money -= arrow.getPrice();
        person.inv.add(arrow);
      } else {
        text("You are missing " + (arrow.getPrice() - person.money + ""), 0, 20);
      }
      break;
    case '5':
      Item sword = new Item(1, 0, 0);
      sword.display = false;
      if (person.money >= sword.getPrice()) {
        person.money -= sword.getPrice();
        person.inv.add(sword);
      } else {
        text("You are missing " + (sword.getPrice() - person.money + ""), 0, 20);
      }
      break;
    case '6':
      Item shield = new Item(2, 0, 0);
      shield.display = false;
      if (person.money >= shield.getPrice()) {
        person.money -= shield.getPrice();
        person.inv.add(shield);
      } else {
        text("You are missing " + (shield.getPrice() - person.money + ""), 0, 20);
      }
      break;
    }
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
    room.update();
    update();
    room.move();

    room.display();
    person.display();
    fill(255);
    textSize(20);
    textAlign(LEFT);
    text(room.toString(), room.getX(), room.getY());
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
    text("rotation : " + person.rotation, 0, 890);
  }
}
//after the player dies a death screen comes up
