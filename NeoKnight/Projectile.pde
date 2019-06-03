class Arrow{
  //standard PVector used for the location of the bullet
  PVector location;
  //vars used to check the angle between location and the mouse
  float oldPosX, oldPosY, rotation, speed;
  Animation arrow = new Animation("projectile/arrow", 3);
  Arrow(){
    //places the arrow in the middle of the room
    location= new PVector(750, 500);
    //this checks the angle
    oldPosX = mouseX;
    oldPosY = mouseY;
    rotation = atan2(oldPosY - location.y, oldPosX - location.x) / PI * 180;
    //arrow speed
    speed = 10;//change this number to change the speed
  }
  
  void display() {
    //move the bullet
    location.x = location.x + cos(rotation/180*PI)*speed;
    location.y = location.y + sin(rotation/180*PI)*speed;
    rect(location.x, location.y, 50, 50);
    //removes the bullet from the arrayList if it is off the room
  }
  
}
