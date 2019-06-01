class Door {

  //coordinates of the Door
  float x, y;
  int row, col;
  PImage sprite = loadImage("door.png");
  boolean up, down, right, left;
  //creates door
  public Door(float x, float y, int row, int col, String direction) {
    this.row = row;
    this.col = col;
    this.x = x;
    this.y = y;
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
    translate(x,y);
    if(up){
      rotate(PI);
    }
    if(down){
      rotate(0);
    }
    if(left){
      rotate(3 * PI / 2);
    }
    if(right){
      rotate(PI / 2);
    }
    imageMode(CENTER);
    image(sprite, x,y);
  }
  
  
}
