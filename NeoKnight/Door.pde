class Door {

  //coordinates of the Door
  float x, y;
  int row, col;
  PImage sprite;
  PImage lock = loadImage("lock.png");
  boolean up, down, right, left, isLocked, transport;
  String dir;
  //creates door

  public Door(float x, float y, int row, int col, String direction, boolean isLocked) {
    this.row = row;
    this.col = col;
    this.x = x;
    this.y = y;
    dir= direction;
    this.isLocked = isLocked;
    sprite = loadImage("door-" + direction + ".png");
    if (direction.equals("up")) {
      up = true;
    }
    if (direction.equals("down")) {
      down = true;
    }
    if (direction.equals("left")) {
      left = true;
    }
    if (direction.equals("right")) {
      right = true;
    }
  }

  //GET METHODS===============================================================================================
  int getRow() {
    return row;
  }

  int getCol() {
    return col;
  }
  //===========================================================================================================

  //CHECK METHODS==============================================================================================

  boolean isUp() {
    return up;
  }

  boolean isDown() {
    return down;
  }

  boolean isLeft() {
    return left;
  }

  boolean isRight() {
    return right;
  }
  //===========================================================================================================

  void display() {
    imageMode(CENTER);
    image(sprite, x, y);
    if (isLocked) {
      imageMode(CENTER);
      image(lock, x, y);
    }
    transport();
    if (transport) {
      int newRow = currentRoomRow + (int(down) - int(up));
      int newCol = currentRoomCol + (int(right) - int(left));
      if (isNew(newRow, newCol)) {
        roomNum ++;
        currentRoomRow = newRow;
        currentRoomCol = newCol;
        map.createNextRoom(this);
        createEnemies();
        current.addEnemies();
        current.addKeys();
      } else {
        currentRoomRow = newRow;
        currentRoomCol = newCol;
        current = rooms[currentRoomRow][currentRoomCol];
        enemies = current.roomenemies;
      }
      transport = false;
    }
  }

  void changeX(float x) {
    this.x += x;
  }

  void changeY(float y) {
    this.y += y;
  }

  void transport() {
    if (dist(x, y, person.xCor, person.yCor) < 60 && person.useDoor == true) {
      if (!isLocked) {
        transport = true;
      }
    }
  }

  boolean hasKey(Player person) {
    for (int i = 0; i < person.inv.size(); i++) {
      Item item = person.inv.get(i);
      if (item.getName().equals("key")) {
        return true;
      }
    }
    return false;
  }

  boolean isNew(int r, int c) {
    return rooms[r][c] == null;
  }

  void setLocked(boolean locked) {
    isLocked = locked;
  }
}
