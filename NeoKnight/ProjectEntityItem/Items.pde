class Item{
  float price, xCor, yCor;
  String name;
  String type;
  boolean pickedUp; 
  Animation anim;
  int imageCount;
  int id;
  
  Item(int idNum, float xCor, float yCor){
    String[] itemList = loadStrings("itemlist.txt");
    String[] itemInfo = split(itemList[idNum + 1], ' ');
    name = itemInfo[1];
    price = Float.parseFloat(itemInfo[2]);
    type = itemInfo[3];
    imageCount = Integer.parseInt(itemInfo[4]);
    pickedUp = false;
    anim = new Animation(name + "/" + name, imageCount);
    this.xCor = xCor;
    this.yCor = yCor;
    id = idNum;
  }
  
  Item(int idNum){
    String[] itemList = loadStrings("itemlist.txt");
    String[] itemInfo = split(itemList[idNum + 1], ' ');
    name = itemInfo[1];
    price = Float.parseFloat(itemInfo[2]);
    type = itemInfo[3];
  }
  
  void display(){
    anim.display(xCor-anim.getWidth()/2, yCor - anim.getHeight()/2);
  }
  
  boolean picked(Player person){
    if (dist(xCor,yCor,person.getX(),person.getY()) < 0.5){
      return true;
    }
    return false;
  }
  
  String getName(){
    return name;
  }
  
  float getPrice(){
    return price;
  }
  
  String getType(){
     return type;
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
  
  void setPicked(boolean newP){
    pickedUp = newP;
  }
  
  String toString(){
    return name;
  }
  
  int getId(){
    return id;
  }
}
