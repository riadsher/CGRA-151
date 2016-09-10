class ship{
 
  PVector loc;
  PVector speed = new PVector(0,0);
  float ang;
  float mag;
  
  
  ship(PVector location, float angle,float spe){
    loc=location;
    ang =angle;
    chaSpeed(spe);
    turn(ang);
  }
    
   void shipDraw(){
     strokeWeight(2);
     stroke(255);
     noFill();
     pushMatrix();
       
     translate(loc.x,loc.y);
     rotate(PI/2+ang);
     beginShape();
     vertex(0,-25);
     vertex(10,10);
     vertex(0,0);
     vertex(-10,10);
     endShape(CLOSE);
     popMatrix();
     
     
   }
  
  PVector fire(){
    
   return PVector.fromAngle(ang); 
  }
  
  void move(){
    //loc = loc.add(speed);
    loc.x =(loc.x+speed.x)%width;
    loc.y =(loc.y+speed.y)%(height+25);
    
    if(loc.x<-10)loc.x=width;
    if(loc.y<-25)loc.y=(height+25);
  
  }
  
   void turn(float angle){
    ang = angle;
    //speed = PVector.fromAngle(ang).mult(mag);
  }
  
  void chaSpeed(float spe){
    mag = spe;
    speed = PVector.add(speed,PVector.fromAngle(ang).mult(mag));
  }
  
}