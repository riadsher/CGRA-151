float x1=50,y1=50,x2=250,y2=50,x3=250,y3=250,x4=50,y4=250;
void setup() {
 size(300, 300) ;
 frameRate(60);
}
float t =0.0;
float speed = 0.009;
void draw() {
 background(255);
 stroke(0);
 noFill();
 strokeWeight(20);
 bezier(x1, y1, x2, y2, x3, y3, x4, y4);
 strokeWeight(1);
 PVector point = findpoint(t);
 PVector tangent = findTangentLine(t);
 translate(point.x,point.y);
 rotate(atan2(tangent.y,tangent.x));
  triangle();
 stroke(255,0,0);
 line(0,0,100,0);
  translate(-point.x,-point.y);
 rotate(atan2(-tangent.y,-tangent.x));
  t+=speed;
  if(t>=1.0)t=0.0;
}

PVector findTangentLine(float t){
 float xTangent = bezierTangent(x1, x2, x3, x4, t);
float yTangent = bezierTangent(y1, y2, y3, y4, t); 
  return new PVector(xTangent,yTangent);
}

PVector findpoint(float t){
 float x = bezierPoint(x1,x2,x3,x4,t);
 float y = bezierPoint(y1,y2,y3,y4,t);
 
 return new PVector(x,y);
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