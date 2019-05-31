import java.util.*;
import java.io.*;


Map map;
int currentRoomRow, currentRoomCol;
int currentState = 0;
Room[][] rooms;
Room current;
String str;
Screen screen;

void setup() {
  size(1000, 1000);
  map = new Map(width, height);
  currentRoomRow = map.getStartRow();
  currentRoomCol = map.getStartCol();
  rooms = map.getMap();
  screen = new Screen();
  current = rooms[currentRoomRow][currentRoomCol];
  str = current.toString();
}


void draw() {
  if (currentState == 0) screen.startScreen();
  if (currentState == 1) screen.gameScreen(str);
  if (currentState == 2) screen.deathScreen();
}

void mousePressed() {
  if (currentState == 0) currentState = 1;
  if (currentState == 2) currentState = 0;
}
