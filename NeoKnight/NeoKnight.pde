import java.util.*; //<>// //<>// //<>// //<>//
import java.io.*;

Player person;
ArrayList<Enemy> enemies;
Map map;
int currentRoomRow, currentRoomCol;
int currentState = 0;
Room[][] rooms;
Room current; //<>// //<>// //<>//
int roomNum = 1; //<>// //<>// //<>//
//String str; //<>// //<>// //<>//
Screen screen; //<>// //<>// //<>//
int obj;



void setup() {
  size(1500, 1000);
  createEnemies();
  if (roomNum == 1) {
    person = new Player("bob", "knight", 750, 500);
    map = new Map(100, 100);
    currentRoomRow = map.getStartRow();
    currentRoomCol = map.getStartCol();
    current = rooms[currentRoomRow][currentRoomCol];
    screen = new Screen();
  }
  smooth(3);
  frameRate(10);
  current.addEnemies();
  current.addKeys();
  obj = (int)abs((float)Math.random() * 4) + 1;
}


void draw() {
  background(0);
  if (currentState == 0) screen.startScreen();
  if (currentState == 1) {

    screen.gameScreen(current, person);
    
  }
  if (currentState == 2) screen.deathScreen();
  if (obj == 1) {
    if (person.numEnemies == 1000) {
      currentState = 5;
    }
  }

  if (obj == 2) {
    if (person.numDoors == 500) {
      currentState = 5;
    }
  }

  if (obj == 3) {
    if (roomNum == 500) {
      currentState = 5;
    }
  }
  if (person.isDead()) {
    currentState = 2;
  }
  if (currentState == 3) screen.shopScreen();
  if (currentState == 4) screen.instructionScreen();
  if (currentState == 5) screen.winScreen();
  if (currentState == 6) screen.inventory();
  if (person.isDead()) currentState = 2;
}


void keyReleased() {
  if (currentState == 1) {
    current.setMove(keyCode, false); 
    person.setMove(keyCode, false);
  }
}

void keyPressed() {
  if (currentState == 0) {
    if (key == 'i' || key == 'I') currentState = 4;
  } else if (currentState == 1) {
    current.setMove(keyCode, true); 
    person.setMove(keyCode, true);
    if (key == 'q' || key == 'Q') currentState = 3;
    if (key == 'c' || key == 'C') currentState = 6;
    if (key == 'r' || key == 'R') {
      currentState = 0;
      roomNum = 1;
      setup();
    }
  } else if (currentState == 3) {
    screen.setInput(keyCode);
    if (key == 'q' || key == 'Q') currentState = 1;
  } else if (currentState == 4) {
    if (key == 'i' || key == 'I') currentState = 0;
  } else if (currentState == 5) {
    if (key == 'y' || key == 'Y') currentState = 0;
  } else if (currentState  == 6) {
    if (key == 'c' || key == 'C') currentState = 1;
  }
}

void mousePressed() {
  if (currentState == 0) {
    currentState = 1;
  }
  if (currentState == 2) {
    currentState = 0;
    roomNum = 1;
    setup();
  }
  if (person.inHand.getType().equals("melee")) {
    person.setAttack();
  }
  if (person.inHand.getType().equals("shooting")) {
    person.setShoot();
  }
  if (person.inHand.getType().equals("heal")) {
    person.setHeal();
  }
  if (person.inHand.getType().equals("block")) {
    person.setBlock();
  }
  if (person.inHand.getType().equals("key")) {
    person.setUseKey();
  }
}



void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  person.switchItem(e);
}

int countAlive() {
  int ans = 0;
  for (int i = 0; i < enemies.size(); i++) {
    Enemy enemy = enemies.get(i);
    if (!enemy.die) {
      ans ++;
    }
  }
  return ans;
}

void displayEnemies() {
  for (int i = 0; i < current.roomenemies.size(); i++) {
    Enemy enemy = current.roomenemies.get(i);
    enemy.setMove();
    if (dist(person.getX(), person.getY(), enemy.getX(), enemy.getY()) < 50) {
      enemy.attack();
      if (person.isHurt()) {
        float newX = 0;
        float newY = 0;
        if (enemy.getX() > current.x) {
          newX = constrain(current.x + 30, -1 * abs(750 - ((current.cols) * 32)) + person.getWidth() / 2, 750 - person.getWidth() / 2);
        } else {
          newX = constrain(current.x - 30, -1 * abs(750 - ((current.cols) * 32)) + person.getWidth() / 2, 750 - person.getWidth() / 2);
        }
        if (enemy.getY() > current.y) {
          newY = constrain(current.y + 30, -1 * abs(500 - ((current.rows) * 32)) + person.getHeight() / 2, 500 - person.getHeight() / 2);
        } else {
          newY = constrain(current.y - 30, -1 * abs(500 - ((current.rows) * 32)) + person.getHeight() / 2, 500 - person.getHeight() / 2);
        }

        current.moveAll(newX, newY, current.x, current.y);
        current.x = newX;
        current.y = newY;
        person.notHurt();
      }
    }
    enemy.display();
  }
}

void createEnemies() {
  enemies = new ArrayList<Enemy>();
  int numEnemies = (int)(Math.random() * (5 + roomNum)) + 5;
  for (int i = 0; i < numEnemies; i++) {
    Enemy gorlag = new Mercenary(0, 0);
    gorlag.num = roomNum;
    enemies.add(gorlag);
  }
}
