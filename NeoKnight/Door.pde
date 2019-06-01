class Door {

  //coordinates of the Door
  int row, col;

  //creates door
  public Door(int row, int col) {
    this.row = row;
    this.col = col;
  }

  int getRow() {
    return row;
  }

  int getCol() {
    return col;
  }

  boolean isUp() {
    if (row == 0) return true;
    return false;
  }

  boolean isLeft() {
    if (col == 0) return true;
    return false;
  }

  boolean isDown(Room room) {
    int roomRows = room.getRows();
    if (row == roomRows) return true;
    return false;
  }

  boolean isRight(Room room) {
    int roomCols = room.getCols();
    if (col == roomCols) return true;
    return false;
  }
}
