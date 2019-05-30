import java.util.*;

class Room {

  char[][] floor;
  char current, next;
  int rows, cols, totaldoors;


  public Room(int rows, int cols) {
    this.rows = rows;
    this.cols = cols;
    floor = new char[rows][cols];
    totaldoors = 0;
    initRoom();
  }

  public Room(int rows, int cols, Door door) {
    this.rows = rows;
    this.cols = cols;
    floor = new char[rows][cols];
    totaldoors = 0;
    initRoom(door);
  }

  //THIS IS WHEN YOU HAVE DOOR
  void initRoom(Door door) {
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        if (!isWall(r, c)) floor[r][c] = ' ';
        if (isWall(r, c)) floor[r][c] = '#';
      }
    }
    if (door.isUp()) putDoorDown(door);
    else if (door.isDown(this)) putDoorUp(door);
    else if (door.isLeft()) putDoorLeft(door);
    else putDoorRight(door);
  }

  //WHEN YOU DONT HAVE DOOR
  void initRoom() {
  }

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
  
  void putDoorDown(Door door){
    int doorCol = door.getCol();
    floor[doorCol
  }
  
  void putDoorUp(Door door){
    int doorCol = door.getCol();
  }
  
  void putDoorLeft(Door door){
    int doorRow = door.getRow();
  }
  
  void putDoorRight(Door door){
    int doorRow = door.getRow();
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
}
