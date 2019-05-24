
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
  
  void setup() {
    size(640, 360);
    background(255, 204, 0);
    frameRate(10);
    item =  new Item(0, 320, 180);
    person = new Entity("bob", 100, 100, 0.0, "knight", x, y);
    direction = "left";
  }
  
  void draw() {
    x += (right - left) * speed;
    y += (down - up) * speed;
    background(255, 204, 0);   
    person.setX(x);
    person.setY(y);
    person.display(direction, move);
    item.display();
  }
  
  void keyReleased(){
    if (key == 'a' || key == 'A'){
      left = 0;
      direction = "idleLeft";
      move = false;
    }
    if (key == 'd' || key == 'D'){
      right = 0;
      direction = "idleRight";
      move = false;
    }
    if (key == 'w' || key == 'W'){
      up = 0;
      move = false;
    }
    if (key == 's' || key == 'S'){
      down = 0;
      move = false;
    }
   }
  
  void keyPressed(){
     if (key == 'a' || key == 'A'){
       left = 1;
       direction = "left";
       move = true;
     }
     if (key == 'd' || key == 'D'){
        right = 1;
        direction = "right";
        move = true;
     }
     if (key == 'w' || key == 'W'){
      up = 1;
      move = true;
    }
    if (key == 's' || key == 'S'){
      down = 1;
      move = true;
    }
   }
