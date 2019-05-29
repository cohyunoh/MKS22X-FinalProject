class Gorlag extends Entity{
  boolean chase;
  Gorlag(float x, float y){
   super("gorlag", 100, 0, 10.00, "gorlag", x, y);
  }
  
  void setMove(Player person){
    if(dist(person.getX(), person.getY(),xCor, yCor) < 50){
      
    }
  }
}
