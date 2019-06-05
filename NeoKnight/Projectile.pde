class Arrow {
  //standard PVector used for the location of the bullet
  //vars used to check the angle between location and the mouse
  float oldPosX, oldPosY, rotation, speed, lowX, lowY, highX, highY, x, y, newX, newY;
  Animation arrow = new Animation("projectile/arrow", 4);
  boolean moving;
  PImage stationary;
  Arrow(float x, float y) {
    //places the arrow in the middle of the room
    this.x = x;
    this.y = y;
    //this checks the angle
    oldPosX = mouseX;
    oldPosY = mouseY;
    rotation = atan2(oldPosY - this.y, oldPosX - this.x);
    //arrow speed
    speed = 25;//change this number to change the speed
    moving = true;
    stationary = loadImage("projectile/arrow3.png");
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(rotation);
    if (moving) {
      arrow.display(0, 0);
    } else {
      imageMode(CENTER);
      image(stationary, 0, 0);
      current.roomarrows.remove(this);
    }
    popMatrix();
    attack();

    //removes the bullet from the arrayList if it is off the room
  }

  void move() {
    //move the bullet
    newX = constrain(x + cos(rotation)*speed, lowX, highX);
    newY = constrain(y + sin(rotation)*speed, lowY, highY);
    if (newX != x && newY != y) { 
      x = newX;
      y = newY;
    } else {
      moving = false;
    }
    x = newX;
    y = newY;
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

  void attack() {
    for (Enemy enemy : enemies) {
      if (dist(enemy.getX(), enemy.getY(), x, y) < 50) {
        enemy.hp -= 10;
        enemy.xCor += 30 * int(x < enemy.getX()) - int(x > enemy.getX()) ; 
        enemy.yCor += 30 * int(y < enemy.getY()) - int(y > enemy.getY()) ; 
        current.roomarrows.remove(this);
      }
    }
  }
}
