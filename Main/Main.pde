import java.util.*;
import java.io.*;

Room r;

void setup() {
  size(500, 500);
  int rows = (int)(10 - 1);
  int cols = (int)(10 - 1);
  r = new Room(rows,cols);
}


void draw() {
  String str = r.toString();
  background(255);
  fill(50);
  text(str,0,0); 
}


void initScreen() {
  background(0);
  textAlign(CENTER);
  text("Click to start", height/2, width/2);
}

void gameScreen() {
  background(255);
  int rows = (int)(Math.random() * width - 1);
  int cols = (int)(Math.random() * height - 1);
  Map m = new Map(rows, cols);
  m.displayMap();
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
