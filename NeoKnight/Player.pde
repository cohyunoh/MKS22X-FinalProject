class Player extends Entity{
  
//INSTANCE VARIABLES=========================================================================================
  boolean isLeft, isRight, isUp, isDown, wasLeft, wasRight, grab, next, prev, swit, attack, die, hurt, shoot, useKey, use, block, heal, useDoor;
  int w,l,currentSlot, damage, useFrames;
  ArrayList<Item> inv;
  Animation useleft, useright;
  boolean canShoot = true;
  float canShootCounter;
//===========================================================================================================  

//Constructors===============================================================================================
  Player(String startname, String type, float xCor, float yCor){
    super(startname, 100, 100, 1.00, type, xCor, yCor);
    w = animLeft.getWidth();
    l = animLeft.getHeight();
    inv = new ArrayList<Item>();
    Item hand = new Item(0, 29, height - 30);
    damage = hand.getDamage();
    inv.add(hand);
    inHand = inv.get(0);
    currentSlot = 0;
    swit = false;
    attack = false;
    useleft = new Animation("use" + "/" + inHand + "-left",8);
    useright = new Animation("use" + "/" + inHand + "-right",8);
    wasRight = true;
  }
//=============================================================================================================  
  
  int getDamage(){
   return damage;
  }
  
  
  
  boolean isHurt(){
    return hurt;
  }
  
  
  
  void notHurt(){
    hurt =  false;
  }
  
  void die(){
    if(hp <= 0){
      die =  true;
    }
  }
  
//ACTIONS (INPUT)==================================================================  
  
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
    if(inHand.type.equals("melee") || inHand.type.equals("block")) {
      damage = inHand.getDamage();
    }
    animLeft = new Animation(type + "/" + inHand + "-left", 8);
    animRight = new Animation(type + "/" + inHand + "-right", 8);
    right = loadImage (type + "/" + inHand + "-right7.png");
    left = loadImage (type + "/" + inHand + "-left7.png");
    useleft = new Animation("use"+ "/" + inHand + "-left",8);
    useright = new Animation("use" + "/" + inHand + "-right",8);
    swit = false;
  }
  
  ArrayList<Item> grab(ArrayList<Item> items){
    for(int i = 0; i < items.size(); i ++){
      Item item = items.get(i);
      if(dist(item.getX(),item.getY(),xCor,yCor) <= 50){
        item.setX(24);
        item.setY(height - 30);        
        inv.add(item);
        items.remove(i);
      }
    }
    return items;
  }
  //set methods==========================================================================
  void setAttack(){
    attack = true;
    use = true;
  }
  
  void setShoot(){
    shoot = true;
    use = true;
  }
  
  void setHeal(){
    heal = true;
    use = true;
  }
  
  void setBlock(){
    block = true;
    use = true;
  }
  
  void setUseKey(){
    useKey = true;
    use = true;
  }
  //==========================================================================================
  void attack(){
     for(int i = 0; i < enemies.size(); i ++){
       Enemy enemy = enemies.get(i);
       enemy.hurt(true);
     }
  }
  
  void hurt(Enemy enemy){
    if(armor > 0){
      armor -= (int)(enemy.getDamage() * 0.75);
      hp -= (int)(enemy.getDamage() * 0.25);
    }else{
      hp -= enemy.getDamage();
    }
    hurt = true;
  }
  
  void heal(){
    if(inHand.name.equals("potionH")){
      hp += inHand.getHeal();
    }
    if(inHand.name.equals("potionA")){
      armor += inHand.getHeal();
    }
    
  }
  
  void shoot(){
    Arrow arrow = new Arrow(xCor, yCor);
    arrow.addConstrainX(rooms[currentRoomRow][currentRoomCol].getX() + 32, rooms[currentRoomRow][currentRoomCol].getX() + current.getWidth() - 32);
    arrow.addConstrainY(rooms[currentRoomRow][currentRoomCol].getY() + 32, rooms[currentRoomRow][currentRoomCol].getY() + current.getLength() - 32);
    arrows.add(arrow);
    canShoot = false;
    canShootCounter = 0;
    shoot = false;
  }
  
  void useKey(){
    for(Door door:current.doors){
      if(dist(xCor,yCor,door.x,door.y) < 60 && door.isLocked){
        door.isLocked= false;
        inv.remove(inHand);
      }
    }
  }
  
  void block(){
    for(int i = 0; i < enemies.size(); i ++){
       Enemy enemy = enemies.get(i);
       enemy.hurt(enemy.hp - damage > 0);
     }
  }
