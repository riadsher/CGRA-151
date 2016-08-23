PVector _poly[] ; //<>// //<>//
PVector _line [];
PVector clickedOn=null;

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
  background(0);
  drawPolygon();
  drawLine(); 

  drawPoints();
}

void mousePressed() {
  int error = 20;
  for (PVector p : _poly) {
    if ((mouseX < p.x+error && mouseX > p.x-error) && 
      (mouseY < p.y+error && mouseY > p.y-error)) {
      clickedOn = p;
    }
  }
   for (PVector p : _line) {
    if ((mouseX < p.x+error && mouseX > p.x-error) && 
      (mouseY < p.y+error && mouseY > p.y-error)) {
      clickedOn = p;
    }
  }
}
void mouseReleased() {
  clickedOn =null;
}


void mouseDragged() {
  if (clickedOn!=null) {
    clickedOn.x=mouseX;
    clickedOn.y=mouseY;
  }
}
void drawPoints() {
  strokeWeight(6);
  stroke(67, 130, 64);
  beginShape(POINTS);
  for (PVector p : _poly) {
    vertex(p.x, p.y);
  }
  endShape();
  stroke(0, 94, 255);
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
  PVector a = _line[0];
  PVector b = _line[1];
  PVector D = PVector.sub(b, a);
  PVector p1 = PVector.add(a, PVector.mult(D, -100));
  PVector p2 = PVector.add(a, PVector.mult(D, 100));
  line(p1.x, p1.y, p2.x, p2.y);
}