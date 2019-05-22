class Room {

  Tile[][] tiles;
  int rows, cols;

  int rows() { 
    return rows;
  }

  int cols() { 
    return cols;
  }

  public Room(Tile[][] tiles) {
    this.tiles = tiles;
    this.width = tiles.length;
    this.height = tiles[0].length;
  }

  Tile getTile(int x, int y) {
    //chekcs if tile is out of bounds and not vaalid
    if (x < 0 || x >= width || y < 0 || y >= height)
      return Tile.BOUNDS;
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
