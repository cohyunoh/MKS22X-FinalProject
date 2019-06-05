class Screen {

  Item healthPotion = new Item(3, 0, 0);
  Item armorPotion = new Item(4, 0, 0);
  Item bow = new Item(6, 0, 0);
  Item arrow = new Item(7, 0, 0);
  Item sword = new Item(1, 0, 0);
  Item shield = new Item(2, 0, 0);
  float ran1 =random(255);
  float ran2 =random(255);
  float ran3 =random(255);
  Animation anim = new Animation("intro", 8);
  PImage death = loadImage("death.png");
  public Screen() {
  }

  //After the player completes the objective, this screen appears
  void winScreen() {
    background(0);
    textAlign(CENTER);
    fill(ran1, ran2, ran3);
    textSize(60);
    text("WOW! You survived NEOKNIGHT", width/2, height/8);
    text("You must be really good", width/2, height/5);
    textSize(10);
    text("Well, you can exit now", width/2, height /2);
    textSize(60);
    text("Press Y to restart", width/2, height/1.2);
  }

  //gives the player's inventory
  void inventory() {
    textSize(60);
    textAlign(CENTER);
    text("INVENTORY", width /2, 60);
    int x = 10;
    int y = 10;
    for (int i = 0; i < person.inv.size(); i++) {
      Item item = person.inv.get(i);
      if (inBounds(x, y)) {
        item.xCor = x;
        item.yCor = y;
      } else {
        x = 10;
        y = 10;
      }
      textSize(30);
      text(item.getName(), item.xCor+50, item.yCor-10);
      item.display();
      x += 32;
      y += 32;
    }
  }

  boolean inBounds(int x, int y) {
    if (x < width && x >= 0 && y < height && y > 0) return true;
    return false;
  }

  //displays death screen upon player losing
  void deathScreen() {
    background(0);
    imageMode(CENTER);
    //image(death, width / 2, height / 2);
    textAlign(CENTER);
    fill(255);
    textSize(30);
    text("You died! Game Over", width/2, height/2 - 20);
    textSize(15);
    text("Click to Restart", width/2, height/2 + 10);
  }

  //This produces a screen with the game instructions
  void instructionScreen() {
    background(0);
    fill(255);
    textAlign(CENTER);
    textSize(60);
    text("How To Play", width /2, 60);
    textSize(40);
    text("Pressing E picks up objects and opens doors", width/2, 100);
    text("Pressing Q opens and closes shop", width /2, 140);
    text("In shop, pressing 1-6 allows you to buy stuff if you have enough money", width/2, 180);
    text("W,A,S,D are movement keys for up,left,down,right respectively", width/2, 220);
    text("Scroll your mouse wheel in order to go through the items in your inventory", width/2, 260);
    text("Click your mouse to use the item in your hand", width/2, 300);
    text("Pressing ESCAPE will leave the game", width/2, 340);
    text("Pressing Y at the win screen will restart the game", width/2, 380);
    text("Pressing C during the game will display the player's inventory", width/2, 420);
    text("Pressing R during the game will restart the game", width/2, 460);
    text("Press I to go back to start menu", width /2, 500);
  }



  //This produces a start screen 
  void startScreen() {
    background(0);

    anim.display(width/2, height/2);
    textAlign(CENTER);
    textSize(50);
    fill(255);
    text("Click the mouse to start", width/2, height/4);
    text("Press I to read instructions", width / 2, height * 3/4);
    textSize(100);
    fill(random(255), random(255), random(255));
    text("NEOKNIGHT", width/2, height/2);
  }

  //this prints out the current room 

  void gameScreen(Room room, Player person) {
    for (int i = 0; i < person.inv.size(); i++) {
      Item item = person.inv.get(i);
      item.xCor = 46;
      item.yCor = height - 14;
    }
    room.move();
    room.display();

    person.display();
    fill(0, 0, 255);
    textSize(20);
    textAlign(LEFT);
    text("Arrows: " + person.amountOfArrows, 10, 530);
    text("Enemies Left: " + countAlive(), 10, 500);
    if (obj == 1) {
      text("Objective: Kill 1000 Enemies", 10, 154);
      text(person.numEnemies + " / 1000 Enemies", 10, 184);
    }
    if (obj == 2) {
      text("Objective: Unlock 500 Doors", 10, 154);
      text(person.numDoors + " / 500 Doors", 10, 184);
    }
    if (obj == 3) {
      text("Objective: Go To 500 Rooms", 10, 154);
      text(roomNum + " / 500 Rooms", 10, 184);
    }

    if (obj == 4) {
      text("Objective: PLAY", 10, 154);
      text("Rooms Searched:" + roomNum, 10, 184);
      text("Enemies Killed:" + person.numEnemies, 10, 214);
      text("Doors Unlocked:" + person.numDoors, 10, 244);
    }
    /*
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
     */
  }

  //displaying shop
  void shopScreen() {
    background(0);
    text("Press 1 to buy Health Potion", width/6, (height / 6)-80);
    healthPotion.xCor = width/6;
    healthPotion.yCor = (height / 6) - 80;
    healthPotion.display();
    text("Press 2 to buy Armor Potion", width/6, (height / 3)-60);
    armorPotion.xCor = width/6;
    armorPotion.yCor = (height / 3)- 60;
    armorPotion.display();
    text("Press 3 to buy Bow", width/6, (height / 2)-40);
    bow.xCor = width/6;
    bow.yCor = (height / 2)- 40;
    bow.display();
    text("Press 4 to buy Arrow", width/6, (height * 2 / 3)-40);
    arrow.xCor = width/6;
    arrow.yCor = (height * 2 / 3)- 40;
    arrow.display();
    text("Press 5 to buy Sword", width/6, (height * 5 /6)-40);
    sword.xCor = width/6;
    sword.yCor = (height * 5 /6)- 40;
    sword.display();
    text("Press 6 to buy Shield", width/6, height - 40);
    shield.xCor = width/6;
    shield.yCor = height - 40;
    shield.display();
  }

  //This method is where the player selects what they want to buy
  void setInput(int k) {
    switch(k) {
    case '1':
      Item healthPotion = new Item(3, 46, height - 14);
      healthPotion.display = false;
      if (person.money >= healthPotion.getPrice()) {
        person.money -= healthPotion.getPrice();
        person.inv.add(healthPotion);
      } else {
        text("You are missing " + (healthPotion.getPrice() - person.money + ""), 0, 20);
      }
      break;
    case '2':
      Item armorPotion = new Item(4, 46, height - 14);
      armorPotion.display = false;
      if (person.money >= armorPotion.getPrice()) {
        person.money -= armorPotion.getPrice();
        person.inv.add(armorPotion);
      } else {
        text("You are missing " + (armorPotion.getPrice() - person.money + ""), 0, 20);
      }
      break;
    case '3':
      Item bow = new Item(6, 46, height - 14);
      bow.display = false;
      if (person.money >= bow.getPrice()) {
        person.money -= bow.getPrice();
        person.inv.add(bow);
      } else {
        text("You are missing " + (bow.getPrice() - person.money + ""), 0, 20);
      }
      break;
    case '4':
      Item arrow = new Item(7, 46, height - 14);
      arrow.display = false;
      if (person.money >= arrow.getPrice()) {
        person.money -= arrow.getPrice();
        person.inv.add(arrow);
        person.amountOfArrows += 5;
      } else {
        text("You are missing " + (arrow.getPrice() - person.money + ""), 0, 20);
      }
      break;
    case '5':
      Item sword = new Item(1, 46, height - 14);
      sword.display = false;
      if (person.money >= sword.getPrice()) {
        person.money -= sword.getPrice();
        person.inv.add(sword);
      } else {
        text("You are missing " + (sword.getPrice() - person.money + ""), 0, 20);
      }
      break;
    case '6':
      Item shield = new Item(2, 46, height - 14);
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
}
