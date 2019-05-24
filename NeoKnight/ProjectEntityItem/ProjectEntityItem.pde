
 Entity person;
  Item item;
  float xpos;
  float ypos;
  float drag = 30.0;
  float x = 0;
  float speed = 10.0;
  float left = 0;
  float right = 0;
  float up = 0;
  float down = 0;
  String direction;
  float[] moves = {up,down,left,right};
  
  void setup() {
    size(640, 360);
    background(255, 204, 0);
    frameRate(10);
    item =  new Item(0, 320, 180);
    person = new Entity("bob", 100, 100, 0.0, "knight", x, 180);
    direction = "left";
  }
  
  void draw() {
    x += (right - left) * speed;
    background(255, 204, 0);   
    person.setX(x);
    person.display(direction);
    item.display();
  }
  
  void keyReleased(){
    if (key == 'a' || key == 'A'){
      left = 0;
    }
    if (key == 'd' || key == 'D'){
      right = 0;
    }
        /*
        if (keyCode == UP){
          up = 0;
        }
        */
   }
  
  void keyPressed(){
     if (key == 'a' || key == 'A'){
       left = 1;
       direction = "left";
     }
     if (key == 'd' || key == 'D'){
        right = 1;
        direction = "right";
     }
   }
