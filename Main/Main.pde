import java.util.*;
import java.io.*;


Map map;
int currentRoom = 0;
int currentState = 0;
Room[] rooms;
String str;

void setup() {
  size(1000, 1000);
  map = new Map(width/4);
  rooms = map.getMap();
  str = rooms[currentRoom].toString();
}


void draw() {
  if (currentState == 0) startScreen();
  if (currentState == 1) gameScreen();
  if (currentState == 2) deathScreen();
}

void mousePressed() {
  if (currentState == 0) currentState = 1;
}

void startScreen() {
  background(0);
  textAlign(CENTER);
  text("Click to start", width/2, height/2);
}

void gameScreen() {
  background(0,0,255);
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
