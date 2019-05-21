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
  PImage[] sprites;
  String type;
  float xCor, yCor;
  boolean pickedUp;  
  
  Item(int idNum){
    String[] itemList = loadStrings("itemlist.txt");
    String[] itemInfo = split(itemList[idNum], ' ');
    name = itemInfo[1];
    price = Float.parseFloat(itemInfo[2]);
    type = 
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
    for(int i = 0; i < 8; i++){
      sprites[i] = loadImage(name + i + ".png");
    }
  }
  
  void display(){
    for(int i = 0; i < sprites.length; i++){
      image(sprites[i], xCor, yCor);
    }
  }
  
  int getWidth() {
    return sprites[0].width;
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
Item item;
void setup(){
  size(64, 64);
  item = new Item (1, 32, 32, false);
}

void draw() {
  item.display();
}
