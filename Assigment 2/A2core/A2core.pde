Ball balls;


void setup(){
  balls = new Ball(20,20,40,6,6,0,2.1);
  size(300,600);
  frameRate(60);
  
}


void draw(){
  background(0);
  balls.drawBall();
  
  
  
}