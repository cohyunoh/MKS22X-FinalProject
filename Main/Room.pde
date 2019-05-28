class Room {

  char[][] floor;
  char current, next;
  int rows, cols, doors;

  public Room(int rows, int cols) {
    this.rows = rows;
    this.cols = cols;
    floor = new char[rows][cols];
    doors = 0;
    initRoom();
  }

  void initRoom() {
    for (int r = 0; r <rows; r++) {
      for (int c = 0; c < cols; c++) {
        double random = Math.random();
        if (random < 0.15) floor[r][c] = '#';
        if (r == 0|| r == rows - 1) initRowDoors(r, c);
        else if (c == 0|| c == cols-1) initColDoors(r, c);
        else floor[r][c] = '.';
      }
    }/*
    if (doors == 0) {
      int r = Math.random() < .5 ? 0 : rows - 1; 
      int c = Math.random() < .5 ? 0 : cols - 1;
      floor[r][c] = 'D';
      doors++;
    }*/
  }

  void initRowDoors(int row, int col) {
    int countDoors = 0;
    for (int c = 0; c < cols; c++) {
      if (floor[row][c] == 'D') countDoors++;
    }
    if (doors < 2 && countDoors < 2) {
      if (Math.random() < 0.2) floor[row][col] = 'D'; 
      doors++;
    } else floor[row][col] = '#';
  }

  void initColDoors(int row, int col) {
    int countDoors = 0;
    for (int r = 0; r < rows; r++) {
      if (floor[r][col] == 'D') countDoors++;
    }
    if (doors < 2 && countDoors < 1) {
      if (Math.random() < 0.3) floor[row][col] = 'D'; 
      doors++;
    } else floor[row][col] = '#';
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
