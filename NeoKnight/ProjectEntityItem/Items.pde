class Item{
  float price, xCor, yCor;
  String name;
  String type;
  boolean pickedUp; 
  Animation anim;
  int imageCount;
  
  Item(int idNum, float xCor, float yCor){
    String[] itemList = loadStrings("itemlist.txt");
    String[] itemInfo = split(itemList[idNum], ' ');
    name = itemInfo[1];
    price = Float.parseFloat(itemInfo[2]);
    type = itemInfo[3];
    imageCount = Integer.parseInt(itemInfo[4]);
    pickedUp = false;
    anim = new Animation(name, imageCount);
    this.xCor = xCor;
    this.yCor = yCor;
  }
  
  void display(){
    anim.display(xCor-anim.getWidth()/2, yCor);
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
}