import java.util.*;
import java.io.*;

Player person;
ArrayList<Enemy> enemies;
ArrayList<Arrow> arrows;
ArrayList<Item> items;
Map map;
int currentRoomRow, currentRoomCol;
int currentState = 0;
Room[][] rooms;
Room current; //<>//
int roomNum = 1; //<>//
//String str;
Screen screen;



void setup() {
  size(1500, 1000);
  createEnemies();
  arrows = new ArrayList<Arrow>();
  items = new ArrayList<Item>();
 if(roomNum == 1){
    person = new Player("bob", "knight", 750, 500);
    map = new Map(15, 15);
    currentRoomRow = map.getStartRow();
    currentRoomCol = map.getStartCol();
    current = rooms[currentRoomRow][currentRoomCol];
    screen = new Screen();
  }
  smooth(3);
  frameRate(10);
  current.addEnemies();
  current.addKeys();
}


void draw() {
  background(0);
  if (currentState == 0) screen.startScreen();
  if (currentState == 1){
    
    screen.gameScreen(current, person);
  }
  if (currentState == 2) screen.deathScreen();
  if (person.isDead()) {
    currentState = 2;
  }
  
}






void keyReleased() {
  current.setMove(keyCode, false); 
  person.setMove(keyCode, false);
}

void keyPressed() {
  current.setMove(keyCode, true); 
  person.setMove(keyCode, true);
}

void mousePressed() {
  if (currentState == 0) currentState = 1;
  if (currentState == 2) {
    currentState = 0;
    roomNum = 1;
    setup();
  }
  if(person.inHand.getType().equals("melee")){
    person.setAttack();
  }
  if(person.inHand.getType().equals("shooting")){
    person.setShoot();
  }
  if(person.inHand.getType().equals("heal")){
    person.setHeal();
  }
  if(person.inHand.getType().equals("block")){
    person.setBlock();
  }
  if(person.inHand.getType().equals("key")){
    person.setUseKey();
  }
}


void update(){
  items = current.getItems();
  enemies = current.getEnemies();
}


void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  person.switchItem(e);
}

void createEnemies() {
  enemies = new ArrayList<Enemy>();
  int numEnemies = (int)(Math.random() * (5 + roomNum)) + 5;
  for (int i = 0; i < numEnemies; i++) {
    Enemy gorlag = new Enemy(0, 0, (int)(Math.random() * 15) + 5);
    gorlag.num = roomNum;
    enemies.add(gorlag);
  }
}
