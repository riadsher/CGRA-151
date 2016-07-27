ArrayList<Ball> balls;

Rect Mouse;



void setup(){
  balls = new ArrayList<Ball>();
  balls.add(new Ball(30,10,40,3,2,0,2.1));
  balls.add(new Ball(20,20,40,3,2,0,2.1));
  
  size(300,600);
  frameRate(60);
 
  Mouse = new Rect(100,200,300);
}


void draw(){
  Mouse.update(mouseX,mouseY);
  
  background(0);
  for(Ball t : balls){
  t.drawBall();
  }
  Mouse.drawRect();
  for(Ball t : balls){
  Mouse.contact(t);
  }
  
}