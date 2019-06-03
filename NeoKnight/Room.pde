import java.util.*;

class Room implements Moveable {
//Instance Variables ========================
  int vel = 5;
  boolean isLeft, isRight, isUp, isDown, wasLeft, wasRight, run, hasLeft, hasRight, hasUp, hasDown;
  char[][] floor;
  char current, next;
  int rows, cols, totaldoors;
  float x, y, lowX, lowY, highX, highY;
  int locked = 0;
  PImage tile = loadImage("floor.png");
  PImage wall = loadImage("wall.png");  
  ArrayList<Enemy> enemies = new ArrayList<Enemy>();
  ArrayList<Item> items = new ArrayList<Item>();
  ArrayList<Door> doors = new ArrayList<Door>();
//==============================================

//Constructors====================================
  public Room(int rows, int cols, float x, float y, boolean up, boolean down, boolean right, boolean left) {
    this.rows = rows;
    this.cols = cols;
    this.x = x;
    this.y = y;
    floor = new char[rows][cols];
    lowX = -1 * ((rows - 1) * 32 - 750) + person.getWidth() / 2;
    lowY = -1 * ((cols - 1) * 32 - 500) + person.getHeight() / 2;
    highX = 750 - (x + 32) - person.getWidth() / 4;
    highY = 500 - (y + 32) - person.getHeight() / 4;
    initRoom();
    addDoors();
    hasUp = up;
    hasDown = down;
    hasRight = right;
    hasLeft = left;
    totaldoors = 0;
    //placeKeys();
  }


  public Room(int rows, int cols, Door door, float x, float y, boolean up, boolean down, boolean right, boolean left) {
    this(rows, cols, x, y, up, down, right, left);
    totaldoors = 1;
    initRoom(door);
    addDoors();
  }

//================================================================
  
