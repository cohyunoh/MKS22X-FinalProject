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
    background(255, 204, 0);
    image(frames[frame], xpos, ypos);
   }
  
  int getWidth() {
    return frames[0].width;
  }
}
