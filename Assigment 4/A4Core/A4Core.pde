
PVector _poly[] ;
PVector _line [];
PVector clickedOn=null;

void setup() {
  //Polygon that you are modifing
  _poly = new PVector[] { 
    new PVector(50, 250), new PVector(150, 200), 
    new PVector(250, 250), new PVector(150, 50)
  };
  //The Point of the Line on the screen
  _line = new PVector[] {new PVector(125, 150)};
  size(300, 300);
}

void draw() {
  background(0);
  stroke(0, 100, 0);
  noFill();
  // drawing the polygon that is not modifide
  drawPolygon(_poly);
  //drawing the cut line
  drawLine();
  stroke(67, 130, 64);
  //drawing the Points for the polygon
  drawPoints(_poly);
  stroke(0, 94, 255);
  //drawing the points for the line.
  drawPoints(_line);
  stroke(255,0,0);
  fill(255,0,0,50);
  // creating the clipped Polygon
  PVector clip[] = clipPolygon(_poly, new PVector [] {
    // creating the line from the point same as the line..
    new PVector(_line[0].x,_line[0].y+50),
    new PVector(_line[0].x,_line[0].y-50)
  }
  );
  // drawing the clipped polygon
  drawPolygon(clip);
  stroke(0,0,200);
  //drawing the clipped polygons points
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
//Draws the points of a Polygon
void drawPoints(PVector poly[]) {
  strokeWeight(6);
  
  beginShape(POINTS);
  for (PVector p : poly) {
    vertex(p.x, p.y);
  }
  endShape();
  
}

//Draws the polygon
void drawPolygon(PVector poly[]) {
  strokeWeight(1);
  
  beginShape();
  for (PVector p : poly) {
    vertex(p.x, p.y);
  }
  endShape(CLOSE);
}

//draws the cut line
void drawLine() {
  strokeWeight(3);
  stroke(255, 165, 0);
  PVector a = new PVector(_line[0].x,_line[0].y+50);
  PVector b = new PVector(_line[0].x,_line[0].y-50);
  PVector D = PVector.sub(b, a);
  PVector p1 = PVector.add(a, PVector.mult(D, -100));
  PVector p2 = PVector.add(a, PVector.mult(D, 100));
  line(p1.x, p1.y, p2.x, p2.y);
}