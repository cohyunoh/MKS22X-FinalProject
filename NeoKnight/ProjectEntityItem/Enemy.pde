class Gorlag extends Entity{
  boolean chase, isLeft, isRight, isUp, isDown, wasLeft, wasRight;
  int vel = 5;
  Gorlag(float x, float y){
   super("gorlag", 100, 0, 10.00, "gorlag", x, y);
  }
  void display(){
    fill(0,225,225);
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
  
  void move(){
    xCor = xCor + vel *(int(isRight) - int(isLeft));
    yCor = yCor + vel *(int(isDown)  - int(isUp));
  }
  void setMove(Player person){
    if(dist(person.getX(), person.getY(),xCor, yCor) < 50){
      chase = true;
      if(person.getX() >= xCor){
        wasLeft = false;
        wasRight = true;
        isRight = true;
        isLeft = false;
      }else{
        wasLeft = true;
        wasRight = false;
        isRight = false;
        isLeft = true;
      }
      if(person.getY() >= yCor){
        isDown = true;
        isUp = false;
      }else{
        isDown = false;
        isUp = true;
      }
    }else{
      chase = false;
    }
  }
}