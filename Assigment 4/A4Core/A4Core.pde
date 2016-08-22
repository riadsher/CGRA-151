PVector _poly[] ;
PVector _line [];


void setup() {
  _poly = new PVector[] { 
    new PVector(50, 250), new PVector(150, 200), 
    new PVector(250, 250), new PVector(150, 50), 
    new PVector(50, 250)
  };

  _line = new PVector[] {new PVector(225, 50), new PVector(225, 250)};
  size(300, 300);
}

void draw() {
  drawPolygon();
  drawLine(); 

  drawPoints();
}

void drawPoints() {
  strokeWeight(5);
  stroke(0, 100, 0);
  beginShape(POINTS);
  for (PVector p : _poly) {
    vertex(p.x, p.y);
  }
  endShape();
  stroke(255, 165, 0);
  beginShape(POINTS);
  for (PVector l : _line) {
    vertex(l.x, l.y);
  }
  endShape();
}

void drawPolygon() {
  strokeWeight(1);
  stroke(0, 100, 0);
  beginShape();
  for (PVector p : _poly) {
    vertex(p.x, p.y);
  }
  endShape();
}

void drawLine() {
  strokeWeight(3);
  stroke(255, 165, 0);
   PVector points [] = checkOctant();
  line(points[0].x, points[0].y, points[1].x, points[1].y);
}


PVector [] checkOctant(){
  
}

PVector[] calLine(float M1X, float M1Y, float M2X, float M2Y) {

  float m = (M2Y-M1Y)/(M2X-M1X);

  if (Float.isInfinite(m)) {
    m=0.0f;
  }

  float c =  M2Y-(m*M2X);
  // y= mx+c
  //(y-c)/m= x
  print("m= ");
  print(m);
  print(" c= ");
  println(c);
  float x0, x1;

  x0 = (0/m)-c;
  x1 = (height/m)-c;

  print("x0= ");
  print(x0);
  print(" x1= ");
  println(x1);

  return new PVector [] {new PVector(x0, 0), new PVector(x1, height)};
}