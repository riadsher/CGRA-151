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

  Car() {
    //just so we cant ell the diffeence betwen each car
    ID=int(random(0, Integer.MAX_VALUE));
  }

  void carDraw() {


    pushMatrix();
    //work out the position and direction
    PVector point = findpoint(t, segment);
    PVector tangent = findTangentLine(t, segment);
    //appling the posiotn and direction
    translate(point.x, point.y);
    rotate(atan2(tangent.y, tangent.x));
    
    
    carPoly();

    //undoing the move and roataion
    translate(-point.x, -point.y);
    rotate(-atan2(tangent.y, tangent.x));
    
    //recording for use at a different point
    current = point;
    direction = tangent.normalize();
    
     popMatrix();

    // workingout and creating the boxes of detection. 
    Rectangle2D.Float me = bounds();
     Rectangle2D.Float box = firstBox();   
     Rectangle2D.Float secondBox= secondBox();
   

    rect(box.x, box.y, box.width, box.height);
    if(STOP){// so we can see its stoped
      fill(125,0,0,125);
    }
      rect(me.x,me.y,me.width,me.height);
     rect(box.x,box.y,box.width,box.height);
   
   
    if(SLOW){ // so we know that it has been fired off 
    fill(0,0,125,125);
    }
    rect(secondBox.x, secondBox.y, secondBox.width, secondBox.height);
    
    
    // changing the speed to avoid collisions
      // increment teh posiont
    if (!STOP) {
      if (SLOW) {
        t+=speed /10 ;
      } else {
        t+=speed;
      }
    }
    
    
    // catch to see if you are over that segment.
    if (t>=1.0) {
      t=0.0;
      segment++;
      segment = segment%(points.size()-3);
    }
   
  
  }


  //changes teh speed at which the move on the line
  void changeSpeed(float amount) {
    speed = speed+(0.005*amount);
    if (speed < 0.001) {
      speed =0.001;
    }
    if (speed > 0.15) {
      speed=0.15;
    }
  }

  Rectangle2D.Float firstBox(){
  PVector Center = PVector.add(current, PVector.mult(direction, 30));
  return  new Rectangle2D.Float(Center.x-((size+10)/2), Center.y-(size/2), size+10, size);
}
  
  Rectangle2D.Float secondBox(){
     PVector second = PVector.add(current, PVector.mult(direction, 50));
     return new Rectangle2D.Float(second.x-((2*size+10)/2), second.y-((2*size)/2), (2*size)+10, 2*size);
  }
  
  Rectangle2D.Float bounds (){
    return new Rectangle2D.Float(current.x-((size+10)/2), current.y-(size/2), size+10, size);
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

  void detectCollision(Car other) {


    Rectangle2D.Float inFront = firstBox(); // the one directly in front should fire off if its about to HIT soemthing and stop the car
    Rectangle2D.Float Me = bounds(); //should fire off if we are in a collison.


    float angle = PVector.angleBetween(direction, other.direction);
    // were we use teh above to work out do we need to do anything
    // we look to see if the other car is in the the boxes if yes then do something
    Rectangle2D.Float them = other.bounds();
    boolean StopBox=inFront.intersects(them.x,them.y,them.width,them.height) || 
      Me.intersects(them.x,them.y,them.width,them.height);

    if (StopBox) {
      print("STOP ");
      print("ID=");
      print(ID);
      print(" angle ");
      println(degrees(angle));
      STOP= true;
    }
    if (STOP && !StopBox) {
      STOP = false;
    }
    // used for checking if we need to slow down to help avoid collisons.
    Rectangle2D.Float secondBox = secondBox();
    

    boolean slowBox = secondBox.intersects(them.x,them.y,them.width,them.height);

    if (slowBox) {
      print("SLOW ");
      print("ID=");
      print(ID);
      print(" angle ");
      println(degrees(angle));
      SLOW= true;
    }
    if (SLOW && !slowBox) {
      SLOW= false;
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