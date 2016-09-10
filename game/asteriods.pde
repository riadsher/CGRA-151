import java.util.Random;

class asteriods{
 
  PVector center;
  PVector colour;
  PVector shape[];
  PVector speed;
  int size;
  
 asteriods(int s,PVector loc,PVector speed){
   center = loc; //<>//
   colour=new PVector(125,125,125);
     size = s;
   this.speed =speed;
   updateAster(); //<>//
   colour=new PVector(random(255),random(255),random(255));
 
   
 }

  void updateAster(){
     
    float R2 = Math.round(size/Math.sqrt(2));

    PVector pt[] = new PVector [8] ;
    float sign;
    if(random(5)>2.5)sign = -1;
    else sign = 1;
      
    pt[0] = new PVector();
    pt[0].x = center.x+(sign*random(size/4)); pt[0].y = center.y+(sign*random(size/4)) - size;
    
    if(random(5)>2.5)sign = -1;
    else sign = 1;
    pt[1] = new PVector();
    pt[1].x = center.x+(sign*random(size/4)) + R2 ;pt[1].y = center.y+(sign*random(size/4)) - R2;
    
    if(random(5)>2.5)sign = -1;
    else sign = 1;
    pt[2] = new PVector();
    pt[2].x = center.x+(sign*random(size/4)) + size; pt[2].y = center.y+(sign*random(size/4));
    
    if(random(5)>2.5)sign = -1;
    else sign = 1;
    pt[3] = new PVector();
    pt[3].x = center.x+(sign*random(size/4)) + R2; pt[3].y = center.y+(sign*random(size/4)) + R2;
    
    if(random(5)>2.5)sign = -1;
    else sign = 1;
    pt[4] = new PVector();
    pt[4].x = center.x+(sign*random(size/4)); pt[4].y = center.y+(sign*random(size/4)) + size;
    
    if(random(5)>2.5)sign = -1;
    else sign = 1;
    pt[5] = new PVector();
    pt[5].x = center.x+(sign*random(size/4)) - R2; pt[5].y = center.y+(sign*random(size/4)) + R2;
    
    if(random(5)>2.5)sign = -1;
    else sign = 1;
    pt[6] = new PVector();
    pt[6].x = center.x+(sign*random(size/4)) - size; pt[6].y = center.y+(sign*random(size/4));
    
    if(random(5)>2.5)sign = -1;
    else sign = 1;
    pt[7] = new PVector();
    pt[7].x = center.x+(sign*random(size/4)) - R2; pt[7].y = center.y+(sign*random(size/4)) - R2;
   
   shape = pt;
  } //<>//
  
 void asteriodDraw(){
   strokeWeight(3);
   stroke(colour.x,colour.y,colour.z);
   noFill();
  beginShape();
   for(PVector p : shape){
     vertex(p.x,p.y);
   }
   endShape(CLOSE);
  }
  
}