class Door {
  Room room;
  //coordinates of the Door
  float x, y;
  int row, col;
  PImage sprite;
  PImage lock = loadImage("lock.png");
  boolean up, down, right, left, isLocked;
  //creates door
  void addRoom(Room newRoom){
    room = newRoom;
  }
  
  public Door(float x, float y, int row, int col, String direction, boolean isLocked) {
    this.row = row;
    this.col = col;
    this.x = x;
    this.y = y;
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

  int getRow() {
    return row;
  }

  int getCol() {
    return col;
  }

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

  void display() {
    imageMode(CENTER);
    image(sprite, x, y);
  }

  void changeX(float x) {
    this.x += x;
  }

  void changeY(float y) {
    this.y += y;
  }
  
  void transport(){
    if(dist(x,y,person.xCor,person.yCor) < 30){
      currentRoomRow = int(up) + int(down);
      currentRoomRow = int(left) + int(right);
      createNextRoom();
    }
  }
  
  void createNextRoom(){
    int rows = (int)(abs((float)(Math.random() * 20))) + 30;
    int cols = (int)(abs((float)(Math.random() * 20))) + 30;
    rooms[currentRoomRow][currentRoomCol] = new Room(rows, cols, this, 0,0, currentRoomRow - 1 >= 0, currentRoomRow + 1 < rooms.length, currentRoomCol + 1 < rooms[0].length, currentRoomCol - 1 >= 0); 
    rooms[currentRoomRow][currentRoomCol].addPlayer(person);
    createEnemies();
    rooms[currentRoomRow][currentRoomCol].addEnemies(enemies);
    doors = rooms[currentRoomRow][currentRoomCol].getDoors();
    current = rooms[currentRoomRow][currentRoomCol]; 
  }
}
