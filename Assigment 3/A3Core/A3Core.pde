import java.util.ArrayList;

ArrayList<PVector> points;
// there will be three extra points which will be the first three 
// so the thing is complete
int totalPoints = 12; 

PVector clickedOn;

float t =0.0;
float speed = 0.009;

void setup() {
  size(600, 600);
  points = new ArrayList<PVector>();
  buildSpline();
}

void buildSpline() {
  for (int i = 0; i<totalPoints; i++) {
    points.add(new PVector(random(20, width-20), random(20, height-20)));
  }
  points.add(points.get(0));
  points.add(points.get(1));
  points.add(points.get(2));
}

void draw() {
  background(255);
  //track / spline
  stroke(0,0,125);
  strokeWeight(2);
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
    rect(p.x-5, p.y-5, 10, 10);
  }
  // orange line showing connections of path
  beginShape();
  for (PVector p : points) {
   vertex(p.x, p.y);
  }
  endShape();
    
}

void mousePressed(){
  int error =10; 
  for(PVector p : points){
  if((mouseX < p.x+error && mouseX > p.x-error) && 
  (mouseY < p.y+error && mouseY > p.y-error)){
     clickedOn = p;
  }
   
  }
}

void mouseReleased(){
 clickedOn =null; 
}

void mouseDragged(){
  if(clickedOn!=null){
  clickedOn.x=mouseX;
  clickedOn.y=mouseY;
  }
}