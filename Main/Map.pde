class Map {

  Room[] rooms;
  int rows, cols;

  Map(int rows) {
    this.rows = rows;
    this.cols = rows;
    rooms = new Room[rows];
    initRooms();
  }

  void initRooms() {
    for (int r = 0; r < rows; r++) {
        int numRows = (int)(Math.random() * rows);
        int numCols = (int)(Math.random() * cols);
        rooms[r] = new Room(numRows, numCols);
    }
  }

  Room[] getMap() {
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
