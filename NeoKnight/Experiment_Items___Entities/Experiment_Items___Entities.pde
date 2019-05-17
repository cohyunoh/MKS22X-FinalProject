import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.io.IOException;
import java.io.FileWriter;
class Entity{
  int hp, armor, money;
  float xCor, yCor;
  Item inHand;
  Player(float startX, float startY, String startname, int health
  void display(){
    
  }
}

class Item{
  float price;
  String name;
  PImage[] sprite;
  String type;
  File file = new File("itemlist.txt");
  Scanner itemList = new Scanner(file);
  float xCor, yCor;
  boolean pickedUp;  
  
  Item(int idNum){
    boolean notfound = true;
    while(itemList.hasNextInt() && notfound){
      if(itemList.nextInt() == idNum){
        name = itemList.next();
        price = Float.parseFloat(itemList.next());
        type = itemList.next();
        notfound = false;
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
    boolean notDone = true;
    for (int i = 0; notDone; i++){
      PImage frame = loadImage(name + i);
  }
  
  void display(){
    boolean notDone = true;
    for (int i = 0; notDone; i++){
      PImage frame = loadImage(name + i);
      image(frame, xCor, yCor);
    }
  }
  
  int getWidth() {
    return sprite.width;
  }
}