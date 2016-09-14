import java.awt.geom.Rectangle2D;

class Bonus{
  
  PVector loc;
  PVector speed = new PVector(0,0);  
  PFont font;
  char current;
  char type[] = new char[] {'L','T','F'};
  
  
  
  Bonus(PVector loc){
    this.loc = loc;
    font =  loadFont("Stencil-100.vlw");
    current = type[0];
  }
  
  void Draw(){
    noFill();
    stroke(255);
     textFont(font,23);
     textAlign(CENTER);
    strokeWeight(3);
    rect(loc.x-12,loc.y-12,24,24,5);
    fill(255);
     text(current, loc.x,loc.y+8 );
  }
  
  boolean contact(ship p){
    
    Rectangle2D.Float box = new Rectangle2D.Float(loc.x-12,loc.y-12,24,24);
   return p.Collison(new Polygon2D(box)); 
    
  }
  
}