class Map {

  Room[][] rooms;
  int rows, cols;
  int[][] moves = {
    {0, 1}, {1, 0}, {0, -1}, {-1, 0}
  };

  Map(int rows, int cols) {
    this.rows = rows;
    this.cols = cols;
    rooms = new Room[rows / 5][cols / 5 ];
  }

  void initRooms() {
    int startX = (int)(Math.random() * rooms.length);
    int startY = (int)(Math.random() * rooms[0].length);
    int row = (int)(Math.random() * width/2 - 1);
    int col = (int)(Math.random() * height/2 - 1);
    Room r = new Room(row, col);
    rooms[startX][startY] = r;
    for (int i = 0; i < 13; i++) {
      int direction = (int)(Math.random() * 4);
      startX += moves[direction][0];
      startY += moves[direction][1];
      row = (int)(Math.random() * width/2 - 1);
      col = (int)(Math.random() * height/2 - 1);
      if (startX < 0) startX *= -1;
      if (startY < 0) startY *= -1;
      if (startX > width) startX *= -1;
      if (startY > height) startY *= -1;
      rooms[startX][startY] = new Room(row, col);
    }
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
