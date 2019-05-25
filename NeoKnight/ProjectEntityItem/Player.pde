class Player extends Entity implements Moveable {
  int vel = 5;
  boolean isLeft, isRight, isUp, isDown, wasLeft, wasRight, run;
  int w,l;
  Player(String startname, String type, float xCor, float yCor){
    super(startname, 100, 100, 1.00, type, xCor, yCor);
    w = animLeft.getWidth();
    l = animLeft.getHeight();
  }
  
  void display(){
    if(run){
      vel = 25;
    }else{
      vel = 10;
    }
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
  }
  
  void move(){
    xCor = xCor + vel *(int(isRight) - int(isLeft));
    yCor = yCor + vel *(int(isDown)  - int(isUp));
  }
  
  boolean setMove(int k, boolean b) {
    switch (k) {
      case SHIFT:
        return run = b;
      case + 'W':
      case 'w':
        return isUp = b;
      case + 'S':  
      case 's':
        return isDown = b;
      case + 'A':  
      case 'a':
        wasLeft = true;
        wasRight = false;
        return isLeft = b;
      case + 'D':  
      case 'd':
        wasLeft = false;
        wasRight = true;
        return isRight = b;
   
      default:
        return b;
      }
  }
  
}
