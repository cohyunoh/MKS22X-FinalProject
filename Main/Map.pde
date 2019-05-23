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
    rooms = new Room[rows / 5][cols / 5 ];
    coordinates = new ArrayList<Integer>();
  }

  void initRooms() {
    int startX = (int)(Math.random() * rooms.length);
    int startY = (int)(Math.random() * rooms[0].length);
    int row = (int)(Math.random() * width / 4 - 1);
    int col = (int)(Math.random() * height / 4 - 1);
    Room r = new Room(row, col);
    rooms[startX][startY] = r;
    coordinates.add(startX);
    coordinates.add(startY);
    for (int i = 0; i < 13; i++) {
      int direction = (int)(Math.random() * 4);
      startX += moves[direction][0];
      startY += moves[direction][1];
      row = (int)(Math.random() * width / 4 - 1);
      col = (int)(Math.random() * height / 4 - 1);
      if ((startX < rooms.length && startX > 0) && (startY < rooms[0].length && startY > 0)) {
        rooms[startX][startY] = new Room(row, col);
        coordinates.add(startX);
        coordinates.add(startY);
      }
    }
  }

  ArrayList<Integer> getCoords() {
    return coordinates;
  }

  Room[][] getMap() {
    return this.rooms;
  }

  String toString() {
    String str = " ";
    for (Room[] room : rooms) {
      String s = " ";
      for (Room r : room) {
        if (r != null) {
          s += r.toString()+ '\n';
        }
      }
      if (s.length() > 0) {
        str += s + '\n';
      }
    }
    return str;
  }
}
