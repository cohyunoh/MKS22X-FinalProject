class Tile {

  char symbol;
  int colorr;
  PImage sprite;

  char getSymbol() {
    return symbol;
  }

  int getColor() {
    return colorr;
  }

  public Tile(char symbol, int colorr) {
    this.symbol = symbol;
    this.colorr = colorr;
  }
  
  public Tile(){
    symbol = '#';
    colorr = 255;
  }
  
  public Tile(PImage sprite){
    this.sprite = sprite;
  }
}
