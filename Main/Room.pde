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
    
  }

//WHEN YOU DONT HAVE DOOR
void initRoom(){
  
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
