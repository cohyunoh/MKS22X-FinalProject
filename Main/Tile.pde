class Tile {

  PImage sprite;
  int type;

  public Tile(PImage sprite, int type) {
    this.sprite = sprite;
    this.type = type;
  }

  int getType() {
    return this.type;
  }
}
