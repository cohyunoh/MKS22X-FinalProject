class Player extends Entity implements Moveable {
  int vel = 3;
  boolean isLeft, isRight, isUp, isDown, wasLeft, wasRight;
  int w,l;
  Player(String startname, String type, float xCor, float yCor){
    super(startname, 100, 100, 1.00, type, xCor, yCor);
    w = animLeft.getWidth();
    l = animLeft.getHeight();
  }
  
  void display(){
    if(isLeft){
      animLeft.display(xCor, yCor);
      return ;
    }
    if(isRight){
      animRight.display(xCor, yCor);
      return ;
    }
    if(isUp) {
      if(wasLeft){
        animLeft.display(xCor, yCor);
        return ;
      }
      if (wasRight){
        animRight.display(xCor, yCor);
        return ;
      }
    }
    if(isDown) {
      if(wasLeft){
        animLeft.display(xCor, yCor);
        return ;
      }
      if (wasRight){
        animRight.display(xCor, yCor);
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
    int ww = w>>1;
    int ll = l>>1;
    xCor = constrain(xCor + vel *(int(isRight) - int(isLeft)), ww, width  - ww);
    yCor = constrain(yCor + vel *(int(isDown)  - int(isUp)), ll, height - ll);
  }
  
  boolean setMove(int k, boolean b) {
    switch (k) {
      case 'W':
        vel = 30;
        return isUp = b;
      case 'w':
        vel = 5;
        return isUp = b;
   
      case 'S':
        vel = 30;
        return isDown = b;
        
      case 's':
        vel = 5;
        return isDown = b;
   
      case 'A':
        vel = 30;
        wasLeft = true;
        wasRight = false;
        return isLeft = b;
        
      case 'a':
        vel = 5;
        wasLeft = true;
        wasRight = false;
        return isLeft = b;
   
      case 'D':
        vel = 30;
        wasLeft = false;
        wasRight = true;
        return isRight = b;
        
      case 'd':
        vel = 5;
        wasLeft = false;
        wasRight = true;
        return isRight = b;
   
      default:
        return b;
      }
  }
  
}
