class Map {
  Room[][] maprooms;
  int rows, cols, startRow, startCol, numRooms, maxRooms;

  //Constructors===============================================================================================
  Map(int rows, int cols) {
    this.rows = rows;
    this.cols = cols;
    maprooms = new Room[rows][cols];
    rooms = maprooms;
    startRow = (int)abs((float)(Math.random() * rows));
    startCol = (int)abs((float)(Math.random() * cols));
    numRooms = 0;
    createMap();
  }

  //This creates a map where the starting room is always 50x50 and then creates four rooms in every direction
  void createMap() {
    maprooms[startRow][startCol] = new Room(50, 70, 0, 0, roomNum);
  }

  void createNextRoom(Door door) {
    int rows = (int)(abs((float)(Math.random() * 20))) + 30;
    int cols = (int)(abs((float)(Math.random() * 20))) + 30;
    rooms[currentRoomRow][currentRoomCol] = new Room(rows, cols, door, 0, 0, roomNum); 
    current = rooms[currentRoomRow][currentRoomCol];
  }

  //GET METHODS=================================================================================
  int getStartRow() {
    return startRow;
  }

  int getStartCol() {
    return startCol;
  }

  Room[][] getMap() {
    return maprooms;
  }
  //============================================================================================

  //checks if room is in bounds
  boolean inBounds(int row, int col) {
    if (row >= rows || row < 0 || col >= cols || col < 0) return false;
    return true;
  }

  String toString() {
    String str = " ";
    for (int r = 0; r < rooms.length; r++) {
      str += rooms[r].toString() + '\n';
    }
    return str;
  }
}
