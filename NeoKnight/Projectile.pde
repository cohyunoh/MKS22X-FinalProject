class Arrow{
  //standard PVector used for the location of the bullet
  //vars used to check the angle between location and the mouse
  float oldPosX, oldPosY, rotation, speed, lowX, lowY, highX, highY, x, y;
  Animation arrow = new Animation("projectile/arrow", 3);
  Arrow(){
    //places the arrow in the middle of the room
    this.x = width / 2;
    this.y = height/ 2;
    //this checks the angle
    oldPosX = mouseX;
    oldPosY = mouseY;
    rotation = atan2(oldPosY - this.y, oldPosX - this.x) / PI * 180;
    //arrow speed
    speed = 10;//change this number to change the speed
  }
  
  void display() {
    rect(x, y, 50, 50);
    //removes the bullet from the arrayList if it is off the room
  }
  
  void move(){
    //move the bullet
    x = constrain(x + cos(rotation/180*PI)*speed, lowX, highX);
    y = constrain(y + sin(rotation/180*PI)*speed, lowY, highY);
  }
  
  void changeX(float x) {
    this.x = constrain(this.x + x, lowX, highX);
  }

  void changeY(float y) {
    this.y = constrain(this.y + y, lowY, highY);
  }
  
  void addConstrainX(float low, float high) {
    lowX = low;
    highX = high;
  }

  void addConstrainY(float low, float high) {
    lowY = low;
    highY = high;
  }

  void changeConstX(float x) {
    lowX += x;
    highX += x;
  }

  void changeConstY(float y) {
    lowY += y;
    highY += y;
  }
}
