
PImage img;
color red, green, blue, white; 
color cred, cgreen, cblue;
int Y_AXIS = 1;
int X_AXIS = 2;
PVector brushStart, brushEnd;
float step; 
float pct;
PVector brushCurrent;
float exponent; 
PVector dist;


void setup() {
  size(640, 600);
  img = loadImage("lion.jpg");
  red = color(255, 0, 0, 255);
  cred = color(255, 0, 0, 0);
  green = color(0, 255, 0, 255);
  cgreen = color(0, 255, 0, 0);
  blue = color(0, 0, 255, 255);
  cblue = color(0, 0, 255, 1);
  white = color(255, 255, 255);
  brushStart = new PVector(320, 505);
  brushEnd = new PVector();
  brushCurrent = new PVector();
  dist = new PVector();
  step = 0.05;
  pct = 0.0;
  exponent = 4;
  
}


void draw() {
  background(231);
  stroke(255);
  strokeWeight(2);
  line(0, 411, width, 411);
  //image(img, 0, 0);
  println(img.width, img.height);
  printBuckets();
  
  
  
  for(int i=0;i<640;i++){
    for(int j=0;j<410;j++) {
      color c = getColor(i, j);
      stroke(c);
      point(i,j);
    }
  }
  brushEnd.x = 0;
  brushEnd.y = 20;
  dist.x = brushEnd.x - brushStart.x;
  dist.y = brushEnd.y - brushStart.y;
  move();
  
  //ellipse(brush.x, brush.y, 10, 10);
  noLoop();
}

void move() {
 
  fill(0, 2);
  pct += step;
  if (pct < 1.0) {
    brushCurrent.x = brushStart.x + (pct * dist.x);
    brushCurrent.y = brushStart.y + (pow(pct, exponent) * dist.y);
  }
  fill(255);
  ellipse(brushCurrent.x, brushCurrent.y, 10, 10);
}

void printBuckets() {
  setGradient(60, 440, 40, 140, cred, red, Y_AXIS);
  setGradient(165, 560, 300, 40, cgreen, green, X_AXIS);
  setGradient(540, 440, 40, 140, cblue, blue, Y_AXIS);
  
}

void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }  
  else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}

PVector getRedShade(color c){
  float redshade = red(c);
  float x = 80;
  float y = 440 + 0.54 * redshade;
  return new PVector(x, y);
}

PVector getBlueShade(color c){
  float blueshade = blue(c);
  float x = 560;
  float y = 440 + 0.54 * blueshade;
  return new PVector(x, y);
}


PVector getGreenShade(color c){
  float greenshade = green(c);
  float x = 165 + 1.17 * greenshade;
  float y = 580;
  return new PVector(x, y);
}




color getColor(int x, int y) {
  color c = img.get(x, y);
  //println(red(c), green(c), blue(c));
  return c;
}
