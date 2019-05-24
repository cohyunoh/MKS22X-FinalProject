import java.util.*;
import java.io.*;


Map m;
int currentRoom = 0;
int currentState = 0;
Room[][] rooms;
ArrayList<Integer> validRooms;
String str;

void setup() {
  size(1000, 500);
  int halfWidth = width / 24;
  int halfHeight = height / 24;
  m = new Map(halfWidth, halfHeight);
  m.initRooms();
  validRooms = m.getCoords();
  rooms = m.getMap();
  str = toStringMap();
}


void draw() {
  if (currentState == 0) startScreen();
  if (currentState == 1) gameScreen();
  if (currentState == 2) deathScreen();
}

void mousePressed(){
 if (currentState == 0) currentState = 1; 
}

String toStringMap() {
  String str = " ";
  for (int i = 0; i < validRooms.size(); i+=2) {
    int r = validRooms.get(i);
    int c = validRooms.get(i+1);
    str += rooms[r][c].toString() + "\n";
  }
  return str;
}

void startScreen() {
  background(0);
  textAlign(CENTER);
  text("Click to start", width/2, height/2);
}

void gameScreen() {
  background(255);
  fill(50);
  textAlign(LEFT);
  text(str, 0, 10);
}



void deathScreen() {
  background(0);
  textAlign(CENTER);
  fill(255);
  textSize(30);
  text("You died! Game Over", height/2, width/2 - 20);
  textSize(15);
  text("Click to Restart", height/2, width/2 + 10);
}
