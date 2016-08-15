  import java.awt.geom.*;
    
    class Car {
      int ID;
      PVector current;
      PVector direction;
      float t =0.0;
      float speed = 0.005;
      int segment= 0;
      int size=20;
    
      boolean STOP = false;
      boolean SLOW = false;
     
      Car(){
        ID=int(random(0,Integer.MAX_VALUE)); 
      }
      
      void carDraw() {
      
    
        pushMatrix();
        PVector point = findpoint(t, segment);
        PVector tangent = findTangentLine(t, segment);
        translate(point.x, point.y);
        rotate(atan2(tangent.y, tangent.x));
        carPoly();
    
        translate(-point.x, -point.y);
        rotate(-atan2(tangent.y, tangent.x));
        current = point;
        direction = tangent.normalize();
        if(!STOP){
          if(SLOW){
           t+=speed /10 ; 
          }else {
        t+=speed;
          }
        }
        if (t>=1.0) {
          t=0.0;
          segment++;
          segment = segment%(points.size()-3);
        }
        popMatrix();
       
       PVector Center = PVector.add(current,PVector.mult(direction,30));
       Rectangle2D.Float box;
       box = new Rectangle2D.Float(Center.x-((size+10)/2),Center.y-(size/2),size+10,size);
       rect(box.x,box.y,box.width,box.height);
       rect(current.x-((size+10)/2),current.y-(size/2),size+10,size);
       PVector second = PVector.add(current,PVector.mult(direction,50));
       Rectangle2D.Float secondBox;
       secondBox = new Rectangle2D.Float(second.x-((2*size+10)/2),second.y-((2*size)/2),(2*size)+10,2*size);
       rect(secondBox.x,secondBox.y,secondBox.width,secondBox.height);
      }
    
      void changeSpeed(float amount){
        speed = speed+(0.005*amount);
        if(speed < 0.005){
          speed =0.005;
        }
        if(speed > 0.15){
          speed=0.15;
        }
        
      }
    
    
    
      PVector findTangentLine(float t, int index) {
    
        float xTangent = curveTangent(points.get(index%points.size()).x, points.get((index+1)%points.size()).x, 
          points.get((index+2)%points.size()).x, points.get((index+3)%points.size()).x, t);
        float yTangent = curveTangent(points.get(index%points.size()).y, points.get((index+1)%points.size()).y, 
          points.get((index+2)%points.size()).y, points.get((index+3)%points.size()).y, t); 
        return new PVector(xTangent, yTangent);
      }
    
      PVector findpoint(float t, int index) {
        float x = curvePoint(points.get(index%points.size()).x, points.get((index+1)%points.size()).x, 
          points.get((index+2)%points.size()).x, points.get((index+3)%points.size()).x, t);
        float y = curvePoint(points.get(index%points.size()).y, points.get((index+1)%points.size()).y, 
          points.get((index+2)%points.size()).y, points.get((index+3)%points.size()).y, t);
    
        return new PVector(x, y);
      }
    
     void detectCollision(Car other){
      
       PVector Center = PVector.add(current,PVector.mult(direction,30));
       Rectangle2D.Float inFront;
       Rectangle2D.Float Me;
       
       inFront = new Rectangle2D.Float(Center.x-(20/2),Center.y-(20/2),20,20);
       Me = new Rectangle2D.Float(current.x-(20/2),current.y-(20/2),20,20);
       
       float angle = PVector.angleBetween(direction,other.direction);
       
       boolean StopBox=inFront.intersects(other.current.x-((size+10)/2),other.current.y-(size/2),size+10,size) || 
       Me.intersects(other.current.x-((size+10)/2),other.current.y-(size/2),size+10,size);
       
       if(StopBox){
         print("ID=");
         print(ID);
         print(" angle ");
         println(degrees(angle));
         STOP= true;
       }if(STOP && !StopBox){
         STOP = false;
       }
       
       PVector second = PVector.add(current,PVector.mult(direction,50));
       Rectangle2D.Float secondBox;
       secondBox = new Rectangle2D.Float(second.x-((2*size+10)/2),second.y-((2*size)/2),(2*size)+10,2*size);
        
        boolean slowBox = secondBox.intersects(other.current.x-((size+10)/2),other.current.y-(size/2),size+10,size);
       
       if(slowBox){
         
       }
       
     }
    
    
      void triangle() {
        fill(255, 0, 0);
        beginShape();
        vertex(0, 0);
        vertex(-5, -5);
        vertex(15, 0);
        vertex(-5, 5);
        endShape(CLOSE);
      }
    
      void carPoly() {
        noStroke();
    
        //top backwheel
        fill(0);
        beginShape();
        vertex(-6, -8.75);
        vertex(-6, -6.25);
        vertex(-2, -6.25);
        vertex(-2, -8.75);
        endShape(CLOSE);
    
        // top front
        fill(0);
        beginShape();
        vertex(2, -8.75);
        vertex(2, -6.25);
        vertex(6, -6.25);
        vertex(6, -8.75);
        endShape(CLOSE);
    
        //bottom backwheel
        fill(0);
        beginShape();
        vertex(-6, 6.25);
        vertex(-6, 8.75);
        vertex(-2, 8.75);
        vertex(-2, 6.25);
        endShape(CLOSE);
    
        // bottom front
        fill(0);
        beginShape();
        vertex(2, 6.25);
        vertex(2, 8.75);
        vertex(6, 8.75);
        vertex(6, 6.25);
        endShape(CLOSE);
    
        //body
        fill(255, 0, 0);
        beginShape();
        vertex(-8, -6.25);
        vertex(-8, 6.25);
        vertex(8, 6.25);
        vertex(8, -6.25);
        endShape(CLOSE);
    
        //windscreen
        fill(0, 0, 255);
        beginShape();
        vertex(5.5, -5.25);
        vertex(5.5, 5.25);
        vertex(0.5, 5.25);
        vertex(0.5, -5.25);
        endShape(CLOSE);
    
        //bonet
        strokeWeight(1);
        stroke(0);
        noFill();
        beginShape();
        vertex(5.5, -5.25);
        vertex(5.5, 5.25);
        vertex(7.5, 5.25);
        vertex(7.5, -5.25);
        endShape(CLOSE);
    
        //Backend
        strokeWeight(1);
        stroke(0);
        noFill();
        beginShape();
        vertex(0.5, -5.25);
        vertex(0.5, 5.25);
        vertex(-7.5, 5.25);
        vertex(-7.5, -5.25);
        endShape(CLOSE);
      }
    }