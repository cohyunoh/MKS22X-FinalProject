
  Player person;
  Item item;
  
  void setup() {
    size(640, 360);
    background(255, 204, 0);
    smooth(3);
    frameRate(10);
    item =  new Item(0, 320, 180);
    person = new Player("bob", "knight", 0, 180);
  }
  
  void draw() {
    background(255, 204, 0);   
    item.display();
    person.move();
    person.display();
  }
  
  void keyReleased(){
    person.setMove(keyCode, false); 
  }
  
  void keyPressed(){
     person.setMove(keyCode, true); 
   }
   
