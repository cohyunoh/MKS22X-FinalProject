

class Enemy extends Entity {
  boolean chase, isLeft, isRight, isUp, isDown, wasLeft, wasRight, attack, die, hasKey;
  int vel = 5, attackDam, num;
  float lowX, lowY, highX, highY;
  ArrayList<Item>inv;
  Enemy(float x, float y, int a) {
    super("gorlag", 100, 0, 10.00, "gorlag", x, y);
    attackDam = a;
    die = false;
    inv = new ArrayList<Item>();
  }


  void drop(){
    for(int i = 0; i < inv.size(); i++){
      Item item = inv.get(i);
      item.setX(xCor + (float)Math.random() * 8);
      item.setY(yCor + (float)Math.random() * 8);
      item.show();
      items.add(item);
      inv.remove(item);
    }
  }

  int getDamage() {
    return attackDam;
  }

  void addItem(Item item){
    inv.add(item);
  }

  void attack(Player person) {
    if (!die) {
      person.hurt(this);
    }
  }
  
  void attack(){
    attack = true;
  }

  void die() {
    if (hp <= 0) {
      drop();
      die =  true;
    }
  }

  void display() {
    die();
    if (die) {
      fill(50);
      rect(xCor, yCor, 30, 30);
      attack = false;
    } else {
      if (attack) {
        fill(225, 0, 0);
        attack(person);
        attack = false;
      }else if(hasKey){
        fill(0,225,0);
      }else {
        fill(0, 225, 225);
      }
      
      rectMode(CENTER);
      rect(xCor, yCor, 50, 50);
      fill(255);
      textSize(20);
      text(num,xCor, yCor);
    }
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



  void move() {
    if (die) {
      return ;
    }
    xCor = constrain(xCor + vel *(int(isRight) - int(isLeft)), lowX, highX) ;
    yCor = constrain(yCor + vel *(int(isDown)  - int(isUp)), lowY, highY);
  }
  void setMove(Player person) {
    if (dist(person.getX(), person.getY(), xCor, yCor) < 300 && person.getHealth() > 0) {
      chase = true;
      if (person.getX() > xCor) {
        wasLeft = false;
        wasRight = true;
        isRight = true;
        isLeft = false;
      } else if (person.getX() < xCor) {
        wasLeft = true;
        wasRight = false;
        isRight = false;
        isLeft = true;
      } else {
        isRight = false;
        isLeft = false;
      }
      if (person.getY() > yCor) {
        isDown = true;
        isUp = false;
      } else if (person.getY() < yCor) {
        isDown = false;
        isUp = true;
      } else {
        isDown = false;
        isUp = false;
      }
    } else {
      chase = false;
      isRight = false;
      isLeft = false;
      isDown = false;
      isUp = false;
    }
  }

  void hurt() {
    if(dist(person.getX(), person.getY(),xCor, yCor) < 100){
      hp -= person.getDamage();
      if (person.getX() > xCor && person.isLeft) {
        xCor = constrain(xCor - 10,lowX,highX);
      } else if(person.getX() <= xCor && person.isRight) {
        xCor = constrain(xCor + 10,lowX,highX);
      }
      if (person.getY() > yCor) {
        yCor = constrain(yCor - 10,lowY,highY);
      } else {
        yCor = constrain(yCor + 10,lowY,highY);
      }
    }
  }

  void changeX(float x) {
    xCor = constrain(xCor + x, lowX, highX);
  }

  void changeY(float y) {
    yCor = constrain(yCor + y, lowY, highY);
  }
}
