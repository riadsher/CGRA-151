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
  stroke(0, 100, 0);
  drawPolygon(_poly);
  drawLine();
  stroke(67, 130, 64);
  drawPoints(_poly);
  stroke(0, 94, 255);
  drawPoints(_line);
  stroke(255,0,0);
  noFill();
  PVector clip[] = clipPolygon(_poly, _line);
  drawPolygon(clip);
  stroke(0,0,200);
  drawPoints(clip);
  
  
  
  
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
void drawPoints(PVector poly[]) {
  strokeWeight(6);
  
  beginShape(POINTS);
  for (PVector p : poly) {
    vertex(p.x, p.y);
  }
  endShape();
  
}

void drawPolygon(PVector poly[]) {
  strokeWeight(1);
  
  beginShape();
  for (PVector p : poly) {
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