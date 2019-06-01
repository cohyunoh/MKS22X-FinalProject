import java.util.*;

class Room implements Moveable{
  int vel = 5;
  boolean isLeft, isRight, isUp, isDown, wasLeft, wasRight, run, hasLeft, hasRight, hasUp, hasDown;
  char[][] floor;
  char current, next;
  int rows, cols, totaldoors;
  float x, y;
  PImage tile = loadImage("floor.png");
  PImage wall = loadImage("wall.png");
  ArrayList<Enemy> enemies;
  ArrayList<Item> items;
  ArrayList<Door> doors = new ArrayList<Door>();
  Player person;

  //********   CONSTRUCTORS THAT CREATE ROOMS DEPENDING ON IF THERE WAS A PREVIOUS DOOR OR NOT ********//

  public Room(int rows, int cols, float x, float y) {
    this.rows = rows;
    this.cols = cols;
    floor = new char[rows][cols];
    initRoom();
    this.x = x;
    this.y = y;
  }


  public Room(int rows, int cols, Door door, float x, float y) {
    this.rows = rows;
    this.cols = cols;
    floor = new char[rows][cols];
    totaldoors = 0;
    initRoom(door);
    this.x = x;
    this.y = y;
  }

  //********   METHODS THAT INITALIZE ROOMS DEPENDING ON IF THERE IS A PREVIOUS DOOR OR NOT ********//
  
  void addEnemies(ArrayList<Enemy> enemies){
    this.enemies = enemies;
    for(int i = 0; i < enemies.size(); i++){
      Enemy enemy = enemies.get(i);
      enemy.setX((float)(32 + abs((float)(Math.random() * (32 * rows - 2)))));
      enemy.setY((float)(32 + abs((float)(Math.random() * (32 * cols - 2)))));
      enemy.addConstrainX(0, 32 * (rows));
      enemy.addConstrainY(0, 32 * (cols)); 
    }
  }
  
  void addItems(ArrayList<Item> items){
    this.items = items;
  }
  
  void addPlayer(Player person){
    this.person = person;
  }
  