//======================================================================================
  
  void display(){
    die();
    if(die){
      fill(50);
      rect(xCor, yCor, 30,30);
      attack = false;
      return ;
    }
    textAlign(LEFT);
    textSize(24);
    fill(225,0,0);
    text("HEALTH", 10, 24);
    fill(0,0,255);
    text("ARMOR",10,75);
    rectMode(CORNER);
    fill(225,0,0);
    rect(10,24,hp * 2,30);
    fill(0,0,255);
    if(armor > 0){
      rect(10,75,armor * 2,30);
    } 
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
    if(use){
      if(wasLeft){
        useleft.display(xCor - animLeft.getWidth()/2, yCor - animLeft.getHeight()/2);
      }
      if(wasRight) {
        useright.display(xCor - animLeft.getWidth()/2, yCor - animLeft.getHeight()/2);
      }
      if(attack){
        attack();
      }
      if(heal){
        heal();
      }
      if(useKey){
        useKey();
      }
      if(block){
        block();
      }
      
      useFrames += 1;
      if(useFrames >= 8){
        useFrames = 0;
        use = false;
        attack = false;
        heal = false;
        block = false;
        useKey = false;
      }
    }else{
      
      if (shoot && canShoot) {
        
      }
      if(canShoot == false){
        canShootCounter ++;
        //if the right amount of time has passed. make canShoot true
        if (canShootCounter == 5)/*change this number to change the duration*/{
          canShoot = true;
        }
      }
      if(grab){
        grab(items);
      }
      if(isLeft){
        animLeft.display(xCor - animLeft.getWidth()/2, yCor - animLeft.getHeight()/2);
        animlegL.display(xCor - animLeft.getWidth()/2, yCor - animLeft.getHeight()/2);
        return ;
      }
      if(isRight){
        animRight.display(xCor - animLeft.getWidth()/2, yCor - animLeft.getHeight()/2);
        animlegR.display(xCor - animLeft.getWidth()/2, yCor - animLeft.getHeight()/2);
        return ;
      }
      if(isUp) {
        if(wasLeft){
          animLeft.display(xCor - animLeft.getWidth()/2, yCor - animLeft.getHeight()/2);
          animlegL.display(xCor - animLeft.getWidth()/2, yCor - animLeft.getHeight()/2);  
          return ;
        }
        if (wasRight){
          animRight.display(xCor - animLeft.getWidth()/2, yCor - animLeft.getHeight()/2);
          animlegR.display(xCor - animLeft.getWidth()/2, yCor - animLeft.getHeight()/2);
          return ;
        }
      }
      if(isDown) {
        if(wasLeft){
          animLeft.display(xCor - animLeft.getWidth()/2, yCor - animLeft.getHeight()/2);
          animlegL.display(xCor - animLeft.getWidth()/2, yCor - animLeft.getHeight()/2);
          return ;
        }
        if (wasRight){
          animRight.display(xCor - animLeft.getWidth()/2, yCor - animLeft.getHeight()/2);
          animlegR.display(xCor - animLeft.getWidth()/2, yCor - animLeft.getHeight()/2);
          return ;
        }
      }
      if(!isDown && !isUp && !isRight && !isLeft){
        if(wasLeft){
          image(left, xCor, yCor);
          image(legL, xCor, yCor);
          return ;
        }
        if (wasRight){
          image(right, xCor, yCor);
          image(legR, xCor, yCor);
          return ;
        }
      }
      image(right, xCor, yCor);
      image(legR, xCor, yCor);
    }
  }
  
  
  boolean setMove(int k, boolean b) {
    switch (k) {
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
        useDoor = b;
        return grab = b;
      default:
        return b;
      }
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
