class Map {

  Room[][] rooms;
  int rows, cols, startRow, startCol;
  int[][] moves = {
    {0, 1}, {0, -1}, {1, 0}, {-1, 0}
  };

  Map(int rows, int cols) {
    this.rows = rows;
    this.cols = cols;
    rooms = new Room[rows][cols];
    startRow = (int)Math.random() * rows;
    startCol = (int)Math.random() * cols;
    createMap();
  }

  void createMap() {
    rooms[startRow][startCol] = new Room(50, 50);
    //initilaizes all rooms
    for (int i = 0; i < 4; i++) {
      if (Math.random() < .5) {
        int changeRow = moves[i][0];
        int changeCol = moves[i][1];
        if (inBounds(startRow + changeRow, startCol + changeCol)){
          createRooms(startRow+changeRow, startCol+changeCol, new Door(startRow, startCol));
        }
      }
    }
  }

  void createRooms(int row, int col, Door door) {
    if (rooms[row][col] == null) {
      rooms[row][col] = new Room(row, col, door);
      for (int i = 0; i < 4; i++) {
        if (Math.random() < .3) {
          int changeRow = moves[i][0];
          int changeCol = moves[i][1];
          if (rooms[row+changeRow][col+changeCol] == null) {
            createRooms(row+changeRow, col+changeCol, new Door(startRow, startCol));
          }
        }
      }
    }
  }
  
  boolean inBounds(int row, int col){
    if (row > rows || row < 0 || col > cols || col < 0) return false;
    return true;
  }

  Room[][] getMap() {
    return this.rooms;
  }

  String toString() {
    String str = " ";
    for (int r = 0; r < rooms.length; r++) {
      str += rooms[r].toString() + '\n';
    }
    return str;
  }
}
