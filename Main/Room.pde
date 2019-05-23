class Room {

  char[][] tiles;
  int rows, cols;

  int row() { 
    return rows;
  }

  int cols() { 
    return cols;
  }

  public Room(int row, int cols) {
    this.tiles = new char[row][cols];
    this.rows = row;
    this.cols = cols;
  }
}
