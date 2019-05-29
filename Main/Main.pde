import java.util.*;
import java.io.*;


Map map;
int currentRoom = 0;
int currentState = 0;
Room[][] rooms;
String str;
Screen screen;

void setup() {
  size(1000, 1000);
  map = new Map(width/4,height/4);
  rooms = map.getMap();
  screen = new Screen();
}


void draw() {
  if (currentState == 0) screen.startScreen();
  if (currentState == 1) screen.gameScreen();
  if (currentState == 2) screen.deathScreen();
}

void mousePressed() {
  if (currentState == 0) currentState = 1;
}
