class Room {

  Tile[][] tiles;
  int rows, cols;
  PImage walls, floors;
  final int wall = 1;
  final int floor = 2;

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
    this.walls = loadImage("wall0.png");
    this.floors = loadImage("Floor0.png");
    initTiles();
  }

  void initTiles() {
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        tiles[r][c] = new Tile(floors, floor);
        if (r == 0 || r == rows ) {
          tiles[r][c] = new Tile(walls, wall);
        }
        if (c == 0 || c == cols) {
          tiles[r][c] = new Tile(walls, wall);
        }
      }
    }
  }


  String toString() {
    String str = " ";
    for (Tile[] tile : tiles) {
      String s = " ";
      for (Tile t : tile) {
        if (t.getType() == 1) {
          s += "W";
        } else {
          s += "F";
        }
      }
      str += s + '\n';
    }
    return str;
  }
}
