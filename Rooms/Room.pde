class Room {

  Tile[][] tiles;
  int rows, cols;

  int row() { 
    return rows;
  }

  int cols() { 
    return cols;
  }

  public Room(int row,int cols) {
    this.tiles = new Tile[row][cols];
    this.width = tiles.length;
    this.height = tiles[0].length;
  }

  Tile getTile(int x, int y) {
    //chekcs if tile is out of bounds and not vaalid
    if (x < 0 || x >= width || y < 0 || y >= height)
      return Tile.WALL;
    else
      return tiles[x][y];
  }

  char getSymbol(int x, int y) {
    return tile(x, y).getSymbol();
  }

  color getColor(int x, int y) {
    return tile(x, y).getColor();
  }
}
