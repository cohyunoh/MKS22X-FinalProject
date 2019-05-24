
 Entity person;
  Item item;
  float xpos;
  float ypos;
  float drag = 30.0;
  float x = 0;
  float y = 180;
  float speed = 10.0;
  float left = 0;
  float right = 0;
  float up = 0;
  float down = 0;
  String direction;
  boolean move;
  ArrayList<String> moves;
  
  void setup() {
    size(640, 360);
    background(255, 204, 0);
    frameRate(10);
    item =  new Item(0, 320, 180);
    person = new Entity("bob", 100, 100, 0.0, "knight", x, y);
    direction = "left";
    moves = new ArrayList<String>(1);
  }
  
  void draw() {
    x += (right - left) * speed;
    y += (down - up) * speed;
    background(255, 204, 0);   
    person.setX(x);
    person.setY(y);
    person.display(moves);
    item.display();
  }
  
  void keyReleased(){
    if (key == 'a' || key == 'A'){
      left = 0;
      moves.add("idleLeft");
    }
    if (key == 'd' || key == 'D'){
      right = 0;
      moves.add("idleRight");
    }
    if (key == 'w' || key == 'W'){
      up = 0;
      moves.add("idleLeft");
    }
    if (key == 's' || key == 'S'){
      down = 0;
      moves.add("idleRight");
    }
   }
  
  void keyPressed(){
     if (key == 'a' || key == 'A'){
       left = 1;
       moves.add("left");
     }
     if (key == 'd' || key == 'D'){
        right = 1;
        moves.add("right");
     }
     if (key == 'w' || key == 'W'){
      up = 1;
      moves.add("left");
    }
    if (key == 's' || key == 'S'){
      down = 1;
      moves.add("right");
    }
   }
