void setup(){
size(800,600);
}

void draw(){
  background(0);
  drawRoad(new PVector(width/2,height/2));
}

void drawRoad(PVector point){
  PVector a = new PVector(750,550);
  PVector b = new PVector(50,550);
  strokeWeight(5);
  stroke(255);
  point(a.x,a.y);
  point(b.x,b.y);
}