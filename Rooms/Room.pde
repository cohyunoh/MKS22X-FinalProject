class Room {

  Tile[][] tiles;
  int rows, cols;

  int row() { 
    return rows;
  }

  int cols() { 
    return cols;
  }

  public Room(int row, int cols) {
    this.tiles = new Tile[row][cols];
    this.rows = row;
    this.cols = cols;
  }
}
