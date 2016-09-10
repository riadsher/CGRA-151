import java.awt.event.KeyEvent;

asteriods one;
ship player;


void setup(){
  size(300,300);
 one = new asteriods(125,new PVector(width/2,height/2),new PVector(0,0)); //<>//
 player = new ship(new PVector(width/2,height/2),-PI/2,0);

 frameRate(60);
}

void draw(){
  background(0);
  player.move();
  player.shipDraw();
}

void keyPressed(){
  if(key==CODED){
 if(keyCode==DOWN){
    player.chaSpeed(-0.5);  //<>//

 }
 if(keyCode==UP){
   player.chaSpeed(+0.5);
 }
  if(keyCode==LEFT){
    float angle= degrees(player.ang);
    angle=angle-5;
    angle = radians(angle);
   player.turn(angle);
 }
  if(keyCode==RIGHT){
  float angle= degrees(player.ang);
    angle=angle+5;
    angle = radians(angle);
   player.turn(angle);
 }
 
  }
  if(key==' '){
   player.fire(); 
    
  }
   
  
  
}