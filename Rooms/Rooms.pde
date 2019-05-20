int[][] map;
int[][] directions = { {-1, 0}, {1, 0}, {0, -1}, {0, 1} };
int[] lastDirection = { };
int[] randomDirection;

void createArray(int num, int dimensions) {
  map = new int[dimensions][dimensions];
  for (int i = 0; i < dimensions; i++) {
    for (int j = 0; j < dimensions; j++) {
      map[i][j] = num;
    }
  }
}

void createMap() {
  int dimensions = 3;
  int maxTunnels = 3;
  int maxLength = 3;
  int currentRow = (int) Math.floor(Math.random() * dimensions);   
  int currentCol = (int) Math.floor(Math.random() * dimensions);
  createArray(1, dimensions);
  do {
    randomDirection = directions[(int) Math.floor(Math.random() * directions.length)];
  } while ((randomDirection[0] == -lastDirection[0] && randomDirection[1] == -lastDirection[1]) 
    || (randomDirection[0] == lastDirection[0] &&randomDirection[1] == lastDirection[1]));
  int randomLength = (int) Math.ceil(Math.random() * maxLength);      
  int tunnelLength = 0;
  while (tunnelLength < randomLength) { 
    if (((currentRow == 0) && (randomDirection[0] == -1))||  
      ((currentCol == 0) && (randomDirection[1] == -1))|| 
      ((currentRow == dimensions— 1) && (randomDirection[0] == 1))||
      ((currentCol == dimensions— 1) && (randomDirection[1] == 1)))   
    { 
      break;
    } else { 
      map[currentRow][currentCol] = 0; 
      currentRow += randomDirection[0];
      currentCol += randomDirection[1]; 
      tunnelLength++;
    }
  }
}
