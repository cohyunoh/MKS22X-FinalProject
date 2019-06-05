class Player extends Entity{
  
//INSTANCE VARIABLES=========================================================================================
  boolean isLeft, isRight, isUp, isDown, wasLeft, wasRight, grab, next, prev, swit, attack, die, hurt, shoot, useKey, use, block, heal, useDoor, hasSword, hasBow, hasShield;
  int w,l,currentSlot, damage, useFrames, amountOfArrows;
  ArrayList<Item> inv;
  Animation useleft, useright;
  boolean canShoot = true;
  float canShootCounter, oldX, oldY,rotation;
  int numDoors = 0;
  int numEnemies = 0;
//===========================================================================================================  

//Constructors===============================================================================================
  Player(String startname, String type, float xCor, float yCor){
    super(startname, 200, 100, 1.00, type, xCor, yCor);
    w = animLeft.getWidth();
    l = animLeft.getHeight();
    inv = new ArrayList<Item>();
    Item hand = new Item(0, 46, height - 14);
    damage = hand.getDamage();
    inv.add(hand);
    inHand = inv.get(0);
    currentSlot = 0;
    swit = false;
    attack = false;
    useleft = new Animation("use" + "/" + inHand + "-left", 8);
    useright = new Animation("use" + "/" + inHand + "-right", 8);
    wasRight = true;
    oldX = mouseX;
    oldY = mouseY;
    rotation = atan2(oldY - this.yCor, oldX - this.xCor);
    amountOfArrows = 0;
  }
  //=============================================================================================================  

  int getDamage() {
    return damage;
  }



  boolean isHurt() {
    return hurt;
  }



  void notHurt() {
    hurt =  false;
  }

  void die() {
    if (hp <= 0) {
      die =  true;
    }
  }

  void removeArrows() {
    for (int i = 0; i < inv.size(); i++) {
    }
  }

  //ACTIONS (INPUT)==================================================================  

  void switchItem(float e) {
    if (inv.size()>1) {
      if (e < 0) {
        prev = true;
        next = false;
        swit = true;
      } else if (e > 0) {
        prev = false;
        next = true;
        swit = true;
      }
    }
  }



  void switchSlot() {
    inHand = inv.get(currentSlot);
    if (inHand.type.equals("melee") || inHand.type.equals("block")) {
      damage = inHand.getDamage();
    }
    animLeft = new Animation(type + "/" + inHand + "-left", 8);
    animRight = new Animation(type + "/" + inHand + "-right", 8);
    right = loadImage (type + "/" + inHand + "-right7.png");
    left = loadImage (type + "/" + inHand + "-left7.png");
    if (!(inHand.type.equals("projectile"))) {
      useleft = new Animation("use"+ "/" + inHand + "-left", 8);
      useright = new Animation("use" + "/" + inHand + "-right", 8);
    }
    if (inHand.type.equals("shooting")) {
      animlegL =  new Animation("legs/shootlegs-left", 8);
      animlegR =  new Animation("legs/shootlegs-right", 8);
      legR = loadImage ("legs/shootlegs-right7.png");
      legL = loadImage ("legs/shootlegs-left7.png");
    } else {
      animlegL =  new Animation("legs/left", 8);
      animlegR =  new Animation("legs/right", 8);
      legR = loadImage ("legs/right7.png");
      legL = loadImage ("legs/left7.png");
    }
    swit = false;
  }

  ArrayList<Item> grab(ArrayList<Item> items) {
    for (int i = 0; i < items.size(); i ++) {
      Item item = items.get(i);
      if (dist(item.getX(), item.getY(), xCor, yCor) <= 70) {
        if(item.name.equals("money")){
            money += item.money;
            item.display = false;
        }else{
          if(item.name.equals("sword")){
            hasSword = true;
          }
          if(item.name.equals("shield")){
            hasShield = true;
          }
          if(item.name.equals("bow")){
            hasBow = true;
          }
          item.setX(46);
          item.setY(height - 14);        
          inv.add(item);
          items.remove(i);
        }
      }
    }
    return items;
  }
  //set methods==========================================================================
  void setAttack() {
    attack = true;
    use = true;
  }

  void setShoot() {
    shoot = true;
    use = true;
  }

  void setHeal() {
    heal = true;
    use = true;
  }

  void setBlock() {
    block = true;
    use = true;
  }

  void setUseKey() {
    useKey = true;
    use = true;
  }
  //==========================================================================================
  void attack() {
    for (int i = 0; i < enemies.size(); i ++) {
      Enemy enemy = enemies.get(i);
      enemy.hurt(true);
    }
  }

  void hurt(Enemy enemy) {
    if (armor > 0) {
      if (inHand.type.equals("block")) {
        armor -= (int)(enemy.getDamage() * 0.25);
        hp -= (int)(enemy.getDamage() * 0.25);
      } else {
        armor -= (int)(enemy.getDamage() * 0.75);
        hp -= (int)(enemy.getDamage() * 0.25);
      }
    } else {
      hp -= enemy.getDamage();
    }
    hurt = true;
  }

  void heal() {
    if (inHand.name.equals("potionH")) {
      hp += inHand.getHeal();
    }
    if (inHand.name.equals("potionA")) {
      armor += inHand.getHeal();
    }
    inv.remove(inHand);
    currentSlot --;
    switchSlot();
  }

  void shoot() {
    Arrow arrow = new Arrow(xCor, yCor);
    arrow.addConstrainX(rooms[currentRoomRow][currentRoomCol].getX() + 32, rooms[currentRoomRow][currentRoomCol].getX() + current.getWidth() - 32);
    arrow.addConstrainY(rooms[currentRoomRow][currentRoomCol].getY() + 32, rooms[currentRoomRow][currentRoomCol].getY() + current.getLength() - 32);
    current.roomarrows.add(arrow);
    pushMatrix();
    translate(arrow.x, arrow.y);
    rotate(rotation);
    current.roomarrows.add(arrow);
    popMatrix();
    canShoot = false;
    canShootCounter = 0;
    shoot = false;
  }

  void useKey() {
    for (Door door : current.doors) {
      if (dist(xCor, yCor, door.x, door.y) < 60 && door.isLocked) {
        door.isLocked= false;
        inv.remove(inHand);
        currentSlot --;
        switchSlot();
      }
    }
  }

  void block() {
    for (int i = 0; i < enemies.size(); i ++) {
      Enemy enemy = enemies.get(i);
      enemy.hurt(enemy.hp - damage > 0);
    }
  }

  void followDisplay(Animation anim) {
    oldX = mouseX;
    oldY = mouseY;
    rotation = atan2(oldY - this.yCor, oldX - this.xCor);
    pushMatrix();
    translate(xCor, yCor);
    if (rotation < -(PI/2) || rotation >= (PI/2)) {
      rotate((rotation + PI) % (2 * PI));
    } else {
      rotate(rotation);
    }
    anim.display(0, -25);
    popMatrix();
  }

  void followDisplay(PImage anim) {
    oldX = mouseX;
    oldY = mouseY;
    rotation = atan2(oldY - this.yCor, oldX - this.xCor);
    pushMatrix();
    translate(xCor, yCor);
    if (rotation < -(PI/2) || rotation >= (PI/2)) {
      rotate((rotation + PI) % (2 * PI));
    } else {
      rotate(rotation);
    }
    imageMode(CENTER);
    image(anim, 0, -25);
    popMatrix();
  }

  //======================================================================================

  void display() {
    die();
    if (die) {
      fill(50);
      rect(xCor, yCor, 30, 30);
      attack = false;
      return ;
    }
    textAlign(LEFT);
    textSize(24);
    fill(225, 0, 0);
    text("HEALTH", 10, 24);
    fill(0, 0, 255);
    text("ARMOR", 10, 75);
    rectMode(CORNER);
    fill(225, 0, 0);
    rect(10, 24, hp * 2, 30);
    fill(0, 0, 255);
    if (armor > 0) {
      rect(10, 75, armor * 2, 30);
    } 
    fill(0,128,0);
    text("MONEY: " + money,10,130); 
    fill(50);
    rect(10, height - 50, 40, 40, 7);
    inHand.display();
    imageMode(CENTER);
    if (swit) {
      if (next) {
        currentSlot ++;
        currentSlot = currentSlot % inv.size();
      }
      if (prev) {
        currentSlot --;
        if (currentSlot < 0) {
          currentSlot = inv.size() - 1;
        }
      }
      switchSlot();
    }
    if (use) {
      if (inHand.type.equals("shooting")) {
        oldX = mouseX;
        oldY = mouseY;
        rotation = atan2(oldY - this.yCor, oldX - this.xCor);
        if (wasRight) {
          image(legR, xCor, yCor);
        }
        if (wasLeft) {
          image(legL, xCor, yCor);
        }
        if (rotation >= -(PI/2) && rotation < (PI/2)) {
          followDisplay(useright);
        } else if (rotation < -(PI/2) || rotation >= (PI/2)) {
          followDisplay(useleft);
        }
      } else {
        if (wasLeft) {
          useleft.display(xCor, yCor);
        }
        if (wasRight) {
          useright.display(xCor, yCor);
        }
      }
      if (attack) {
        attack();
      }
      if (heal) {
        heal();
      }
      if (block) {
        block();
      }
      if (shoot) {
        shoot();
      }
      useFrames += 1;
      if (useFrames >= 8) {
        useFrames = 0;
        if (useKey) {
          useKey();
        }
        use = false;
        attack = false;
        heal = false;
        block = false;
        useKey = false;
        shoot = false;
      }
    }else{
      if(grab){
        grab(current.roomitems);
      }
      if (isLeft) {
        animlegL.display(xCor, yCor);
        if (inHand.type.equals("shooting")) {
          oldX = mouseX;
          oldY = mouseY;
          rotation = atan2(oldY - this.yCor, oldX - this.xCor);
          if (rotation >= -(PI/2) && rotation < (PI/2)) {
            followDisplay(animRight);
          } else if (rotation < -(PI/2) || rotation >= (PI/2)) {
            followDisplay(animLeft);
          }
        } else {
          animLeft.display(xCor, yCor);
        }

        return ;
      }
      if (isRight) {
        animlegR.display(xCor, yCor);
        if (inHand.type.equals("shooting")) {
          oldX = mouseX;
          oldY = mouseY;
          rotation = atan2(oldY - this.yCor, oldX - this.xCor);
          if (rotation >= -(PI/2) && rotation < (PI/2)) {
            followDisplay(animRight);
          } else {
            followDisplay(animLeft);
          }
        } else {
          animRight.display(xCor, yCor);
        }
        return ;
      }
      if (isUp) {
        if (wasLeft) {
          animlegL.display(xCor, yCor);  
          if (inHand.type.equals("shooting")) {
            oldX = mouseX;
            oldY = mouseY;
            rotation = atan2(oldY - this.yCor, oldX - this.xCor);
            if (rotation >= -(PI/2) && rotation < (PI/2)) {
              followDisplay(animRight);
            } else if (rotation < -(PI/2) || rotation >= (PI/2)) {
              followDisplay(animLeft);
            }
          } else {
            animLeft.display(xCor, yCor);
          }
          return ;
        }
        if (wasRight) {
          animlegR.display(xCor, yCor);
          if (inHand.type.equals("shooting")) {
            oldX = mouseX;
            oldY = mouseY;
            rotation = atan2(oldY - this.yCor, oldX - this.xCor);
            if (rotation >= -(PI/2) && rotation < (PI/2)) {
              followDisplay(animRight);
            } else if (rotation < -(PI/2) || rotation >= (PI/2)) {
              followDisplay(animLeft);
            }
          } else {
            animRight.display(xCor, yCor);
          }
          return ;
        }
      }
      if (isDown) {
        if (wasLeft) {
          animlegL.display(xCor, yCor);
          if (inHand.type.equals("shooting")) {
            oldX = mouseX;
            oldY = mouseY;
            rotation = atan2(oldY - this.yCor, oldX - this.xCor);
            if (rotation >= -(PI/2) && rotation < (PI/2)) {
              followDisplay(animRight);
            } else if (rotation < -(PI/2) || rotation >= (PI/2)) {
              followDisplay(animLeft);
            }
          } else {
            animLeft.display(xCor, yCor);
          }
          return ;
        }
        if (wasRight) {
          animlegR.display(xCor, yCor);
          if (inHand.type.equals("shooting")) {
            oldX = mouseX;
            oldY = mouseY;
            rotation = atan2(oldY - this.yCor, oldX - this.xCor);
            if (rotation >= -(PI/2) && rotation < (PI/2)) {
              followDisplay(animRight);
            } else if (rotation < -(PI/2) || rotation >= (PI/2)) {
              followDisplay(animLeft);
            }
          } else {
            animRight.display(xCor, yCor);
          }
          return ;
        }
      }
      if (!isDown && !isUp && !isRight && !isLeft) {
        if (wasLeft) {
          image(legL, xCor, yCor);
          if (inHand.type.equals("shooting")) {
            oldX = mouseX;
            oldY = mouseY;
            rotation = atan2(oldY - this.yCor, oldX - this.xCor);
            if (rotation >= -(PI/2) && rotation < (PI/2)) {
              followDisplay(right);
            } else if (rotation < -(PI/2) || rotation >= (PI/2)) {
              followDisplay(left);
            }
          } else {
            image(left, xCor, yCor);
          }

          return ;
        }
        if (wasRight) {
          image(legR, xCor, yCor);
          if (inHand.type.equals("shooting")) {
            oldX = mouseX;
            oldY = mouseY;
            rotation = atan2(oldY - this.yCor, oldX - this.xCor);
            if (rotation >= -(PI/2) && rotation < (PI/2)) {
              followDisplay(right);
            } else if (rotation < -(PI/2) || rotation >= (PI/2)) {
              followDisplay(left);
            }
          } else {
            image(right, xCor, yCor);
          }

          return ;
        }
      }
      image(legR, xCor, yCor);
      image(right, xCor, yCor);
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




  String stringInv() {
    String ans = "";
    for (int i = 0; i < inv.size(); i++) {
      Item item = inv.get(i);
      ans += item.getName();
      if (i != inv.size() - 1) {
        ans += ", ";
      }
    }
    return ans;
  }
}
