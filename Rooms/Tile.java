enum Tile {

  FLOOR, WALL, BOUNDS;

  char symbol, color colorr;

  char getSymbol() {
    return symbol;
  }

  color getColor() {
    return colorr;
  }

  private Tile(char symbol, color colorr) {
    this.symbol = symbol;
    this.colorr = colorr;
  }
}
