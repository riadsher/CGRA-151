import java.util.ArrayList;

ArrayList<PVector> points;
ArrayList<Car> cars;

// there will be three extra points which will be the first three 
// so the thing is complete
int totalPoints = 12; 

PVector clickedOn;

int size =20;

void setup() {
  frameRate(60);
  size(600, 600);
  points = new ArrayList<PVector>();
  cars = new ArrayList<Car>();
   cars.add(new Car());
  buildSpline();
}

void buildSpline() {
  for (int i = 0; i<totalPoints; i++) {
    points.add(new PVector(random(20+size, width-20-size), random(20+size, height-20-size)));
  }
  points.add(points.get(0));
  points.add(points.get(1));
  points.add(points.get(2));
}

void draw() {
  background(255);
  
  
  //track / spline edge
  stroke(0);
  strokeWeight(size+4);
  noFill();
  beginShape();
  for (PVector p : points) {
    curveVertex(p.x, p.y);
  }
  endShape();
  
  //track / spline ashfault
  stroke(100);
  strokeWeight(size);
  noFill();
  beginShape();
  for (PVector p : points) {
    curveVertex(p.x, p.y);
  }
  endShape();

  //nodes
  stroke(255, 133, 51);
  noFill();
  strokeWeight(1);
  for (PVector p : points) {
    rect(p.x-(size+5)/2, p.y-(size+5)/2, size+5, size+5);
  }

  beginShape();
  for (PVector p : points) {
    vertex(p.x, p.y);
  }
  endShape();
  for(Car c : cars){
   c.carDraw(); 
  }
  
}

void mousePressed() {
  if(mouseButton==RIGHT){
   cars.add(new Car()); 
  }
  int error =size+5;
  for (PVector p : points) {
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

void mouseWheel(MouseEvent e){
  float differince = e.getCount();
   for(Car c : cars){
   c.changeSpeed(-differince); 
  }
  
  
  
  
}