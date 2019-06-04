class Item {
  float price, xCor, yCor;
  String name;
  String type;
  boolean display; 
  Animation anim;
  int imageCount;
  int id;
  int valueUsed;

  Item(int idNum, float xCor, float yCor) {
    String[] itemList = loadStrings("itemlist.txt");
    String[] itemInfo = split(itemList[idNum + 1], ' ');
    name = itemInfo[1];
    price = Float.parseFloat(itemInfo[2]);
    type = itemInfo[3];
    imageCount = Integer.parseInt(itemInfo[4]);
    display = true;
    anim = new Animation(name + "/" + name, imageCount);
    this.xCor = xCor;
    this.yCor = yCor;
    id = idNum;
    if (type.equals("melee")) {
      valueUsed = Integer.parseInt(itemInfo[5]);
    }
  }

  int getVal() {
    return valueUsed;
  }

  void display() {
    if(display) anim.display(xCor-anim.getWidth()/2, yCor - anim.getHeight()/2);
  }


  boolean picked(Player person) {
    if (dist(xCor, yCor, person.getX(), person.getY()) < 0.5) {
      return true;
    }
    return false;
  }

  String getName() {
    return name;
  }

  float getPrice() {
    return price;
  }

  String getType() {
    return type;
  }

  void setX(float x) {
    xCor = x;
  }

  void setY(float y) {
    yCor = y;
  }

  float getX() {
    return xCor;
  }

  float getY() {
    return yCor;
  }

  void show(){
    display = !display;
  }

  String toString() {
    return name;
  }

  int getId() {
    return id;
  }
}
