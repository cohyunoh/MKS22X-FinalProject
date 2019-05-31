import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.io.IOException;
import java.io.FileWriter;
/*
class Entity{
  int hp, armor, money;
  float xCor, yCor;
  Item inHand;
  Player(float startX, float startY, String startname, int health
  void display(){
    
  }
}
*/
class Item{
  float price;
  String name;
  PImage sprite;
  String type;
  float xCor, yCor;
  boolean pickedUp;  
  Scanner itemList;
  
  Item(int idNum){
    try{
      File file = new File("itemlist.txt");
      itemList = new Scanner(file);
    }catch(FileNotFoundException e){
      e.printStackTrace();
    }
    boolean notfound = true;
    while(itemList.hasNextInt() && notfound){
      if(itemList.nextInt() == idNum){
        name = itemList.next();
        price = Float.parseFloat(itemList.next());
        type = itemList.next();
        notfound = false;
        render();
      }
    }
  }
  
  Item(int idNum, float xCor, float yCor, boolean picked){
    this(idNum);
    this.xCor = xCor;
    this.yCor = yCor;
    pickedUp = picked;
  }
  
  void use(){
    
  }
  
  void render(){
    sprite = loadImage(name + ".gif");
  }
  
  void display(){
    image(sprite, xCor, yCor);
  }
  /*
  int getWidth() {
    return sprites[0].width;
  }
  */
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
Item item;
void setup(){
  size(64, 64);
  item = new Item (1, 32, 32, false);
}

void draw() {
  item.display();
}