  void placeKeys(){
    for (int i = 0; i < locked; i++){
      float randomX = (abs((float)(Math.random() * (rows * 32))));
      float randomY = (abs((float)(Math.random() * (cols * 32))));
      Item keyy = new Item(5,randomX, randomY);
      items.add(keyy);
    }
  }

//ADD METHODS=====================================================
  void addEnemies() {
    for (int i = 0; i < enemies.size(); i++) {
      Enemy enemy = enemies.get(i);
      enemy.setX(constrain( 32 + (int)(abs((float)(Math.random() * (32 * rows)))), 32, 32 * (rows - 2)));
      enemy.setY(constrain( 32 + (int)(abs((float)(Math.random() * (32 * cols)))), 32, 32 * (cols - 2)));
      enemy.addConstrainX(0, 32 * (rows));
      enemy.addConstrainY(0, 32 * (cols));
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
    generateRandomDoor();
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
    int doors = (int)abs((float)(Math.random() * 4)) + 1;
    int randomRow = constrain((int)abs((float)(Math.random() * rows)), 2, rows - 3);
    int randomCol = constrain((int)abs((float)(Math.random() * cols)), 2, cols - 3);
    int lockedDoors = (doors > 1) ? (int)abs((float)(Math.random() * doors)): 0;
    int currentNum = 0;
    int currentLocked = 0;
    //keep going until there is the correct specified number of doors
    while (currentNum != doors) {
      //choose random side
      int side = (int)abs((float)(Math.random() * 101));
      //left side
      if (side<=25 && !hasLeft) {
        if (Math.random() < .3 && currentLocked < lockedDoors ) {
          floor[randomRow][1] = 'L';
          hasLeft = true;
          currentLocked++;
          currentNum++;
          locked++;
        } else {
          floor[randomRow][1] =  'D';
          hasLeft = true;
          currentNum += 1;
        }
        //right side
      } else if (side > 25 && side <= 50 && !hasRight) {
        if (Math.random() < .3 && currentLocked < lockedDoors) {
          floor[randomRow][cols - 2] = 'L';
          hasRight = true;
          currentLocked++;
          currentNum++;
          locked++;
        } else {
          floor[randomRow][cols - 2] =  'D';
          hasRight = true;
          currentNum += 1;
        }
        //top side
      } else if (side > 50 && side <= 75 && !hasUp) {
        if (Math.random() < .3 && currentLocked < lockedDoors) 
        {
          floor[1][randomCol] = 'L';
          hasUp = true;
          currentLocked++;
          currentNum++;
          locked++;
        } else {
          floor[1][randomCol] =  'D';
          hasUp = true;
          currentNum += 1;
        }
        //bottom side
      } else if (side > 75 && !hasDown) {
        if (Math.random() < .3 && currentLocked < lockedDoors) 
        {
          floor[rows - 2][randomCol] = 'L';
          hasDown = true;
          currentLocked++;
          currentNum++;
          locked++;
        } else {
          floor[rows - 2][randomCol] =  'D';
          hasDown = true;
          currentNum += 1;
        }
      }
    }
  }

  void addDoors() {
    for (int r = 0; r < floor.length; r++) {
      for (int c = 0; c < floor[0].length; c++) {
        char slot = floor[r][c];
        if (slot == 'D' || slot == 'L') {
          String dir = "down";
          Door door =  new Door((c - 1) * 32, r * 32, r, c, dir, slot == 'L'); 
          if (r == 1) {
            dir = "up";
            door =  new Door(32 * (c - 1), 32 * r, r, c, dir, slot == 'L');
          }
          if (c == 1) {
            dir = "left";
            door =  new Door(32 * c, 32 * (r - 1), r, c, dir, slot == 'L');
          }
          if (c == floor[0].length - 2) {
            dir = "right";
            door =  new Door(32 * c, 32 * (r - 1), r, c, dir, slot == 'L');
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
    floor[0][randomCol] = 'D';
  }

  void putDoorLeft() {
    int randomRow = constrain((int)abs((float)(Math.random() * rows)), 2, rows - 3);
    floor[randomRow][0] = 'D';
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

  ArrayList<Door> getDoors() {
    return doors;
  }
  
   int numLockedDoors(){
    return locked;
  }
// =================================================================
  
//DISPLAY =============================================================

  void displayEnemies(){
    for (int i = 0; i < enemies.size(); i++) {
      Enemy enemy = enemies.get(i);
      enemy.setMove(person);
      if (dist(person.getX(), person.getY(), enemy.getX(), enemy.getY()) < 50) {
        enemy.attack(person);
        if (person.isHurt()) {
          float newX = 0;
          float newY = 0;
          if (enemy.getX() > x) {
            newX = constrain(x + 30, -1 * abs(750 - ((rows) * 32)) + person.getWidth() / 2, 750 - person.getWidth() / 2);
          } else {
            newX = constrain(x - 30, -1 * abs(750 - ((rows) * 32)) + person.getWidth() / 2, 750 - person.getWidth() / 2);
          }
          if (enemy.getY() > y) {
            newY = constrain(y + 30, -1 * abs(500 - ((cols) * 32)) + person.getHeight() / 2, 500 - person.getHeight() / 2);
          } else {
            newY = constrain(y - 30, -1 * abs(500 - ((cols) * 32)) + person.getHeight() / 2, 500 - person.getHeight() / 2);
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
  
  void displayDoors(){
    for (int i = 0; i < doors.size(); i++) {
      Door door =  doors.get(i);
      door.display();
    }
  }
  
  void displayArrows(){
    for (int i = 0; i < arrows.size(); i++) {
      //you need a seperate var to get the object from the bullets arraylist then use that variable to call the functions
      Arrow arrow = arrows.get(i);
      arrow.display();
    }
  }
  
  void displayItems(){
    for (int i = 0; i < items.size(); i++) {
      Item item = items.get(i);
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
          image(wall, x + (32 * r), y + (32 * c));
        } else if (slot == ' ' || slot == 'D' || slot == 'L') {
          imageMode(CORNER);
          image(tile, x + (32 * r), y + (32 * c));
        }
      }
    }
    if (items != null) {
      displayItems();
    }
    if(arrows != null){
      displayArrows();
    }
    if (enemies != null) {
      displayEnemies();
    }
    if (doors != null) {
      displayDoors();
    }
  }

  //generates a string of the room
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
    float newX = constrain(x + vel *(int(isLeft) - int(isRight)),  lowX, highX);
    float newY = constrain(y + vel *(int(isUp)  - int(isDown)), lowY, highY);
    moveAll(newX, newY, x, y);
    x = newX;
    y = newY;
  }

  void moveAll(float newX, float newY, float oldX, float oldY) {
    float moveX = newX - oldX;
    float moveY = newY - oldY;
    if (items != null) {
      for (int i = 0; i < items.size(); i++) {
        Item item = items.get(i);
        if (oldX != newX) {
          item.setX(item.getX() - moveX);
        }
        if (oldY != newY) {
          item.setY(item.getY() - moveY);
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
    
     if(arrows != null){
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
