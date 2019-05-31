class Item{
  float price;
  String name;
  String type;
  boolean pickedUp; 
  Animation anim;
  int imageCount;
  float xCor, yCor;
  
  Item(int idNum){
    String[] itemList = loadStrings("itemlist.txt");
    String[] itemInfo = split(itemList[idNum], ' ');
    name = itemInfo[1];
    price = Float.parseFloat(itemInfo[2]);
    type = itemInfo[3];
    imageCount = Integer.parseInt(itemInfo[4]);
    pickedUp = false;
    anim = new Animation(name, imageCount);
  }
  
  void display(float xCor, float yCor){
    anim.display(xCor-anim.getWidth()/2, yCor);
    this.xCor = xCor;
    this.yCor = yCor;
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
}