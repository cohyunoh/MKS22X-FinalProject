import java.util.*;


class Room implements Moveable {
  //Instance Variables ========================
  int vel = 5;
  boolean isLeft, isRight, isUp, isDown, wasLeft, wasRight, run, hasLeft, hasRight, hasUp, hasDown;
  char[][] floor;
  char current, next;
  int rows, cols, totaldoors;
  float x, y, lowX, lowY, highX, highY, w, l, newX, newY;
  int locked = 0;
  int num, addHp = 0, addAp = 0, addShield = 0, addSword = 0, addBow = 0;
  PImage tile = loadImage("floor.png");
  PImage wall = loadImage("wall.png");  
  ArrayList<Item> roomitems;
  ArrayList<Enemy> roomenemies;
  ArrayList<Door> doors;
  ArrayList<Arrow> roomarrows;



  //==============================================

  //Constructors====================================
  public Room(int rows, int cols, float x, float y, int num) {
    doors = new ArrayList<Door>();
    roomenemies = new ArrayList<Enemy>();
    roomitems = new ArrayList<Item>();
    roomarrows = new ArrayList<Arrow>();
    this.num = num;
    this.rows = rows;
    this.cols = cols;
    this.x = x;
    this.y = y;
    floor = new char[rows][cols];
    lowX = -1 * ((cols - 1) * 32 - 750) + person.getWidth() / 6;
    lowY = -1 * ((rows - 1) * 32 - 500) + person.getHeight() / 4;
    highX = 750 - (x + 32) - person.getWidth() / 4;
    highY = 500 - (y + 32) - person.getHeight() / 4;
    w = cols * 32;
    l = rows * 32;
    totaldoors = 0;
    initRoom();
    addDoors();
  }

  public Room(int rows, int cols, Door door, float x, float y, int num) {
    roomitems = new ArrayList<Item>();
    doors = new ArrayList<Door>();
    roomarrows = new ArrayList<Arrow>();
    roomenemies = new ArrayList<Enemy>();
    this.num = num;
    this.rows = rows;
    this.cols = cols;
    this.x = x;
    this.y = y;
    floor = new char[rows][cols];
    lowX = -1 * ((cols - 1) * 32 - 750) + person.getWidth() / 6;
    lowY = -1 * ((rows - 1) * 32 - 500) + person.getHeight() / 4;
    highX = 750 - (x + 32) - person.getWidth() / 4;
    highY = 500 - (y + 32) - person.getHeight() / 4;
    w = cols * 32;
    l = rows * 32;
    totaldoors = 0;
    initRoom(door);
  }

  //================================================================


  void updateConstrains() {
    lowX = -1 * ((cols - 1) * 32 - 750) + person.getWidth() / 6;
    lowY = -1 * ((rows - 1) * 32 - 500) + person.getHeight() / 4;
    highX = 750 - (x + 32) - person.getWidth() / 4;
    highY = 500 - (y + 32) - person.getHeight() / 4;
  }

  void addKeys() {
    for (int i = 0; i < locked; i++) {
      Enemy enemy = roomenemies.get(i);
      Item keyy = new Item(5, 0, 0);
      keyy.show();
      enemy.addItem(keyy);
      enemy.hasKey = true;
    }
  }

  void addSword() {
    int enemyI = (int)abs((float)Math.random() * roomenemies.size());
    if (!person.hasSword) {
      Enemy enemy = roomenemies.get(enemyI);
      Item sword = new Item(1, 0, 0);
      sword.show();
      enemy.addItem(sword);
    }
  }

  void addBow() {
    int enemyI = (int)abs((float)Math.random() * roomenemies.size());
    if (person.hasBow) {
      Enemy enemy = roomenemies.get(enemyI);
      Item bow = new Item(6, 0, 0);
      bow.show();
      enemy.addItem(bow);
    }
  }

  void addShield() {
    int enemyI = (int)abs((float)Math.random() * roomenemies.size());
    if (!person.hasShield) {
      Enemy enemy = roomenemies.get(enemyI);
      Item shield = new Item(2, 0, 0);
      shield.show();
      enemy.addItem(shield);
    }
  }

