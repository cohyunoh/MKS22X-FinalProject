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
  String type;
  PImage[] images;
  int imageCount;
  int frame;
  boolean pickedUp; 
  
  Item(int idNum){
    String[] itemList = loadStrings("itemlist.txt");
    String[] itemInfo = split(itemList[idNum], ' ');
    name = itemInfo[1];
    price = Float.parseFloat(itemInfo[2]);
    type = itemInfo[3];
    imageCount = Integer.parseInt(itemInfo[4]);
    render();
    pickedUp = false;
    frame = 0;
  }
  
  
  
  void render(){
    images = new PImage[imageCount];
    for (int i = 0; i < imageCount; i++) {
      String filename = name + i + ".png";
      images[i] = loadImage(filename);
    }
  }
  
  void display(float xpos, float ypos) {
    frame = (frame+1) % imageCount;
    image(images[frame], xpos, ypos);
    frame = (frame+1) % imageCount;
  }
  
  int getWidth() {
    return images[0].width;
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
float xpos;
float ypos;
float drag = 30.0;

void setup() {
  size(640, 360);
  background(255, 204, 0);
  frameRate(10);
  item =  new Item(0);
  ypos = height * 0.25;
}

void draw() { 
  float dx = mouseX - xpos;
  xpos = xpos + dx/drag;
  item.display(xpos, ypos);
}
