
 Entity person;
  Item item;
  float xpos;
  float ypos;
  float drag = 30.0;
  float x = 0;
  float speed = 10.0;
  float left = 0;
  float right = 0;
  String direction;
  
  void setup() {
    size(640, 360);
    background(255, 204, 0);
    frameRate(10);
    item =  new Item(0);
    person = new Entity("bob", 100, 100, 0.0, "knight");
    direction = "left";
  }
  
  void draw() {
    item.display(320, 180);
    x += (right - left) * speed;
    person.display(x, 180, direction);
    
  }
  
  void keyReleased(){
      if (key == CODED){
        if (keyCode == LEFT){
          left = 0;
          direction = "idleLeft";
        }
        if (keyCode == RIGHT){
          right = 0;
          direction = "idleRight";
        }
      }
    }
  
  void keyPressed(){
     if (key == CODED){
       if (keyCode == LEFT){
         left = 1;
         direction = "left";
       }
       if (keyCode == RIGHT){
         right = 1;
         direction = "right";
       }
      }
    }