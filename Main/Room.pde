import java.util.*;

class Room {
  int vel = 5;
  boolean isLeft, isRight, isUp, isDown, wasLeft, wasRight, run;
  char[][] floor;
  char current, next;
  int rows, cols, totaldoors;
  float x, y;
  PImage tile = loadImage("floor.png");
  PImage wall = loadImage("wall.png");

  //********   CONSTRUCTORS THAT CREATE ROOMS DEPENDING ON IF THERE WAS A PREVIOUS DOOR OR NOT ********//

  public Room(int rows, int cols, float x, float y) {
    this.rows = rows;
    this.cols = cols;
    floor = new char[rows][cols];
    initRoom();
    this.x = x;
    this.y = y;
  }


  public Room(int rows, int cols, Door door, float x, float y) {
    this.rows = rows;
    this.cols = cols;
    floor = new char[rows][cols];
    totaldoors = 0;
    initRoom(door);
    this.x = x;
    this.y = y;
  }

  //********   METHODS THAT INITALIZE ROOMS DEPENDING ON IF THERE IS A PREVIOUS DOOR OR NOT ********//

  void initRoom(Door door) {
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        floor[r][c] = isWall(r, c) ? '#' : ' ';
      }
    }
    if (door.isUp()) putDoorDown();
    else if (door.isDown(this)) putDoorUp();
    else if (door.isLeft()) putDoorLeft();
    else putDoorRight();
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

  //********   METHODS THAT CREATE DOORS PROPERLY ********// 

  void generateRandomDoor() {
    int randomRow = (int)(Math.random() * rows);
    int randomCol = (int)(Math.random() * cols);
    floor[randomRow][randomCol] =  'D';
  }

  void putDoorDown() {
    floor[rows-1][cols/2] = 'D';
  }

  void putDoorUp() {
    floor[0][cols/2] = 'D';
  }

  void putDoorLeft() {
    floor[rows/2][0] = 'D';
  }

  void putDoorRight() {
    floor[rows/2][cols] = 'D';
  }
  
  void display(){
    for(int r = 0; r < floor.length; r++){
      for(int c = 0; c < floor[0].length; c++){
        char slot = floor[r][c];
        if(slot == '#'){
          imageMode(CORNER);
          image(wall, x + (32 * r), y + (32 * c));
        }else if(slot == ' '){
          imageMode(CORNER);
          image(tile, x + (32 * r), y + (32 * c));
        }
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
  
  void move(){
    x = x + vel *(int(isLeft) - int(isRight));
    y = y + vel *(int(isUp)  - int(isDown));
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
