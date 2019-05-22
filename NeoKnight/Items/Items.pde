import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.io.IOException;
import java.io.FileWriter;

class Entity{
  int hp, armor;
  float money;
  Item inHand;
  String name;
  String type;
  Animation animLeft;
  Animation animRight;
  Animation current;
  Entity(String startname, int health, int armor, float money, String type){
    name = startname;
    hp = health;
    this.armor = armor;
    this.money = money;
    this.type = type;
    animLeft = new Animation("knight/knight-walk-left", 8);
    animRight = new Animation("knight/knight-walk-right", 8);
    current = animRight;
  }
  void display(float xCor, float yCor, String direction){
    if(direction.equals("left")){
      animLeft.display(xCor, yCor);
    }else if(direction.equals("right")){
      animRight.display(xCor, yCor);
    }
    
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

Entity person;
Item item;
float xpos;
float ypos;
float drag = 30.0;
float x = 0;
float speed = 10.0;
float left = 0;
float right = 0;
String direction;

void setup() {
  size(640, 360);
  background(255, 204, 0);
  frameRate(10);
  item =  new Item(0);
  person = new Entity("bob", 100, 100, 0.0, "knight");
  direction = "left";
}

void draw() {
  x += (right - left) * speed;
  item.display(320, 180);
  person.display(x, 180, direction);
}

void keyReleased(){
    if (key == CODED){
      if (keyCode == LEFT){
        left = 0;
        direction = "left";
      }
      if (keyCode == RIGHT){
        right = 0;
        direction = "right";;
      }
    }
  }

  void keyPressed(){
    if (key == CODED){
      if (keyCode == LEFT){
        left = 1;
        direction = "left";
      }
      if (keyCode == RIGHT){
        right = 1;
        direction = "right";
      }
    }
  }
