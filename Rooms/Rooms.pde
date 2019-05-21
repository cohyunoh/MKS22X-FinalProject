import java.util.*;
import java.io.*;

int currentState;
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
  background(255);
  int rows = (int)random(5.0) * 500;
  int cols = (int)random(5.0) * 500;
  try{
    createMap(rows,cols);
  } catch (FileNotFoundException f){
    
  }
}

void createMap(int rows, int cols) throws FileNotFoundException{
        Scanner s = new Scanner(new File("TestMap.txt"));
        int r = 0;
        int c = 0;
        while (s.hasNextLine()) {
          r = s.nextLine().length();
          c++;
        }
        map = new char[c][r];
        s = new Scanner(new File("TestMap.txt"));
        int i = 0;
        while (s.hasNextLine()) {
          String line = s.nextLine();
          for (int j = 0; j < r; j++) {
            map[i][j] = line.charAt(j);
          }
          i++;
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
