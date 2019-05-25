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
      animRight.display(xCor, yCor);
      return ;
    }
    if(isDown) {
      animLeft.display(xCor, yCor);
      return ;
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
  }
  
  void move(){
    int ww = w>>1;
    int ll = l>>1;
    xCor = constrain(xCor + vel *(int(isRight) - int(isLeft)), ww, width  - ww);
    yCor = constrain(yCor + vel *(int(isDown)  - int(isUp)), ll, height - ll);
  }
  
  boolean setMove(int k, boolean b) {
    switch (k) {
      case +'W':
        vel = 6;
        wasLeft = false;
        wasRight = true;
      case 'w':
        vel = 3;
        wasLeft = false;
        wasRight = true;
        return isUp = b;
   
      case + 'S':
        vel = 6;
        wasLeft = true;
        wasRight = false;
      case 's':
        vel = 3;
        wasLeft = true;
        wasRight = false;
        return isDown = b;
   
      case +'A':
        vel = 6;
        wasLeft = true;
        wasRight = false;
      case 'a':
        vel = 3;
        wasLeft = true;
        wasRight = false;
        return isLeft = b;
   
      case +'D':
        vel = 6;
        wasLeft = false;
        wasRight = true;
      case 'd':
        vel = 3;
        wasLeft = false;
        wasRight = true;
        return isRight = b;
   
      default:
        return b;
      }
  }
  
}
