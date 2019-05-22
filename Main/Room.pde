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
    /*for (int r = 0; r < row; r++){
     for (int c = 0; c < cols; c++){
      tiles[r][c] = new Tile('#', 255); 
     }
    }*/
    this.rows = row;
    this.cols = cols;
  }
}
