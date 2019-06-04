import java.util.*;


class Room implements Moveable {
  //Instance Variables ========================
  int vel = 5;
  boolean isLeft, isRight, isUp, isDown, wasLeft, wasRight, run, hasLeft, hasRight, hasUp, hasDown;
  char[][] floor;
  char current, next;
  int rows, cols, totaldoors;
  float x, y, lowX, lowY, highX, highY, w, l;
  int locked = 0;
  int num;
  PImage tile = loadImage("floor.png");
  PImage wall = loadImage("wall.png");  
  ArrayList<Item> roomitems;
  ArrayList<Enemy> roomenemies;
  ArrayList<Shop> roomshops;
  ArrayList<Door> doors;


  //==============================================

  //Constructors====================================
  public Room(int rows, int cols, float x, float y, int num) {
    doors = new ArrayList<Door>();
    roomenemies = new ArrayList<Enemy>();
    roomshops = shops;
    Shop shop = new Shop(750, 100);
    shops.add(shop);
    roomitems = items;
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
    items = new ArrayList<Item>();
    doors = new ArrayList<Door>();
    arrows = new ArrayList<Arrow>();
    roomenemies = new ArrayList<Enemy>();
    roomshops = shops;
    roomitems = items;
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

  void update() {
    roomitems = items;
  }

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
      int randomRow = constrain((int)abs((float)(Math.random() * rows)), 2, rows - 3);
      int randomCol = constrain((int)abs((float)(Math.random() * cols)), 2, cols - 3);
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
        int randomRow = constrain((int)abs((float)(Math.random() * rows)), 2, rows - 3);
        int randomCol = constrain((int)abs((float)(Math.random() * cols)), 2, cols - 3);
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
    int randomCol = constrain((int)abs((float)(Math.random() * cols)), 2, cols - 3);
    floor[rows - 2][randomCol] = 'D';
  }

  void putDoorUp() {
    int randomCol = constrain((int)abs((float)(Math.random() * cols)), 2, cols - 3);
    floor[1][randomCol] = 'D';
  }

  void putDoorLeft() {
    int randomRow = constrain((int)abs((float)(Math.random() * rows)), 2, rows - 3);
    floor[randomRow][1] = 'D';
  }

  void putDoorRight() {
    int randomRow = constrain((int)abs((float)(Math.random() * rows)), 2, rows - 3);
    floor[randomRow][cols - 2] = 'D';
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

  //DISPLAY =============================================================

  void displayEnemies() {
    for (int i = 0; i < roomenemies.size(); i++) {
      Enemy enemy = roomenemies.get(i);
      enemy.setMove(person);
      if (dist(person.getX(), person.getY(), enemy.getX(), enemy.getY()) < 50) {
        enemy.attack();
        if (person.isHurt()) {
          float newX = 0;
          float newY = 0;
          if (enemy.getX() > x) {
            newX = constrain(x + 30, -1 * abs(750 - ((cols) * 32)) + person.getWidth() / 2, 750 - person.getWidth() / 2);
          } else {
            newX = constrain(x - 30, -1 * abs(750 - ((cols) * 32)) + person.getWidth() / 2, 750 - person.getWidth() / 2);
          }
          if (enemy.getY() > y) {
            newY = constrain(y + 30, -1 * abs(500 - ((rows) * 32)) + person.getHeight() / 2, 500 - person.getHeight() / 2);
          } else {
            newY = constrain(y - 30, -1 * abs(500 - ((rows) * 32)) + person.getHeight() / 2, 500 - person.getHeight() / 2);
          }

          moveAll(newX, newY, x, y);
          x = newX;
          y = newY;

          person.notHurt();
        }
      }
      enemy.display();
    }
  }

  void displayShops() {
    for (Shop shop : roomshops) {
      shop.display();
    }
  }

  void displayDoors() {
    for (int i = 0; i < doors.size(); i++) {
      Door door =  doors.get(i);
      door.display();
    }
  }

  void displayArrows() {
    for (int i = 0; i < arrows.size(); i++) {
      //you need a seperate var to get the object from the bullets arraylist then use that variable to call the functions
      Arrow arrow = arrows.get(i);
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
    if (items != null) {
      displayItems();
    }
    if (enemies != null) {
      displayEnemies();
    }
    if (doors != null) {
      displayDoors();
    }
    if (shops != null) {
      displayShops();
    }
    if (arrows != null) {
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
    if (shops != null) {
      for (int i = 0; i < shops.size(); i++) {
        Shop shop = shops.get(i);
        if (oldX != newX) {
          shop.changeX(moveX);
          shop.changeConstX(moveX);
        }
        if (oldY != newY) {
          shop.changeY(moveY);
          shop.changeConstY(moveY);
        }
      }
    }
    if (items != null) {
      for (int i = 0; i < items.size(); i++) {
        Item item = items.get(i);
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
    if (arrows != null) {
      for (int i = 0; i < arrows.size(); i++) {
        Arrow arrow = arrows.get(i);
        if (oldX != newX) {
          arrow.changeX(moveX);
          arrow.changeConstX(moveX);
        }
        if (oldY != newY) {
          arrow.changeY(moveY);
          arrow.changeConstY(moveY);
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
