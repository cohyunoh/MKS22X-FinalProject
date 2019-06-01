

class Enemy extends Entity {
  boolean chase, isLeft, isRight, isUp, isDown, wasLeft, wasRight, attack, die;
  int vel = 5, attackDam;
  Enemy(float x, float y, int a){
   super("gorlag", 100, 0, 10.00, "gorlag", x, y);
   attackDam = a;
   die = false;
  }
  
  int getDamage(){
    return attackDam;
  }
  
  void attack(Player person){
    if(!die){
      person.hurt(this);
    }
  }
  
  void die(){
    if(hp <= 0){
      die =  true;
    }
  }
  
  void display(){
    die();
    if(die){
      fill(50);
      rect(xCor, yCor, 30,30);
      attack = false;
    }else{
      if(attack){
        fill(225,0,0);
      }else{
        fill(0,225,225);
      }
      rectMode(CENTER);
      rect(xCor, yCor, 50,50);
      /*
      if(isLeft){
        animLeft.display(xCor - animLeft.getWidth()/2, yCor - animLeft.getHeight()/2);
        return ;
      }
      if(isRight){
        animRight.display(xCor - animRight.getWidth()/2, yCor - animRight.getHeight()/2);
        return ;
      }
      if(isUp) {
        if(wasLeft){
          animLeft.display(xCor - animLeft.getWidth()/2, yCor - animLeft.getHeight()/2);
          return ;
        }
        if (wasRight){
          animRight.display(xCor - animRight.getWidth()/2, yCor - animRight.getHeight()/2);
          return ;
        }
      }
      if(isDown) {
        if(wasLeft){
          animLeft.display(xCor - animLeft.getWidth()/2, yCor - animLeft.getHeight()/2);
          return ;
        }
        if (wasRight){
          animRight.display(xCor - animRight.getWidth()/2, yCor - animRight.getHeight()/2);
          return ;
        }
      }
      if(!isDown && !isUp && !isRight && !isLeft){
        if(wasLeft){
          image(left, xCor, yCor);
          return ;
        }
        if (wasRight){
          image(right, xCor, yCor);
          return ;
        }
      }
      image(right, xCor, yCor);
      */
    }
  }
  
  void move(){
    if(die){
      return ;
    }
    xCor = xCor + vel *(int(isRight) - int(isLeft));
    yCor = yCor + vel *(int(isDown)  - int(isUp));
  }
  void setMove(Player person){
    if(dist(person.getX(), person.getY(),xCor, yCor) < 300 && person.getHealth() > 0){
      chase = true;
      if(person.getX() > xCor){
        wasLeft = false;
        wasRight = true;
        isRight = true;
        isLeft = false;
      }else if(person.getX() < xCor){
        wasLeft = true;
        wasRight = false;
        isRight = false;
        isLeft = true;
      }else{
        isRight = false;
        isLeft = false;
      }
      if(person.getY() > yCor){
        isDown = true;
        isUp = false;
      }else if (person.getY() < yCor){
        isDown = false;
        isUp = true;
      }else{
        isDown = false;
        isUp = false;
      }
    }else{
      chase = false;
      isRight = false;
      isLeft = false;
      isDown = false;
      isUp = false;
    }
  }
  
  void hurt(Player enemy){
    hp -= enemy.getDamage();
    if(enemy.getX() > xCor){
      xCor -= 10;
    }else{
      xCor += 10;
    }
    if(enemy.getY() > yCor){
      yCor -= 10;
    }else{
      yCor += 10;
    }
  }
}
