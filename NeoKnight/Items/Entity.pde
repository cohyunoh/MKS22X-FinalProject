class Entity{
  int hp, armor;
  float money;
  Item inHand;
  String name;
  String type;
  Animation animLeft;
  Animation animRight;
  Animation current;
  PImage right, left;
  Entity(String startname, int health, int armor, float money, String type){
    name = startname;
    hp = health;
    this.armor = armor;
    this.money = money;
    this.type = type;
    animLeft = new Animation(type + "/" + type + "-walk-left", 8);
    animRight = new Animation(type + "/" + type + "-walk-right", 8);
    current = animRight;
    right = loadImage (type + "/" + type + "-walk-right7.png");
    left = loadImage (type + "/" + type + "-walk-left7.png");
  }
  void display(float xCor, float yCor, String direction){
    if(direction.equals("left")){
      animLeft.display(xCor, yCor);
    }else if(direction.equals("right")){
      animRight.display(xCor, yCor);
    }else if(direction.equals("idleRight")){
     image(right, xCor, yCor);
    }else if(direction.equals("idleLeft")){
     image(left, xCor, yCor);
    }
  }
}