  void addpotionH() {
    for (int i = person.hp; i <= 200; i += 10) {
      int enemyI = (int)abs((float)Math.random() * roomenemies.size());
      Enemy enemy = roomenemies.get(enemyI);
      Item potionH = new Item(3, 0, 0);
      potionH.show();
      enemy.addItem(potionH);
    }
  }

  void addpotionA() {
    for (int i = person.armor; i <= 100; i += 10) {
      int enemyI = (int)abs((float)Math.random() * roomenemies.size());
      Enemy enemy = roomenemies.get(enemyI);
      Item potionA = new Item(4, 0, 0);
      potionA.show();
      enemy.addItem(potionA);
    }
  }


  //ADD METHODS=====================================================
  void addEnemies() {
    for (int i = 0; i < enemies.size(); i++) {
      Enemy enemy = enemies.get(i);
      enemy.setX(constrain(abs((float)(Math.random() * (cols * 32))), 32, 32 * (cols - 2)));
      enemy.setY(constrain(abs((float)(Math.random() * (rows * 32))), 32, 32 * (rows - 2)));
      enemy.addConstrainX(32, 32 * (cols - 2));
      enemy.addConstrainY(32, 32 * (rows - 2));
      roomenemies.add(enemy);
    }
  }

  //=================================================================

