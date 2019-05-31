import java.util.*;

class Room {

  char[][] floor;
  char current, next;
  int rows, cols, totaldoors;

  //********   CONSTRUCTORS THAT CREATE ROOMS DEPENDING ON IF THERE WAS A PREVIOUS DOOR OR NOT ********//

  public Room(int rows, int cols) {
    this.rows = rows;
    this.cols = cols;
    floor = new char[rows][cols];
    initRoom();
  }


  public Room(int rows, int cols, Door door) {
    this.rows = rows;
    this.cols = cols;
    floor = new char[rows][cols];
    totaldoors = 0;
    initRoom(door);
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
}
