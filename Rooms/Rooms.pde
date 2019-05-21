import java.util.*;
import java.io.*;

int currentState = 0;
char[][] map;

void setup() {
  size(500, 500);
}


void draw() {
  if (currentState == 0) {
    initScreen();
  } else if (currentState == 1) {
    gameScreen();
  } else if (currentState == 2) {
    gameOverScreen();
  }
}

void mousePressed() {
  if (currentState==0) {
    startGame();
  }
}

void startGame() {
  currentState=1;
}

void initScreen() {
  background(0);
  textAlign(CENTER);
  text("Click to start", height/2, width/2);
}

void gameScreen() {
  createMap();
}

void createMap() {
  try {
    Scanner s = new Scanner(new File("TestMap.txt"));
    int r = 0;
    int c = 0;
    while (s.hasNextLine()) {
      r = s.nextLine().length();
      c++;
    }
    map = new char[c][r];
    Scanner scan = new Scanner(new File("TestMap.txt"));
    int i = 0;
    while (scan.hasNextLine()) {
      String line = scan.nextLine();
      for (int j = 0; j < map.length; j++) {
        map[i][j] = line.charAt(j);
      }
      i++;
    }
  }
  catch (FileNotFoundException f) {
  }
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
