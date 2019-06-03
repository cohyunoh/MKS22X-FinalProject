class Map {

  Room[][] rooms;
  int rows, cols, startRow, startCol, numRooms, maxRooms;
  int[][] moves = {
    {0, 1}, {0, -1}, {1, 0}, {-1, 0}
  };

  Map(int rows, int cols) {
    this.rows = rows;
    this.cols = cols;
    rooms = new Room[rows][cols];
    startRow = (int)abs((float)(Math.random() * rows));
    startCol = (int)abs((float)(Math.random() * cols));
    //maxRooms = (int)abs((float)(Math.random() * 5));
    numRooms = 0;
    createMap();
  }

  //This creates a map where the starting room is always 50x50 and then creates four rooms in every direction
  void createMap() {
    rooms[startRow][startCol] = new Room(50, 70, 0, 0, startRow - 1 >= 0, startRow + 1 < rooms.length, startCol + 1 < rooms[0].length, startCol - 1 >= 0);
    /*
    //initilaizes all rooms
    numRooms ++;
    ArrayList<Door> doors = rooms[startRow][startCol].getDoors();
    for (int i = 0; i < doors.size(); i++) {
      Door door = doors.get(i);
      int c = 0;
      if (door.isUp()) {
        c = 0;
      }
      if (door.isDown()) {
        c = 1;
      }
      if (door.isLeft()) {
        c = 2;
      }
      if (door.isRight()) {
        c = 3;
      }
      */
      /*
      int changeRow = moves[c][0];
      int changeCol = moves[c][1];
      if (inBounds(startRow + changeRow, startCol + changeCol)) {
        createRooms(startRow+changeRow, startCol+changeCol, door);
      }
      */
   }
   /*
  //recursively initalizes every room in the array 
  void createRooms(int row, int col, Door door) {
   // if (numRooms >= maxRooms) {
   //   return ;
   // }
    if (rooms[row][col] == null) {
      int roomRows = (int)abs((float)(Math.random() * 50)) + 30;
      int roomCols = (int)abs((float)(Math.random() * 50)) + 30;
      rooms[row][col] = new Room(roomRows, roomCols, door, 0, 0);
      numRooms ++;
      ArrayList<Door> doors = rooms[row][col].getDoors();
      for (int i = 0; i < doors.size(); i++) {
        Door newdoor = doors.get(i);
        int c = 0;
        if (door.isUp()) {
          c = 0;
        }
        if (door.isDown()) {
          c = 1;
        }
        if (door.isLeft()) {
          c = 2;
        }
        if (door.isRight()) {
          c = 3;
        }
        int changeRow = moves[c][0];
        int changeCol = moves[c][1];
        if (inBounds(row+changeRow, col+changeCol) && rooms[row+changeRow][col+changeCol] == null ) {
          createRooms(row+changeRow, col+changeCol, newdoor);
        }
      }
    }
  }
  */



  int getStartRow() {
    return startRow;
  }

  int getStartCol() {
    return startCol;
  }

  //checks if room is in bounds
  boolean inBounds(int row, int col) {
    if (row >= rows || row < 0 || col >= cols || col < 0) return false;
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
