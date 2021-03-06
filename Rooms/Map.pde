int currentState = 0;
Room[][] rooms;
int rows, cols;
int[][] moves = {
  {0, 1}, {1, 0}, {0, -1}, {-1, 0}
};

void Map(int rows, int cols) {
  this.rows = rows;
  this.cols = cols;
  rooms = new Room[rows][cols];
  initRooms();
}

void initRooms() {
  int startX = (int)(Math.random() * rows);
  int startY = (int)(Math.random() * cols);
  int row = (int)(Math.random() * width - 1);
  int col = (int)(Math.random() * height - 1);
  rooms[startX][startY] = new Room(row, col);
  for (int i = 0; i < 13; i++) {
    int direction = (int)(Math.random() * 4);
    startX+= moves[direction][0];
    startY+= moves[direction][1];
    row = (int)(Math.random() * width - 1);
    col = (int)(Math.random() * height - 1);
    rooms[startX][startY] = new Room(row, col);
  }
}
