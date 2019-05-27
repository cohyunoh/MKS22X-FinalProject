class Room {

  Tile[][] floor;
  char current, next;
  int rows, cols;

  public Room(int rows, int cols) {
    this.rows = rows;
    this.cols = cols;
    floor = new Tile[rows][cols];
    initRoom();
  }

  void initRoom() {
    for (int r = 0; r <rows; r++) {
      for (int c = 0; c < cols; c++) {
        double random = Math.random();
        if (random < 0.15) floor[r][c] = new Tile('#');
        if (r == 0|| r == rows - 1) floor[r][c] = new Tile('#');
        else if (c == 0|| c == cols-1) floor[r][c] = new Tile('#');
        else floor[r][c] = new Tile(' ');
      }
    }
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
