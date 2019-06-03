import java.util.*;
import java.io.*;

Player person;
ArrayList<Item> items;
ArrayList<Enemy> enemies;
ArrayList<Door> doors;
Map map;
int currentRoomRow, currentRoomCol;
int currentState = 0;
Room[][] rooms;
Room current;
int roomNum = 1;
//String str;
Screen screen;

void setup() {
  size(1500, 1000);
  items = new ArrayList<Item>();
  doors = new ArrayList<Door>();
  createEnemies();
  map = new Map(5, 5);
  currentRoomRow = map.getStartRow();
  currentRoomCol = map.getStartCol();
  rooms = map.getMap();
  screen = new Screen();
  getRoom();
  smooth(3);
  frameRate(10);
  current.addEnemies(enemies);

  /*
  Item item =  new Item(1, 320, 180);
   items.add(item);
   */
  person = new Player("bob", "knight", 750, 500);
  current.addPlayer(person);
  person.addEnemies(enemies);
  /*
  Gorlag enemy = new Gorlag(400, 200, (int)(Math.random() * 10));
   enemies.add(enemy);
   */
}


void newSetup(){
  items = new ArrayList<Item>();
  enemies = new ArrayList<Enemy>();
  doors = new ArrayList<Door>();
  createEnemies();
  getRoom();
  smooth(3);
  frameRate(10);
  current.addEnemies(enemies);
  current.addPlayer(person);
  person.addEnemies(enemies);
}

void draw() {
  background(0, 0, 255);
  if (currentState == 0) screen.startScreen();
  if (currentState == 1){
    screen.gameScreen(current, person);
    nextRoom();
    getRoom();
  }
  if (currentState == 2) screen.deathScreen();
  if (person.isDead()) {
    currentState = 2;
  }
  
}

void getRoom() {
  current = rooms[currentRoomRow][currentRoomCol];  
  doors = current.getDoors();
  
}

void createNextRoom(Door door){
  int rows = (int)(abs((float)(Math.random() * 20))) + 30;
  int cols = (int)(abs((float)(Math.random() * 20))) + 30;
  rooms[currentRoomRow][currentRoomCol] = new Room(rows, cols, door, 0,0); 
  rooms[currentRoomRow][currentRoomCol].addPlayer(person);
  createEnemies();
  rooms[currentRoomRow][currentRoomCol].addEnemies(enemies);
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
    setup();
  }
  person.setAttack(true);
}

void mouseReleased() {
  person.setAttack(false);
}

void nextRoom(){
  for (Door door : doors){
    if (dist(door.x,door.y,person.xCor,person.yCor) < 25){
      if (door.up){
        currentRoomCol++;
        createNextRoom(door);
        return ;
      }else if (door.down){
        currentRoomCol--;
        createNextRoom(door);
        return ;
      }else if (door.left){
        currentRoomRow--;
        createNextRoom(door);
        return ;
      }else if (door.right){
        currentRoomRow++;
        createNextRoom(door);
        return ;
      }
      roomNum ++;
    }
  }
}


void createEnemies() {
  enemies = new ArrayList<Enemy>();
  int numEnemies = (int)(Math.random() * (5 + roomNum)) + 5;
  for (int i = 0; i < numEnemies; i++) {
    Enemy gorlag = new Enemy(0, 0, (int)(Math.random() * 15) + 5);
    enemies.add(gorlag);
  }
}
