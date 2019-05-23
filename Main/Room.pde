class Room {

  char[][] tiles;
  int rows, cols;

  int row() { 
    return rows;
  }

  int cols() { 
    return cols;
  }

  Room(int row, int cols) {
    this.tiles = new char[row][cols];
    this.rows = row;
    this.cols = cols;
    initTiles();
  }

  void initTiles() {
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c <cols; c++) {
        tiles[r][c] = (Math.random() < 0.5) ? '@' : '#';
      }
    }
  }

  String toString() {
    String str = " ";
    for (char[] cha : tiles) {
      String s = " ";
      for (char c : cha) {
        s += c;
      }
      str += s + '\n';
    }
    return str;
  }
}
