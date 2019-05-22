import java.util.*;
import java.io.*;

int currentState = 0;
Room[][] rooms;
int rows, cols;
int[][] moves = {
{0,1}, {1,0}, {0,-1},{-1,0}
};

private Rooms(int rows, int cols) {
  this.rows = rows;
  this.cols = cols;
  rooms = new Room[rows][cols];
}

void initRooms() {
  int startX = (int)(Math.random() * rows);
  int startY = (int)(Math.random() * cols);
  int row = (int)(Math.random() * width - 1);
  int col = (int)(Math.random() * height - 1);
  rooms[startX][startY] = new Room[row][col];
  for (int i = 0; i < 13; i++){
    int direction = (int)(Math.random() * 4);
    startX+= moves[direction][0];
    startY+= moves[direction][1];
    int row = (int)(Math.random() * width - 1);
    int col = (int)(Math.random() * height - 1);
    rooms[startX][startY] = new Room[row][col];
  }
}

void create

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
    currentState = 1;
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
  displayMap();
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
