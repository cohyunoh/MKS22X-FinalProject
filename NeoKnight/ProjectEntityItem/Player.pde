class Player extends Entity implements Moveable {
  int vel = 5;
  boolean isLeft, isRight, isUp, isDown, wasLeft, wasRight, run, grab;
  int w,l,currentSlot;
  ArrayList<Item> inv;
  Player(String startname, String type, float xCor, float yCor){
    super(startname, 100, 100, 1.00, type, xCor, yCor);
    w = animLeft.getWidth();
    l = animLeft.getHeight();
    inv = new ArrayList<Item>();
    Item hand = new Item(0, 24, height - 30);
    inv.add(hand);
    inHand = inv.get(0);
    currentSlot = 0;
  }
  
  void display(ArrayList<Item> items){
    text("HEALTH", 10, 10);
    text("ARMOR",10,35);
    rectMode(CORNER);
    fill(225,0,0);
    rect(10,10,hp,10);
    fill(0,0,255);
    rect(10,35,armor,10);
    fill(50);
    square(10,height - 50, 30);
    inHand.display();
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
  
  ArrayList<Item> grab(ArrayList<Item> items){
    for(int i = 0; i < items.size(); i ++){
      Item item = items.get(i);
      if(dist(item.getX(),item.getY(),xCor,yCor) <= 20){
        item.setX(24);
        item.setY(height - 30);        
        inv.add(item);
        items.remove(i);
      }
    }
    return items;
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
  
  void switchItem(float e){
    currentSlot += (int)e;
    if(currentSlot < 0){
      currentSlot = inv.size() - 1;
    }else{
      currentSlot = currentSlot % inv.size();
    }
    inHand = inv.get(currentSlot);
    animLeft = new Animation(type + "-" + inHand + "/" + type + "-walk-left", 8);
    animRight = new Animation(type + "-" + inHand + "/" + type + "-walk-right", 8);
    right = loadImage (type + "-" + inHand + "/" + type + "-walk-right7.png");
    left = loadImage (type + "-" + inHand + "/" + type + "-walk-left7.png");
  }
  
  String stringInv(){
    String ans = "";
    for (int i = 0; i < inv.size(); i++){
      Item item = inv.get(i);
      ans += item.getName();
      if(i != inv.size() - 1){
        ans += ", ";
      }
    }
    return ans;
  }
}
