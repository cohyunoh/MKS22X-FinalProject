class Room {

  Tile[][] tiles;
  int rows, cols;
  PImage walls,floors;

  int row() { 
    return rows;
  }

  int cols() { 
    return cols;
  }

  Room(int row, int cols) {
    this.tiles = new Tile[row][cols];
    this.rows = row;
    this.cols = cols;
    this.walls = loadImage("wall/wall0.png");
    this.floors = loadImage("floor/floor0.png");
    initTiles();
  }

  void initTiles() {
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        tiles[r][c] = new Tile(floors);
        if (r == 0 || r == rows ) {
          tiles[r][c] = new Tile(walls);
        }
        if (c == 0 || c == cols) {
          tiles[r][c] = new Tile(walls);
        }
      }
    }
  }
}
