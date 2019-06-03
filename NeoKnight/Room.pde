import java.util.*;

class Room implements Moveable {
  int vel = 5;
  boolean isLeft, isRight, isUp, isDown, wasLeft, wasRight, run, hasLeft, hasRight, hasUp, hasDown;
  char[][] floor;
  char current, next;
  int rows, cols, totaldoors;
  float x, y;
  int locked = 0;
  PImage tile = loadImage("floor.png");
  PImage wall = loadImage("wall.png");
  PImage keyy = loadImage("key0.png");
  ArrayList<Enemy> enemies;
  ArrayList<Item> items;
  ArrayList<Door> doors = new ArrayList<Door>();
  Player person;


  public Room(int rows, int cols, float x, float y) {
    this.rows = rows;
    this.cols = cols;
    floor = new char[rows][cols];
    initRoom();
    this.x = x;
    this.y = y;
    addDoors();
    placeKeys();
  }


  public Room(int rows, int cols, Door door, float x, float y) {
    this.rows = rows;
    this.cols = cols;
    floor = new char[rows][cols];
    totaldoors = 0;
    initRoom(door);
    this.x = x;
    this.y = y;
    addDoors();
  }
  
  void placeKeys(){
    for (int i = 0; i < locked; i++){
      int randomRow = (int)(abs((float)(Math.random() * rows)));
      int randomCol = (int)(abs((float)(Math.random() * cols)));
      floor[randomRow][randomCol] = 'K';
    }
  }

  void addEnemies(ArrayList<Enemy> enemies) {
    this.enemies = enemies;
    for (int i = 0; i < enemies.size(); i++) {
      Enemy enemy = enemies.get(i);
      enemy.setX(constrain( 32 + (int)(abs((float)(Math.random() * (32 * rows)))), 32, 32 * (rows - 2)));
      enemy.setY(constrain( 32 + (int)(abs((float)(Math.random() * (32 * cols)))), 32, 32 * (cols - 2)));
      enemy.addConstrainX(0, 32 * (rows));
      enemy.addConstrainY(0, 32 * (cols));
    }
  }

  void addItems(ArrayList<Item> items) {
    this.items = items;
  }

  void addPlayer(Player person) {
    this.person = person;
  }

