import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.io.IOException;
import java.io.FileWriter;

class Entity{
  int hp, armor;
  float xCor, yCor, money;
  Item inHand;
  String name;
  String type;
  Animation animLeft;
  Animation animRight;
  Entity(float startX, float startY, String startname, int health, int armor, float money, String type){
    xCor = startX;
    yCor = startY;
    name = startname;
    hp = health;
    this.armor = armor;
    this.money = money;
    this.type = type;
    animLeft = new Animation("knight-walk-left", 8);
    animLeft = new Animation("knight-walk-right", 8);
  }
  void display(){
    
  }
  
}

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
Item item;
float xpos;
float ypos;
float drag = 30.0;

void setup() {
  size(640, 360);
  background(255, 204, 0);
  frameRate(10);
  item =  new Item(0);
}

void draw() {
  item.display(320, 180);
}

class Animation {
  PImage[] frames;
  int totalFrames;
  int frame;
  
  Animation(String name, int count) {
    totalFrames = count;
    frames = new PImage[totalFrames];

    for (int i = 0; i < totalFrames; i++) {
      String filename = name + i + ".png";
      frames[i] = loadImage(filename);
    }
  }

  void display(float xpos, float ypos) {
    frame = (frame+1) % totalFrames;
    background(255, 204, 0);
    image(frames[frame], xpos, ypos);
   }
  
  int getWidth() {
    return frames[0].width;
  }
}