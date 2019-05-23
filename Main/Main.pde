import java.util.*;
import java.io.*;



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
  background(255);
  displayRooms();
}

void displayRooms() {
  Map(rows,cols);
  int[][] display = new int[rows][cols];

  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      if (rooms[r][c] != null) {
        display[r][c] = 1;
      } else {
        display[r][c] = 0;
      }
    }
  }
  for (int[] i : display) {
    printArray(i);
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