  void initRoom(Door door) {
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        floor[r][c] = isWall(r, c) ? '#' : ' ';
      }
    }
    if (door.isUp()) putDoorDown(door.getCol());
    else if (door.isDown()) putDoorUp(door.getCol());
    else if (door.isLeft()) putDoorLeft();
    else putDoorRight();
  }


  void initRoom() {
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        floor[r][c] = isWall(r, c) ? '#' : ' ';
      }
    }
    generateRandomDoor();
  }

  //Checks if the tile should be a wall or not
  boolean isWall(int row, int col) {
    if (row == 0 || row == rows - 1|| col == 0|| col == cols - 1) return true;
    return false;
  }

  int getRows() {
    return rows;
  }

  int getCols() {
    return cols;
  }

  //********   METHODS THAT CREATE DOORS PROPERLY ********// 

  void generateRandomDoor() {
    int doors = (int)abs((float)(Math.random() * 4)) + 1;
    int randomRow = (int)abs((float)(Math.random() * rows - 1)) + 2;
    int randomCol = (int)abs((float)(Math.random() * cols - 1)) + 2;
    int currentNum = 0;
    //keep going until there is the correct specified number of doors
    while(currentNum != doors){
      //choose random side
      int side = (int)abs((float)(Math.random() * 101));
      //left side
      if(side<=25 && !hasLeft){
        floor[randomRow][1] =  'D';
        hasLeft = true;
        currentNum += 1;
      //right side
      }else if(side > 25 && side <= 50 && !hasRight){
        floor[randomRow][cols - 2] =  'D';
        hasRight = true;
        currentNum += 1;
      //top side
      }else if(side > 50 && side <= 75 && !hasUp){
        floor[1][randomCol] =  'D';
        hasUp = true;
        currentNum += 1;
      //bottom side
      }else if(side > 75 && !hasDown){
        floor[rows - 2][randomCol] =  'D';
        hasDown = true;
        currentNum += 1;
      }
    }
  }

  void putDoorDown(int c) {
    floor[rows - 2][c] = 'D';
  }

  void putDoorUp(int c) {
    floor[0][c] = 'D';
  }

  void putDoorLeft() {
    floor[rows/2][0] = 'D';
  }

  void putDoorRight() {
    floor[rows/2][cols] = 'D';
  }
  
  void display(){
    if(run){
        vel = 25;
      }else{
        vel = 10;
      }
    for(int r = 0; r < floor.length; r++){
      for(int c = 0; c < floor[0].length; c++){
        char slot = floor[r][c];
        if(slot == '#'){
          imageMode(CORNER);
          image(wall, x + (32 * r), y + (32 * c));
        }else if(slot == ' ' || slot == 'D'){
          imageMode(CORNER);
          image(tile, x + (32 * r), y + (32 * c));
        }
      }
    }
    
    for(int i = 0; i < doors.size(); i++){
      Door door = doors.get(i);
      door.display();
    }
    
    if(items != null){
      for(int i = 0; i < items.size(); i++){
        Item item = items.get(i);
        item.display();
      }
    }
    if(enemies != null){
      for(int i = 0; i < enemies.size(); i++){
        Enemy enemy = enemies.get(i);
        enemy.setMove(person);
        if(dist(person.getX(), person.getY(),enemy.getX(), enemy.getY()) < 50){
          enemy.attack(person);
        }
        enemy.display();
      }
    }
  }
  
  //generates a string of the room
  String toString() {
    String str = " ";
    for (int r = 0; r < rows; r++) {
      String s = " ";
      for (int c = 0; c < cols; c++) {
        s += floor[r][c] + "";
      }
      str += s + '\n';
    }
    return str;
  }
  
  void move(){
    if(person.isDead()){
      return ;
    }
    float newX = constrain(x + vel *(int(isLeft) - int(isRight)),-1 * abs(750 - ((rows) * 32)) + person.getWidth() / 2, 750 - person.getWidth() / 2);
    float newY = constrain(y + vel *(int(isUp)  - int(isDown)),-1 * abs(500 - ((cols) * 32)) + person.getHeight() / 2, 500 - person.getHeight() / 2);
    moveAll(vel *(int(isLeft) - int(isRight)),vel *(int(isUp)  - int(isDown)), newX, newY, x,y);
    x = newX;
    y = newY;
  }
  
  void moveAll(float x, float y, float newX, float newY, float oldX, float oldY){
      if(items != null){
        for(int i = 0; i < items.size(); i++){
          Item item = items.get(i);
          if(oldX != newX){
            item.setX(item.getX() - x);
          }
          if(oldY != newY){
            item.setY(item.getY() - y);
          }
          
        }
      }
      if(enemies != null){
        for(int i = 0; i < enemies.size(); i++){
          Enemy enemy = enemies.get(i);
          if(oldX != newX){
            enemy.changeX(x);
            enemy.changeConstX(x);
          }
          if (oldY != newY){
            enemy.changeY(y);
            enemy.changeConstY(y);
          }
         
          
          enemy.move();
          
        }
      }
  }
  
  boolean setMove(int k, boolean b) {
    switch (k) {
      case SHIFT:
        return run = b;
      case + 'W':
      case 'w':
        return isUp = b;
      case + 'S':  
      case 's':
        return isDown = b;
      case + 'A':  
      case 'a':
        wasLeft = true;
        wasRight = false;
        return isLeft = b;
      case + 'D':  
      case 'd':
        wasLeft = false;
        wasRight = true;
        return isRight = b;
      default:
        return b;
    }
  }
  
  float getX(){
    return x;
  }
  
  float getY(){
    return y;
  }
  
  void addDoors(){
    for(int r = 0; r < floor.length; r++){
      for(int c = 0; c < floor[0].length; c++){
        char slot = floor[r][c];
        if(slot == 'D'){
          Door door =  new Door(32 * (r + 1), 32 * c + 12, r, c);
          doors.add(door);
        }
      }
    }
  }
  
  ArrayList<Door> getDoors(){
    return doors;
  }
}
