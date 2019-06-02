class Door {

  //coordinates of the Door
  float x, y;
  int row, col;
  PImage sprite;
  boolean up, down, right, left,isLocked;
  //creates door
  public Door(float x, float y, int row, int col, String direction) {
    this.row = row;
    this.col = col;
    this.x = x;
    this.y = y;
    sprite = loadImage("door-" + direction + ".png");
    if(direction.equals("up")){
      up = true;
      
    }
    if(direction.equals("down")){
      down = true;
    }
    if(direction.equals("left")){
      left = true;
    }
    if(direction.equals("right")){
      right = true;
    }
  }

  int getRow() {
    return row;
  }

  int getCol() {
    return col;
  }
  
  boolean isUp(){
    return up;
  }
  
  boolean isDown(){
    return down;
  }
  
  boolean isLeft(){
    return left;
  }
  
  boolean isRight(){
    return right;
  }
  
  void display(){
    imageMode(CENTER);
    image(sprite, x,y);
  }
  
  void changeX(float x){
    this.x += x;
  }
  
  void changeY(float y){
    this.y += y;
  }
  
}
