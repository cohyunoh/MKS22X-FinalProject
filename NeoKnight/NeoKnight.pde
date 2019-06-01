import java.util.*;
import java.io.*;

Player person;
ArrayList<Item> items;
ArrayList<Enemy> enemies;
Map map;
int currentRoomRow, currentRoomCol;
int currentState = 0;
Room[][] rooms;
Room current;
int roomnum = 0;
//String str;
Screen screen;

void setup() {
  size(2000, 1000);
  map = new Map(width, height, enemies, items);
  currentRoomRow = map.getStartRow();
  currentRoomCol = map.getStartCol();
  rooms = map.getMap();
  screen = new Screen();
  getRoom();
  smooth(3);
  frameRate(10);
  items = new ArrayList<Item>();
  enemies = new ArrayList<Enemy>();
  /*
  Item item =  new Item(1, 320, 180);
  items.add(item);
  */
  person = new Player("bob", "knight", 1000, 500);
  /*
  Gorlag enemy = new Gorlag(400, 200, (int)(Math.random() * 10));
  enemies.add(enemy);
  */
}


void draw() {
  background(0, 0, 255);
  if (currentState == 0) screen.startScreen();
  if (currentState == 1) screen.gameScreen(current, person);
  if (currentState == 2) screen.deathScreen();
  
}

void getRoom(){
  //str = rooms[currentRoomRow][currentRoomCol].toString();
  current = rooms[currentRoomRow][currentRoomCol];
}

void keyReleased(){
    current.setMove(keyCode, false); 
    person.setMove(keyCode, false); 
  }
  
void keyPressed(){
   current.setMove(keyCode, true); 
   person.setMove(keyCode, true); 
 }

void mousePressed() {
  if (currentState == 0) currentState = 1;
  if (currentState == 2) currentState = 0;
  person.attack(true, enemies);
}

void mouseReleased(){
   person.attack(false, enemies);
}

void createEnemies(){
  int numEnemies = 
}