  //Initialize Room methods==========================================
  void initRoom(Door door) {
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        floor[r][c] = isWall(r, c) ? '#' : ' ';
      }
    }
    if (door.isUp()) {
      putDoorDown();
      hasDown = true;
    } else if (door.isDown()) {
      putDoorUp();
      hasUp = true;
    } else if (door.isRight()) {
      putDoorLeft();
      hasLeft= true;
    } else {
      putDoorRight();
      hasRight = true;
    }
    totaldoors ++;
    generateRandomDoor();
    addDoors();
  }

  void initRoom() {
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        floor[r][c] = isWall(r, c) ? '#' : ' ';
      }
    }
    generateRandomDoor();
  }

  void generateRandomDoor() {
    int numDoors = (int)(abs((float)(Math.random() * (4 - totaldoors)))) + 1 + totaldoors;
    //keeps track of how many times it tries to make a door
    int tries = 0;
    while (totaldoors != numDoors && tries < 5) {
      int randomRow = constrain((int)abs((float)(Math.random() * rows)), 3, rows - 4);
      int randomCol = constrain((int)abs((float)(Math.random() * cols)), 3, cols - 4);
      if (hasUp == false && currentRoomRow - 1 >= 0 && abs((float)Math.random()) >= .5) {
        if (abs((float)Math.random()) >= .5) {
          floor[1][randomCol] = 'L';  
          locked ++;
        } else {
          floor[1][randomCol] = 'D';
        }
        totaldoors ++;
        hasUp = true;
      } else if (hasDown == false && currentRoomRow + 1 < rooms.length && abs((float)Math.random()) < .5) {
        if (abs((float)Math.random()) < .5) {
          floor[floor.length - 2][randomCol] = 'L';  
          locked ++;
        } else {
          floor[floor.length - 2][randomCol] = 'D';
        }
        totaldoors ++;
        hasDown = true;
      } else if (hasLeft == false && currentRoomCol - 1 >= 0 && abs((float)Math.random()) >= .5) {
        if (abs((float)Math.random()) >= .5) {
          floor[randomRow][1] = 'L';  
          locked ++;
        } else {
          floor[randomRow][1] = 'D';
        }
        totaldoors ++;
        hasLeft = true;
      } else if (hasRight == false && currentRoomCol + 1 < rooms[0].length && abs((float)Math.random()) < .5) {
        if (abs((float)Math.random()) < .5) {
          floor[randomRow][floor[0].length - 2] = 'L';  
          locked ++;
        } else {
          floor[randomRow][floor[0].length - 2] = 'D';
        }
        totaldoors ++;
        hasRight = true;
      }
      tries ++;
    }
    if (tries >= 5) {
      for (int i = totaldoors; i <= numDoors; i++) {
        int randomRow = constrain((int)abs((float)(Math.random() * rows)), 3, rows - 4);
        int randomCol = constrain((int)abs((float)(Math.random() * cols)), 3, cols - 4);
        if (hasUp == false && currentRoomRow - 1 >= 0) {
          floor[1][randomCol] = 'D';  
          totaldoors ++;
          hasUp = true;
        } else if (hasDown == false && currentRoomRow + 1 < rooms.length) {
          floor[floor.length - 2][randomCol] = 'D';  
          totaldoors ++;
          hasDown = true;
        } else if (hasLeft == false && currentRoomCol - 1 >= 0) {
          floor[randomRow][1] = 'D';  
          totaldoors ++;
          hasLeft = true;
        } else if (hasRight == false && currentRoomCol + 1 < rooms[0].length) {
          floor[randomRow][floor[0].length - 2] = 'D';  
          totaldoors ++;
          hasRight = true;
        }
      }
    }
  }

  void addDoors() {
    for (int r = 0; r < floor.length; r++) {
      for (int c = 0; c < floor[0].length; c++) {
        char slot = floor[r][c];
        if (slot == 'D' || slot == 'L') {
          Door door = new Door(0, 0, r, c, "up", true);
          if (r==1) {
            door = new Door((c-1) * 32, 32, r, c, "up", slot=='L');
          } else if ( r == floor.length - 2) {
            door = new Door((c+2) * 32, r * 32 + 12, r, c, "down", slot == 'L');
          } else if ( c == 1) {
            door = new Door(32, 32 * (r - 1), r, c, "left", slot == 'L');
          } else if ( c == floor[0].length - 2) {
            door = new Door(c * 32 + 12, (r+2)  * 32, r, c, "right", slot == 'L');
          }
          doors.add(door);
        }
      }
    }
  }

  void putDoorDown() {
    int randomCol = constrain((int)abs((float)(Math.random() * cols)), 3, cols - 4);
    floor[rows - 2][randomCol] = 'D';
    newX = (randomCol+2) * 32;
    newY = rows * 32 + 12;
  }

  void putDoorUp() {
    int randomCol = constrain((int)abs((float)(Math.random() * cols)), 3, cols - 4);
    floor[1][randomCol] = 'D';
    newX = (randomCol-1) * 32;
    newY = 32;
  }

  void putDoorLeft() {
    int randomRow = constrain((int)abs((float)(Math.random() * rows)), 3, rows - 4);
    floor[randomRow][1] = 'D';
    newX = 32;
    newY = 32 * (randomRow - 1);
  }

  void putDoorRight() {
    int randomRow = constrain((int)abs((float)(Math.random() * rows)), 3, rows - 4);
    floor[randomRow][cols - 2] = 'D';
    newX = cols * 32 + 12; 
    newY = (randomRow+2)  * 32;
  }  


  //=================================================

  //CHECKING METHODS===============================================================
  //Checks if the tile should be a wall or not
  boolean isWall(int row, int col) {
    if (row == 0 || row == rows - 1|| col == 0|| col == cols - 1) return true;
    return false;
  }
  //============================================================================


  //GET METHODS =================================================================

  int getRows() {
    return rows;
  }

  int getCols() {
    return cols;
  }


  float getX() {
    return x;
  }

  float getY() {
    return y;
  } 

  float getWidth() {
    return w;
  }

  float getLength() {
    return l;
  }

  ArrayList<Door> getDoors() {
    return doors;
  }

  ArrayList<Item> getItems() {
    return roomitems;
  }

  ArrayList<Enemy> getEnemies() {
    return roomenemies;
  }

  int numLockedDoors() {
    return locked;
  }
  // =================================================================



  void displayDoors() {
    for (int i = 0; i < doors.size(); i++) {
      Door door =  doors.get(i);
      door.display();
    }
  }


  void displayArrows() {
    for (int i = 0; i < roomarrows.size(); i++) {
      //you need a seperate var to get the object from the bullets arraylist then use that variable to call the functions
      Arrow arrow = roomarrows.get(i);
      arrow.display();
    }
  }

  void displayItems() {
    for (int i = 0; i < roomitems.size(); i++) {
      Item item = roomitems.get(i);
      item.display();
    }
  }

  void display() {
    if (num > 5 && addSword == 0) {
      addSword();
      addSword ++;
    }
    if (num > 7 && addShield == 0) {
      addShield();
      addShield ++;
    }
    if (num > 20 && addBow == 0) {
      addBow();
      addBow++;
    }
    if (person.hp < 50 && addHp == 0) {
      addpotionH();
      addHp++;
    }
    if (person.armor < 20 && addAp == 0) {
      addpotionA();
      addAp++;
    }
    if (run) {
      vel = 25;
    } else {
      vel = 10;
    }
    for (int r = 0; r < floor.length; r++) {
      for (int c = 0; c < floor[0].length; c++) {
        char slot = floor[r][c];
        if (slot == '#') {
          imageMode(CORNER);
          image(wall, x + (32 * c), y + (32 * r));
        } else if (slot == ' ' || slot == 'D' || slot == 'L') {
          imageMode(CORNER);
          image(tile, x + (32 * c), y + (32 * r));
        }
      }
    }
    displayEnemies();
    if (roomitems != null) {
      displayItems();
    }
    if (doors != null) {
      displayDoors();
    }
    if (roomarrows != null) {
      displayArrows();
    }
  }

  String toString() {
    String str = " ";
    for (int r = 0; r < rows; r++) {
      String s = " ";
      for (int c = 0; c < cols; c++) {
        s += floor[r][c] + "";
      }
      str += s + '\n';
    }
    return str;
  }

  //====================================================================

  //MOVE METHODS============================================================================
  void move() {
    if (person.isDead()) {
      return ;
    }
    float newX = x;
    float newY = y;
    if (!person.use) {
      newX = constrain(x + vel *(int(isLeft) - int(isRight)), lowX, highX);
      newY = constrain(y + vel *(int(isUp)  - int(isDown)), lowY, highY);
    }

    moveAll(newX, newY, x, y);
    x = newX;
    y = newY;
  }

  void moveAll(float newX, float newY, float oldX, float oldY) {
    float moveX = newX - oldX;
    float moveY = newY - oldY;
    if (roomitems != null) {
      for (int i = 0; i < roomitems.size(); i++) {
        Item item = roomitems.get(i);
        if (oldX != newX) {
          item.setX(item.getX() + moveX);
        }
        if (oldY != newY) {
          item.setY(item.getY() + moveY);
        }
      }
    }
    if (doors != null) {
      for (int i = 0; i < doors.size(); i++) {
        Door newdoor = doors.get(i);
        if (oldX != newX) {
          newdoor.changeX(moveX);
        }
        if (oldY != newY) {
          newdoor.changeY(moveY);
        }
      }
    }

    if (enemies != null) {
      for (int i = 0; i < enemies.size(); i++) {
        Enemy enemy = enemies.get(i);
        if (oldX != newX) {
          enemy.changeX(moveX);
          enemy.changeConstX(moveX);
        }
        if (oldY != newY) {
          enemy.changeY(moveY);
          enemy.changeConstY(moveY);
        }
        enemy.move();
      }
    }
    if (roomarrows != null) {
      for (int i = 0; i < roomarrows.size(); i++) {
        Arrow arrow = roomarrows.get(i);
        if (oldX != newX) {
          arrow.changeConstX(moveX);
          arrow.changeX(moveX);
        }
        if (oldY != newY) {
          arrow.changeConstY(moveY);
          arrow.changeY(moveY);
        }
        arrow.move();
      }
    }
  }

  boolean setMove(int k, boolean b) {
    switch (k) {
    case SHIFT:
      return run = b;
    case + 'W':
    case 'w':
      return isUp = b;
    case + 'S':  
    case 's':
      return isDown = b;
    case + 'A':  
    case 'a':
      wasLeft = true;
      wasRight = false;
      return isLeft = b;
    case + 'D':  
    case 'd':
      wasLeft = false;
      wasRight = true;
      return isRight = b;
    default:
      return b;
    }
  }
}
