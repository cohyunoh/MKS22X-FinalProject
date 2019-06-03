class Door {
  Room room;
  //coordinates of the Door
  float x, y;
  int row, col;
  PImage sprite;
  PImage lock = loadImage("lock.png");
  boolean up, down, right, left, isLocked, transport;
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
    if (isLocked) sprite = lock;
    else sprite = loadImage("door-" + direction + ".png");
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
    imageMode(CORNER);
    text(x + ", " + y, x, y + 10);
    image(sprite, x, y);
    transport();
    if(transport){
      currentRoomRow += (int(down) - int(up));
      currentRoomCol += (int(right) - int(left));
      if(isNew(currentRoomRow, currentRoomCol)){
        createNextRoom();
        roomNum ++;
      }else{
        current = rooms[currentRoomRow][currentRoomCol]; 
        roomNum ++;
      }
      setup();
      transport = false;
    }
  }

  void changeX(float x) {
    this.x += x;
  }

  void changeY(float y) {
    this.y += y;
  }
  
  void transport(){
    if(dist(x,y,person.xCor,person.yCor) < 60 && person.useDoor == true){
      transport = true;
    }
  }
  
  void createNextRoom(){
    int rows = (int)(abs((float)(Math.random() * 20))) + 30;
    int cols = (int)(abs((float)(Math.random() * 20))) + 30;
    rooms[currentRoomRow][currentRoomCol] = new Room(rows, cols, this, 0,0, currentRoomRow - 1 < 0, currentRoomRow + 1 >= rooms.length, currentRoomCol + 1 >= rooms[0].length, currentRoomCol - 1 < 0); 
    createEnemies();
    current.addEnemies();
    doors = rooms[currentRoomRow][currentRoomCol].getDoors();
    current = rooms[currentRoomRow][currentRoomCol]; 
  }
  
  boolean isNew(int r, int c){
    return rooms[r][c] == null;
  }
}
