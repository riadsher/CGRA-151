ArrayList<Ball> balls;

Rect Mouse;



void setup(){
  balls = new ArrayList<Ball>();
  balls.add(new Ball(30,10,40,3,2,0,2.1));
 
  
  size(300,600);
  frameRate(10);
 
  Mouse = new Rect(100,200,300);
}


void draw(){
  Mouse.update(mouseX,mouseY);
  
  background(0);
 fill(255);
  Mouse.drawRect();
  
  for(Ball t : balls){
    fill(0,0,125);
  t.drawBall();
  }
  for(Ball t : balls){
  Mouse.contact(t);
  }
  
   
  
}