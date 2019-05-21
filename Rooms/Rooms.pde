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

void createMap() {
  map = new Room[10][10];
  for (int i = 0; i < map.length; i++){
    for (int j = 0; j < map[0].length; j++){
      map[i][j] = ' ';
    }
  }
  
  int startRow = (int)(Math.random()) * 10;
  int endRow = (int)(Math.random()) * 10;
  int startCol = (int)(Math.random()) * 10;
  int endCol = (int)(Math.random()) * 10;
  map[startRow][startCol] = 'S';
  map[endRow][endCol] = 'E';
  findPath(startRow, startCol, 0);
}


void findPath(int row, int col, int steps) {
  if (map[row][col] == 'E') return;
  if (map[row][col] != ' ') return;
  int[][] moves = new int[][]{
    {0, 1}, {1, 0}, {0, -1}, {-1, 0}
  };
  for (int i = 0; i < moves.length; i++) {
    int r = row + moves[i][0];
    int c = col + moves[i][1];
    map[row][col] = '@';
    int solution = solve(r, c, steps + 1);
    if (solution != -1) return solution;
    map[row][col] = '.';
  }
  return -1;
}

void displayMap() {
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
