import java.util.*;
import java.io.*;


Map map;
int currentRoomRow, currentRoomCol;
int currentState = 0;
Room[][] rooms;
Room current;
//String str;
Screen screen;

void setup() {
  size(2000, 1000);
  map = new Map(width, height);
  currentRoomRow = map.getStartRow();
  currentRoomCol = map.getStartCol();
  rooms = map.getMap();
  screen = new Screen();
  getRoom();
}


void draw() {
  background(0, 0, 255);
  if (currentState == 0) screen.startScreen();
  if (currentState == 1) screen.gameScreen(current);
  if (currentState == 2) screen.deathScreen();
}

void getRoom(){
  //str = rooms[currentRoomRow][currentRoomCol].toString();
  current = rooms[currentRoomRow][currentRoomCol];
}

void keyReleased(){
    current.setMove(keyCode, false); 
  }
  
void keyPressed(){
   current.setMove(keyCode, true); 
 }

void mousePressed() {
  if (currentState == 0) currentState = 1;
  if (currentState == 2) currentState = 0;
}
