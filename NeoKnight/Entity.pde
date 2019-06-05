class Entity {
  int hp, armor;
  float xCor, yCor, money;
  Item inHand;
  String name;
  String type;
  Animation animLeft, animlegL;
  Animation animRight, animlegR;
  PImage right, left, legL, legR;

  Entity(String startname, int health, int armor, float money, String type, float xCor, float yCor) {
    this.xCor = xCor;
    this.yCor = yCor;
    name = startname;
    hp = health;
    this.armor = armor;
    this.money = money;
    this.type = type;
    inHand = new Item(0, 0, 0);
    animLeft = new Animation(type + "/" + inHand + "-left", 8);
    animRight = new Animation(type + "/" + inHand + "-right", 8);
    animlegR = new Animation("legs/right", 8);
    animlegL = new Animation("legs/left", 8);
    right = loadImage (type + "/" + inHand + "-right7.png");
    left = loadImage (type + "/" + inHand + "-left7.png");
    legR = loadImage ("legs/right7.png");
    legL = loadImage ("legs/left7.png");
  }

  void display(String direction) {
    if (direction.equals("left")) {
      animLeft.display(xCor, yCor);
      animlegL.display(xCor, yCor);
    } else if (direction.equals("right")) {
      animRight.display(xCor, yCor);
      animlegR.display(xCor, yCor);
    } else if (direction.equals("idleRight")) {
      image(right, xCor, yCor);
      image(legR, xCor, yCor);
    } else if (direction.equals("idleLeft")) {
      image(left, xCor, yCor);
      image(legL, xCor, yCor);
    }
  }

  void setX(float x) {
    xCor += x;
  }

  void setY(float y) {
    yCor += y;
  }

  float getX() {
    return xCor;
  }

  float getY() {
    return yCor;
  }


  int getHealth() {
    return hp;
  }

  void setHealth(int newHP) {
    hp = newHP;
  }

  int getArmor() {
    return armor;
  }

  void setArmor(int newArmor) {
    armor = newArmor;
  }

  float getMoney() {
    return money;
  }

  void setMoney(float newBalance) {
    money = newBalance;
  }

  Item getItem() {
    return inHand;
  }

  void setItem(Item newItem) {
    inHand = newItem;
  }

  boolean isDead() {
    return hp <= 0;
  }

  float getWidth() {
    return animLeft.getWidth();
  }

  float getHeight() {
    return animLeft.getHeight();
  }
}
