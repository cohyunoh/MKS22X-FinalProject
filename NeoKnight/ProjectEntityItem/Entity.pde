class Entity{
  int hp, armor;
  float xCor, yCor,money;
  Item inHand;
  String name;
  String type;
  Animation animLeft;
  Animation animRight;
  Animation current;
  PImage right, left;
  Entity(String startname, int health, int armor, float money, String type, float xCor, float yCor){
    this.xCor = xCor;
    this.yCor = yCor;
    name = startname;
    hp = health;
    this.armor = armor;
    this.money = money;
    this.type = type;
    inHand = new Item(0);
    animLeft = new Animation(type + "/" + type + "-walk-left", 8);
    animRight = new Animation(type + "/" + type + "-walk-right", 8);
    current = animRight;
    right = loadImage (type + "/" + type + "-walk-right7.png");
    left = loadImage (type + "/" + type + "-walk-left7.png");
  }
  void display(String direction){
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
  
  void setX(float x){
    xCor = x;
  }
  
  void setY(float y){
    yCor = y;
  }
  
  float getX(){
    return xCor;
  }
  
  float getY(){
    return yCor;
  }
  
  int getHealth(){
    return hp;
  }
  
  void setHealth(int newHP){
    hp = newHP;
  }
  
  int getArmor(){
    return armor;
  }
  
  void setArmor(int newArmor){
    armor = newArmor;
  }
  
  float getMoney(){
    return money;
  }
  
  void setMoney(float newBalance){
    money = newBalance;
  }
}