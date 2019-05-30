import java.util.*;

class Room {

  char[][] floor;
  ArrayList<Integer> coords;
  char current, next;
  int rows, cols, totaldoors;


  public Room(int rows, int cols) {
    this.rows = rows;
    this.cols = cols;
    floor = new char[rows][cols];
    totaldoors = 0;
    initRoom(rows, cols);
    coords = new ArrayList();
  }

  public Room(int rows, int cols, Door door) {
    this.rows = rows;
    this.cols = cols;
    floor = new char[rows][cols];
    coords = new ArrayList();
    totaldoors = 0;
    initRoom(door.getRow() - 1, door.getCol() - 1);
  }


  void initRoom(int row, int col) {
    /*float wid = textWidth('#');
     float wid2 = textWidth('.');
     int newWid = (int)Math.min(wid,wid2) / (int)(wid + wid2);*/
    textSize(10);
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        floor[r][c] = ' ';
        if (r == 0 || r == rows - 1 || c == 0 || c == cols - 1) {
          if (Math.random() < .1 && totaldoors < 4) {
            floor[r][c] = 'D';
            //coords.add(r);
            //coords.add(c);
            totaldoors++;
          } else floor[r][c] = 'W';
        }
      }
    }
    floor[rows][cols] = 'D';
    //coords.add(row);
    //coords.add(col);
  }

  ArrayList<Integer> getDoors() {
    return coords;
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
