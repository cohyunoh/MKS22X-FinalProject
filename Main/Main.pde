import java.util.*;
import java.io.*;


Map m;
int currentRoom = 0;
Room[][] rooms;
ArrayList<Integer> validRooms;

void setup() {
  size(1000, 500);
  int halfWidth = width / 24;
  int halfHeight = height / 24;
  m = new Map(halfWidth, halfHeight);
  m.initRooms();
  validRooms = m.getCoords();
}


void draw() {
  rooms = m.getMap();
  Room[] room = rooms[currentRoom];
  String str = toStringArray(room);
  background(255);
  fill(50);
  textAlign(LEFT);
  text(str, 100, 100);
}

String toStringArray(Room[] room) {
  String str = " ";
  for (int i = 0; i < validRooms.size(); i+=2){
    str += room[validRooms.get(i)][validRooms.get(i+1)] + "\n";
  }
  return str;
}

void initScreen() {
  background(0);
  textAlign(CENTER);
  text("Click to start", height/2, width/2);
}

void gameScreen() {
  background(255);
}



void gameOverScreen() {
  background(0);
  textAlign(CENTER);
  fill(255);
  textSize(30);
  text("You died! Game Over", height/2, width/2 - 20);
  textSize(15);
  text("Click to Restart", height/2, width/2 + 10);
}