  void initRoom(Door door) {
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        floor[r][c] = isWall(r, c) ? '#' : ' ';
      }
    }
    if (door.isUp()) {
      putDoorDown(door.getCol() % cols);
      hasDown = true;
    } else if (door.isDown()) {
      putDoorUp(door.getCol() % cols);
      hasUp = true;
    } else if (door.isRight()) {
      putDoorLeft(door.getRow() % rows);
      hasLeft= true;
    } else {
      putDoorRight(door.getRow() % rows);
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

  //Checks if the tile should be a wall or not
  boolean isWall(int row, int col) {
    if (row == 0 || row == rows - 1|| col == 0|| col == cols - 1) return true;
    return false;
  }

  int getRows() {
    return rows;
  }

  int getCols() {
    return cols;
  }

  void generateRandomDoor() {
    int doors = (int)abs((float)(Math.random() * 4)) + 1;
    int lockedDoors = (doors > 1) ? (int)abs((float)(Math.random() * doors)): 0;
    int randomRow = constrain(2 + (int)abs((float)(Math.random() * (rows - 2))), 2, rows - 3);
    int randomCol = constrain(2 + (int)abs((float)(Math.random() * (cols - 2))), 2, cols - 3);
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

  void putDoorDown(int c) {
    floor[rows - 2][c] = 'D';
  }

  void putDoorUp(int c) {
    floor[0][c] = 'D';
  }

  void putDoorLeft(int r) {
    floor[r][0] = 'D';
  }

  void putDoorRight(int r) {
    floor[r][cols - 2] = 'D';
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
        } else if (slot == ' ' || slot == 'D') {
          imageMode(CORNER);
          image(tile, x + (32 * r), y + (32 * c));
        }
        else if (slot == 'K'){
          imageMode(CORNER);
          image(keyy, x + (32 * r), y + (32 * c));
        }
      }
    }


    for (int i = 0; i < doors.size(); i++) {
      Door door = doors.get(i);
      door.display();
    }

    if (items != null) {
      for (int i = 0; i < items.size(); i++) {
        Item item = items.get(i);
        item.display();
      }
    }
    if (enemies != null) {
      for (int i = 0; i < enemies.size(); i++) {
        Enemy enemy = enemies.get(i);
        enemy.setMove(person);
        if (dist(person.getX(), person.getY(), enemy.getX(), enemy.getY()) < 50) {
          enemy.attack(person);
          if (person.isHurt()) {
            float newX = 0;
            float newY = 0;
            float addX = 0;
            float addY = 0;
            if (enemy.getX() > x) {
              newX = constrain(x + 30, -1 * abs(750 - ((rows) * 32)) + person.getWidth() / 2, 750 - person.getWidth() / 2);
              addX = 30;
            } else {
              newX = constrain(x - 30, -1 * abs(750 - ((rows) * 32)) + person.getWidth() / 2, 750 - person.getWidth() / 2);
              addX = -30;
            }
            if (enemy.getY() > y) {
              newY = constrain(y + 30, -1 * abs(500 - ((cols) * 32)) + person.getHeight() / 2, 500 - person.getHeight() / 2);
              addY = 30;
            } else {
              newY = constrain(y - 30, -1 * abs(500 - ((cols) * 32)) + person.getHeight() / 2, 500 - person.getHeight() / 2);
              addY = -30;
            }

            moveAll(addX, addY, newX, newY, x, y);
            x = newX;
            y = newY;

            person.notHurt();
          }
        }
        enemy.display();
      }
    }


    if (doors != null) {
      for (int i = 0; i < doors.size(); i++) {
        Door door =  doors.get(i);
        door.display();
      }
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

  void move() {
    if (person.isDead()) {
      return ;
    }
    float newX = constrain(x + vel *(int(isLeft) - int(isRight)), -1 * abs(750 - ((rows) * 32)) + person.getWidth() / 2, 750 - person.getWidth() / 2);
    float newY = constrain(y + vel *(int(isUp)  - int(isDown)), -1 * abs(500 - ((cols) * 32)) + person.getHeight() / 2, 500 - person.getHeight() / 2);
    moveAll(vel *(int(isLeft) - int(isRight)), vel *(int(isUp)  - int(isDown)), newX, newY, x, y);
    x = newX;
    y = newY;
  }

  void moveAll(float x, float y, float newX, float newY, float oldX, float oldY) {
    if (items != null) {
      for (int i = 0; i < items.size(); i++) {
        Item item = items.get(i);
        if (oldX != newX) {
          item.setX(item.getX() - x);
        }
        if (oldY != newY) {
          item.setY(item.getY() - y);
        }
      }
    }
    if (doors != null) {
      for (int i = 0; i < doors.size(); i++) {
        Door newdoor = doors.get(i);
        if (oldX != newX) {
          newdoor.changeX(x);
        }
        if (oldY != newY) {
          newdoor.changeY(y);
        }
      }
    }

    if (enemies != null) {
      for (int i = 0; i < enemies.size(); i++) {
        Enemy enemy = enemies.get(i);
        if (oldX != newX) {
          enemy.changeX(x);
          enemy.changeConstX(x);
        }
        if (oldY != newY) {
          enemy.changeY(y);
          enemy.changeConstY(y);
        }
        enemy.move();
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

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }

  void addDoors() {
    for (int r = 0; r < floor.length; r++) {
      for (int c = 0; c < floor[0].length; c++) {
        char slot = floor[r][c];

        if (slot == 'D' || slot == 'L') {
          String dir = "down";
          Door door =  new Door(32 * (r + 1), 32 * c + 12, r, c, dir, slot == 'L'); 
          if (r == 1) {
            dir = "up";
            door =  new Door(32 * (r - 1), 32 * c - 12, r, c, dir,slot == 'L');
          }
          if (r == floor.length - 2) {
            dir = "down";
          }
          if (c == 1) {
            dir = "left";
            door =  new Door(32 * r + 12, 32 * (c + 1), r, c, dir,slot == 'L');
          }
          if (c == floor[0].length - 2) {
            dir = "right";
            door =  new Door(32 * r - 12, 32 * (c + 1), r, c, dir,slot == 'L');
          }

          doors.add(door);
        }
      }
    }
  }

  ArrayList<Door> getDoors() {
    return doors;
  }
  
  int numLockedDoors(){
    return locked;
  }
  
}
