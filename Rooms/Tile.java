enum Tile {

  FLOOR, WALL, BOUNDS;

  char symbol, color colorr;

  char symbol() {
    return symbol;
  }

  color color() {
    return colorr;
  }

  private Tile(char symbol, color colorr) {
    this.symbol = symbol;
    this.colorr = colorr;
  }
}
