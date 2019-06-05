class Enemy extends Entity {
  boolean chase, isLeft, isRight, isUp, isDown, wasLeft, wasRight, attack, die, hasKey;
  int vel = 5, attackDam, num;
  float lowX, lowY, highX, highY;
  ArrayList<Item>inv;
  Enemy(String type, float x, float y, int a) {
    super("gorlag", 100, 0, 100.00, type, x, y);
    attackDam = a;
    die = false;
    inv = new ArrayList<Item>();
    Item coin = new Item(8, 0, 0);
    coin.display = true;
    inv.add(coin);
  }


  void drop() {
    for (int i = 0; i < inv.size(); i++) {
      Item item = inv.get(i);
      item.setX(xCor + (float)Math.random() * 8);
      item.setY(yCor + (float)Math.random() * 8);
      item.show();
      current.roomitems.add(item);
      inv.remove(item);
    }
  }

  int getDamage() {
    return attackDam;
  }

  void addItem(Item item) {
    inv.add(item);
  }

  void attack(Player person) {
    if (!die) {
      person.hurt(this);
    }
  }


  void attack() {
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
      } else if (hasKey) {
        fill(0, 225, 0);
      } else {
        fill(0, 225, 225);
      }

      rectMode(CENTER);
      rect(xCor, yCor, 50, 50);
      fill(255);
      textSize(20);
      text(num, xCor, yCor);
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
    if (die || attack) {
      return ;
    }
    xCor = constrain(xCor + vel *(int(isRight) - int(isLeft)), lowX, highX) ;
    yCor = constrain(yCor + vel *(int(isDown)  - int(isUp)), lowY, highY);
  }

  void setMove() {
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

  void hurt(boolean hurt) {
    float bounce = 10;
    if (dist(person.getX(), person.getY(), xCor, yCor) < 100) {
      if (hurt) {
        hp -= person.getDamage();
        fill(0);
      }
      if (person.block) {
        bounce = 50;
      }
      if (person.getX() > xCor && person.wasLeft) {
        xCor = constrain(xCor - bounce, lowX, highX);
      } else if (person.getX() <= xCor && person.isRight) {
        xCor = constrain(xCor + bounce, lowX, highX);
      }
      if (person.getY() > yCor && person.wasLeft) {
        xCor = constrain(xCor - bounce, lowX, highX);
      } else {
        xCor = constrain(xCor + bounce, lowX, highX);
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

class Mercenary extends Enemy {
  boolean isLeft, isRight, isUp, isDown, wasLeft, wasRight, stroll;
  int diecounter = 0;
  int attackCounter = 0;
  int strollcounter = 10;
  Animation animLeft = new Animation("enemies/mercenary/left", 8);
  Animation animRight = new Animation("enemies/mercenary/right", 8);
  Animation death = new Animation("enemies/mercenary/death", 6);
  Animation attackLeft = new Animation("enemies/mercenary/attack-left", 5);
  Animation attackRight = new Animation("enemies/mercenary/attack-right", 5);
  Mercenary(float x, float y) {
    super("mercenary", x, y, 30);
    hp = (int)abs((float)Math.random() * 50) + 100;
    money = abs((float)Math.random() * 1.00) + hp * 0.005 + attackDam * 0.05 + armor * 0.005;
    Item coin = new Item(8, 0, 0);
    coin.addMoney(money);
    coin.display = false;
    inv.add(coin);
  }

  void die() {
    if (hp <= 0) {
      drop();
      if (diecounter == 0) {
        person.numEnemies++;
      }

      die =  true;
    }
  }

  void display() {
    die();
    if (die) {
      PImage deathI = loadImage("enemies/mercenary/death5.png");
      if (diecounter < 8) {
        death.display(xCor, yCor);
        diecounter++;
        return ;
      }
      if (diecounter >= 8) {
        image(deathI, xCor, yCor);
      }
      attack = false;
      return;
    } else {
      if (attack) {
        if (wasRight) {
          attackRight.display(xCor, yCor);
        }
        if (wasLeft) {
          attackLeft.display(xCor, yCor);
        }
        attackCounter++;
        if (attackCounter >= 5) {
          attack(person);
          attack = false;
        }
        return ;
      }
      if (isRight) {
        animRight.display(xCor, yCor);
        return ;
      }
      if (isLeft) {
        animLeft.display(xCor, yCor);
        return ;
      }
      if (isUp) {
        if (wasRight) {
          animRight.display(xCor, yCor);
          return ;
        }
        if (wasLeft) {
          animLeft.display(xCor, yCor);
          return ;
        }
      }
      if (isDown) {
        if (wasRight) {
          animRight.display(xCor, yCor);
          return ;
        }
        if (wasLeft) {
          animLeft.display(xCor, yCor);
          return ;
        }
      }
    }
  }

  void setMove() {
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
      stroll = true;
    }
    if (stroll) {
      if (strollcounter >= 10) {
        stroll();
        strollcounter = 0;
      } else {
        strollcounter ++;
      }
    }
  }

  void stroll() {
    if (abs((float)Math.random()) > 0.5) {
      isLeft = true;
      wasLeft = true;
      isRight = false;
      wasRight = false;
    } else {
      isLeft = false;
      wasLeft = false;
      isRight = true;
      wasRight = true;
    }
    if (abs((float)Math.random()) > 0.5) {
      isUp = true;
      isDown = false;
    } else {
      isUp = false;
      isDown = true;
    }
  }

  void move() {
    if (die || attack) {
      return ;
    }
    xCor = constrain(xCor + vel *(int(isRight) - int(isLeft)), lowX, highX) ;
    yCor = constrain(yCor + vel *(int(isDown)  - int(isUp)), lowY, highY);
  }
}
