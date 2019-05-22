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
}
