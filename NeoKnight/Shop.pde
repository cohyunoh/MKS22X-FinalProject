class Shop {

  ArrayList<Item> content;
  boolean open; 
  float xCor, yCor, lowX, lowY, highX, highY;
  ;

  Shop(float xCor, float yCor) {
    content = new ArrayList<Item>();
    this.xCor = xCor;
    this.yCor = yCor;
    getItems();
    setCoords();
  }

  void getItems() {
    int numItems = (int)abs((float)((Math.random() * 14))) + 3;
    for (int i = 0; i < numItems; i++) {
      int randomItemIdx = (int)abs((float)((Math.random() * 8)));
      Item item = new Item(randomItemIdx, 0, 0);
      item.display = false;
      content.add(item);
    }
  }

  void setCoords() {
    float x = 654;
    float y = 404;
    int counter = 0;
    for (int i = 0; i < content.size(); i++) {
      Item item  = content.get(i);
      if (inBounds(item.xCor, item.yCor) && counter < 4) {
        item.xCor = x;
        item.yCor = y;
        x += 64;
        counter++;
      } else if (inBounds(item.xCor, item.yCor) &&counter >= 4) {
        y += 64;
        x = 654;
      }
    }
  }

  boolean inBounds(float xCor, float yCor) {
    if (xCor > 846 || xCor < 654  || yCor < 404 || yCor > 596 ) return false;
    return true;
  }

  void displayItems() {
    for (Item item : content) {
      item.display  = open;
      item.display();
    }
  }

  void display() {
    rect(xCor, yCor, 50, 50);
    fill(255,0,0);
    textSize(20);
    text(xCor,yCor,xCor,yCor);
    if (open) {
      rectMode(CENTER);
      rect(750, 500, 244, 244);
      displayItems();
    }
  }

  void changeX(float x) {
    xCor = constrain(xCor + x, lowX, highX);
  }

  void changeY(float y) {
    yCor = constrain(yCor + y, lowY, highY);
  }

  void addConstrainX(float low, float high) {
    lowX = low;
    highX = high;
  }

  void addConstrainY(float low, float high) {
    lowY = low;
    highY = high;
  }

  void changeConstX(float x) {
    lowX += x;
    highX += x;
  }

  void changeConstY(float y) {
    lowY += y;
    highY += y;
  }
}
