import java.util.*;
import java.io.*;


Map m;

void setup() {
  size(1000, 1000);
  int halfWidth = width / 24;
  int halfHeight = height / 24;
  m = new Map(halfWidth,halfHeight);
  m.initRooms();
}


void draw() {
  String str = m.toString();
  background(255);
  fill(50);
  text(str,mouseX,mouseY); 
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
