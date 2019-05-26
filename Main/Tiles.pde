class Tile {

  char current;
  char next;

  public Tile(char current) {
    this.current = current;
  }

  void move() {
    current = next;
  }

  String toString() {
    return this.getCurrent() + "";
  }

  char getCurrent() {
    return current;
  }

  void setCurrent(char current) {
    this.current = current;
  }

  void setNext(char next) {
    this.next = next;
  }
}
