class Animation {
  PImage[] frames;
  int totalFrames;
  int frame;
  
  Animation(String name, int count) {
    totalFrames = count;
    frames = new PImage[totalFrames];

    for (int i = 0; i < totalFrames; i++) {
      String filename = name + i + ".png";
      frames[i] = loadImage(filename);
    }
  }

  void display(float xpos, float ypos) {
    frame = (frame+1) % totalFrames;
    imageMode(CENTER);
    image(frames[frame], (xpos + getWidth() / 2), ypos + (getHeight() / 2));
   }
  
  int getWidth() {
    return frames[0].width;
  }
  int getHeight() {
    return frames[0].height;
  }
}
