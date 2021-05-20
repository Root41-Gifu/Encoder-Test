import  processing.serial.*;

Serial  serial;

PImage img;

int deg = 0;
float x;
float _x;
float y;
float _y;

PFont font;

void setup() {
  
  deg = 0;

  fullScreen();

  img = loadImage("data/top.jpg");

  img.resize( 0, width );

  image( img, (width - img.width)/2, 0 );
  ellipseMode(CENTER);

  font = createFont("data/Lato-Bold.ttf", 200);
  textFont(font);
  
  serial = new Serial( this, "/dev/cu.usbmodem141202", 9600 );
}

void draw() {
  image( img, (width - img.width)/2, 0 );

  fill(#000000, 100);
  rect(0, 0, width, height);
  fill(#000000, 140);
  ellipse(width/2, height/2, 700, 700);
  noFill();
  stroke(#BBBBBB);
  strokeWeight(2);
  ellipse(width/2, height/2, 700, 700);

  if ( serial.available() >= 3 ) {
    if ( serial.read() == 'H' ) {
      int high = serial.read();
      int low = serial.read();
      deg = high*256 + low;
    }
    
    serial.clear();
    
    //while(serial.available() != 0){
    //  serial.clear();
    //}
  }
  
  x = 0.85 * _x + 0.15 * sin(radians(360 - deg - 270)) * 350;
  y = 0.85 * _y + 0.15 * cos(radians(360 - deg - 270)) * 350;

  noStroke();
  fill(#4DD0E1);
  ellipse(350 * sin(atan2(y,x)) + width/2, height/2 - 350 * cos(atan2(y,x)), 140, 140);
  //ellipse(x + width/2, height/2 - y, 140, 140);
  fill(#EEEEEE);
  textAlign(CENTER);
  text(deg + "°", width/2 + 20, height/2 + 70);
  
  noFill();
  
  _x = x;
  _y = y;
}
