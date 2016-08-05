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
  stroke(0);
  strokeWeight(10);
  noFill();

  beginShape();
  for (PVector p : points) {
    curveVertex(p.x, p.y);
  }
  endShape();
  
  //nodes
  stroke(0, 200, 100);
  noFill();
  strokeWeight(5);
  for (PVector p : points) {
    ellipse(p.x, p.y, 10, 10);
  }
  PVector point = findpoint(t);
 PVector tangent = findTangentLine(t);
    
}

PVector findTangentLine(float t,int index){
  
 float xTangent = curveTangent(points.get(index%points.size()).x, points.get((index+1)%points.size()).x,
     points.get((index+2)%points.size()).x, points.get((index+3)%points.size()).x, t);
float yTangent = curveTangent(points.get(index%points.size()).y, points.get((index+1)%points.size()).y,
     points.get((index+2)%points.size()).y, points.get((index+3)%points.size()).y, t); 
  return new PVector(xTangent,yTangent);
}

PVector findpoint(float t, int index){
 float x = curvePoint(points.get(index%points.size()).x, points.get((index+1)%points.size()).x,
     points.get((index+2)%points.size()).x, points.get((index+3)%points.size()).x, t);
 float y = curvePoint(points.get(index%points.size()).y, points.get((index+1)%points.size()).y,
     points.get((index+2)%points.size()).y, points.get((index+3)%points.size()).y, t);
 
 return new PVector(x,y);
}


void mousePressed(){
  for(PVector p : points){
  if((mouseX < p.x+5 && mouseX > p.x-5) && 
  (mouseY < p.y+5 && mouseY > p.y-5)){
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


void triangle(){
  fill(255,0,0);
beginShape();
 vertex(0,0);
 vertex(-10,-10);
 vertex(30,0);
 vertex(-10,10);
endShape(CLOSE);
}