  Player person;
  ArrayList<Item> items;
  ArrayList<Gorlag> enemies;
  void setup() {
    size(640, 360);
    background(255, 204, 0);
    smooth(3);
    frameRate(10);
    items = new ArrayList<Item>();
    enemies = new ArrayList<Gorlag>();
    Item item =  new Item(1, 320, 180);
    items.add(item);
    person = new Player("bob", "knight", 0, 180);
    Gorlag enemy = new Gorlag(400, 200, (int)(Math.random() * 10));
    enemies.add(enemy);
  }
  
  void draw() {
    background(255, 204, 0);  
    for(int i = 0; i < items.size(); i++){
      Item item = items.get(i);
      item.display();
      text("Item X:" + item.getX(), 10, 70);
      text("Item Y:" + item.getY(), 10, 90);
    }
    person.move();
    person.display(items);
    textSize(11);
    text("Player X:" + person.getX(), 10, 30); 
    text("Player Y:" + person.getY(), 10, 50);
    text("Inventory: " + person.stringInv(), 10, 110);
    text("Current: " + person.getItem(), 10, 130);
    
    for(int i = 0; i < enemies.size(); i++){
      Gorlag enemy = enemies.get(i);
      enemy.setMove(person);
      enemy.move();
      if(dist(person.getX(), person.getY(),enemy.getX(), enemy.getY()) < 50){
        enemy.attack(person);
      }
      enemy.display();
      text("Enemy HP: " + enemy.getHealth(), 10, 150);
    }
    
  }
  
  void mousePressed(){
    person.attack(true, enemies);
  }
  void mouseReleased(){
     person.attack(false, enemies);
  }
  void keyReleased(){
    person.setMove(keyCode, false); 
  }
  
  void keyPressed(){
     person.setMove(keyCode, true); 
   }
  void mouseWheel(MouseEvent event) {
    float e = event.getCount();
    person.switchItem(e);
  }