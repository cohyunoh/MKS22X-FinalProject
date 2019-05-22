class Tile {

  char symbol;
  int colorr;

  char getSymbol() {
    return symbol;
  }

  int getColor() {
    return colorr;
  }

  private Tile(char symbol, int colorr) {
    this.symbol = symbol;
    this.colorr = colorr;
  }
}
