import processing.serial.*;

Serial myPort;    // The serial port
PFont myFont;     // The display font
String inString;  // Input string from serial port
int lf = 10;      // ASCII linefeed

void setup() {
  size(400,200);
  // Make your own font. It's fun
  // List all the available serial ports:
  printArray(Serial.list());
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.buffer(3);

}

void draw() {
  // Twiddle your thumbs
  background(0);
  text("Received: " + inString, 10, 50);

}

void serialEvent(Serial myPort) {
  inString = myPort.readString();
}