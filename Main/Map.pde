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
    createMap();
    startRow = (int)Math.random() * rows;
    startCol = (int)Math.random() * cols;
  }

  void createMap() {
    int whichDirection = (int)(Math.random() * 4);
    rooms[startRow][startCol] = new Room(50, 50);
    int changeRow = moves[whichDirection][0];
    int changeCol = moves[whichDirection][1];
    createRooms(startRow+changeRow, startCol+changeCol, new Door(startRow, startCol));
  }

  void createRooms(int row, int col, Door door) {
    if (rooms[row][col] == null) {
      rooms[row][col] = new Room(row, col, door);
      int whichDirection = (int)(Math.random() * 4);
      int changeRow = moves[whichDirection][0];
      int changeCol = moves[whichDirection][1];
      createRooms(startRow+changeRow, startCol+changeCol, new Door(startRow, startCol));
    }
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
