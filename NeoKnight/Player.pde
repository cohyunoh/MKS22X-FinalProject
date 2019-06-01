class Player extends Entity{
  boolean isLeft, isRight, isUp, isDown, wasLeft, wasRight, run, grab, next, prev, swit, attack, die;
  int w,l,currentSlot, damage;
  ArrayList<Item> inv;
  Animation attackleft, attackright;
  Player(String startname, String type, float xCor, float yCor){
    super(startname, 100, 100, 1.00, type, xCor, yCor);
    w = animLeft.getWidth();
    l = animLeft.getHeight();
    inv = new ArrayList<Item>();
    Item hand = new Item(0, 29, height - 30);
    damage = hand.getVal();
    inv.add(hand);
    inHand = inv.get(0);
    currentSlot = 0;
    swit = false;
    attack = false;
    attackleft = new Animation(type + "-" + "attack" + "/" + inHand + "-left",8);
    attackright = new Animation(type + "-" + "attack" + "/" + inHand + "-right",8);
  }
  Player(String startname, String type, float xCor, float yCor, ArrayList<Item> inv, int slot){
    super(startname, 100, 100, 1.00, type, xCor, yCor);
    w = animLeft.getWidth();
    l = animLeft.getHeight();
    this.inv = inv;
    currentSlot = slot;
    inHand = inv.get(currentSlot);
    damage = inHand.getVal();
    swit = false;
    attack = false;
    attackleft = new Animation(type + "-" + "attack" + "/" + inHand + "-left",8);
    attackright = new Animation(type + "-" + "attack" + "/" + inHand + "-right",8);
  }
  
  void attack(boolean e, ArrayList<Gorlag> enemies){
     attack = e;
     for(int i = 0; i < enemies.size(); i ++){
       Gorlag enemy = enemies.get(i);
       if(dist(enemy.getX(), enemy.getY(),xCor, yCor) < 100){
          enemy.hurt(this);
        }
     }
  }
  
  int getDamage(){
   return damage;
  }
  
  void hurt(Gorlag enemy){
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
  
  void display(ArrayList<Item> items){
    die();
    if(die){
      fill(50);
      rect(xCor, yCor, 30,30);
      attack = false;
      return ;
    }
    text("HEALTH", 10, 10);
    text("ARMOR",10,35);
    rectMode(CORNER);
    fill(225,0,0);
    rect(10,10,hp,10);
    fill(0,0,255);
    rect(10,35,armor,10);
    fill(50);
    rect(10, height - 50, 40, 40, 7);
    inHand.display();
    
    if(swit){
       if(next){
         currentSlot ++;
         currentSlot = currentSlot % inv.size();
        }
        if(prev){
          currentSlot --;
          if(currentSlot < 0){
            currentSlot = inv.size() - 1;
           }
        }
        switchSlot();
    }
    
    if(attack){
      if(wasLeft){
        attackleft.display(xCor - animLeft.getWidth()/2, yCor - animLeft.getHeight()/2);
      }
      if(wasRight) {
        attackright.display(xCor - animLeft.getWidth()/2, yCor - animLeft.getHeight()/2);
      }
    }else{
    
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
  
   void die(){
    if(hp <= 0){
      die =  true;
    }
  }
  
  void switchItem(float e){
    if(inv.size()>1){
      if(e < 0){
        prev = true;
        next = false;
        swit = true;
      }else if(e > 0){
        prev = false;
        next = true;
        swit = true;
      }
    }
    
  }
  
  void switchSlot(){
    inHand = inv.get(currentSlot);
    animLeft = new Animation(type + "-" + inHand + "/" + type + "-walk-left", 8);
    animRight = new Animation(type + "-" + inHand + "/" + type + "-walk-right", 8);
    right = loadImage (type + "-" + inHand + "/" + type + "-walk-right7.png");
    left = loadImage (type + "-" + inHand + "/" + type + "-walk-left7.png");
    attackleft = new Animation(type + "-" + "attack" + "/" + inHand + "-left",8);
    attackright = new Animation(type + "-" + "attack" + "/" + inHand + "-right",8);
    swit = false;
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
  
  boolean isAttacking(){
    return attack;
  }
}
