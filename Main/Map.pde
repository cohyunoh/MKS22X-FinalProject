class Map {

  Room[][] rooms;
  int rows, cols;
  int[][] moves = {
    {0, 1}, {1, 0}, {0, -1}, {-1, 0}
  };
  ArrayList<Integer> coordinates;

  Map(int rows, int cols) {
    this.rows = rows;
    this.cols = cols;
    rooms = new Room[rows][cols];
    coordinates = new ArrayList<Integer>();
    initRooms();
  }

  void initRooms() {
    //gives starting coords for the map
    int startX = (int)(Math.random() * rooms.length);
    int startY = (int)(Math.random() * rooms[0].length);
    //gives room dimensions
    int row = (int)(Math.random() * width / 4 - 1);
    int col = (int)(Math.random() * height / 4 - 1);
    //creates room and then stores it
    Room r = new Room(row, col);
    rooms[startX][startY] = r;
    //adds the coords into a list of coords
    coordinates.add(startX);
    coordinates.add(startY);
    //initilizes 12 rooms for the plaay
    for (int i = 0; i < 13; i++) {
      //gets whihc direction the next room is and sets those variables
      int direction = (int)(Math.random() * 4);
      startX += moves[direction][0];
      startY += moves[direction][1];
      //dimemnsions of room
      row = (int)(Math.random() * width / 4 - 1);
      col = (int)(Math.random() * height / 4 - 1);
      //checks if room is in bounds annd then creates it 
      if ((startX < rooms.length && startX > 0) && (startY < rooms[0].length && startY > 0)) {
        rooms[startX][startY] = new Room(row, col);
        coordinates.add(startX);
        coordinates.add(startY);
      }
    }
  }

  ArrayList<Integer> getCoords() {
    return this.coordinates;
  }

  Room[][] getMap() {
    return this.rooms;
  }

  String toString() {
    String str = " ";
    for (int r = 0; r < rooms.length; r++) {
      String s = " ";
      for (int c = 0; c < rooms[0].length; c++) {
        if (rooms[r][c] != null) s += rooms[r][c];
      }
      str += s + '\n';
    }
    return str;
  }
}
