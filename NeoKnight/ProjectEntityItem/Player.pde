class Player extends Entity implements Moveable {
  int vel = 5;
  boolean isLeft, isRight, isUp, isDown, wasLeft, wasRight, run, grab;
  int w,l;
  ArrayList<Item> inv;
  Player(String startname, String type, float xCor, float yCor){
    super(startname, 100, 100, 1.00, type, xCor, yCor);
    w = animLeft.getWidth();
    l = animLeft.getHeight();
    inv = new ArrayList<Item>();
    inv.add(null);
    inHand = inv.get(0);
  }
  
  void display(ArrayList<Item> items){
    rectMode(CORNER);
    fill(225,0,0);
    rect(10,10,hp,10);
    if(grab){
      grab(items);
    }
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
  
  void grab(ArrayList<Item> items){
    for(int i = 0; i < items.size(); i ++){
      Item item = items.get(i);
      if(dist(item.getX(),item.getY(),xCor,yCor) <= 20){
        item.setPicked(true);
        inv.add(item);
        items.remove(i);
      }
    }
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
      case + 'E':
      case + 'e':
        return grab = b;
      default:
        return b;
      }
  }
  
  String stringInv(){
    String ans = "";
    for (int i = 1; i < inv.size(); i++){
      Item item = inv.get(i);
      ans += item.getName();
      if(i != inv.size() - 1){
        ans += ", ";
      }
    }
    return ans;
  }
}