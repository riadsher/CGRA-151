  import java.util.ArrayList;
  
  ArrayList<PVector> points;
  ArrayList<Car> cars;
  
  // there will be three extra points which will be the first three 
  // so the thing is complete
  int totalPoints = 12; 
  
  PVector clickedOn;
  
  int size =20;
  
  void setup() {
    frameRate(60);
    size(900, 900);
    points = new ArrayList<PVector>();
    cars = new ArrayList<Car>();
    Car temp = new Car();
    print("ID=");
    println(temp.ID);
     cars.add(temp);
     
    buildSpline();
  }
  
  void buildSpline() {
    for (int i = 0; i<totalPoints; i++) {
      points.add(new PVector(random(20+size, width-20-size), random(20+size, height-20-size)));
    }
    points.add(points.get(0));
    points.add(points.get(1));
    points.add(points.get(2));
  }
  
  void draw() {
    background(255);
    
    
    //track / spline edge
    stroke(0);
    strokeWeight(size+4);
    noFill();
    beginShape();
    for (PVector p : points) {
      curveVertex(p.x, p.y);
    }
    endShape();
    
    //track / spline ashfault
    stroke(100);
    strokeWeight(size);
    noFill();
    beginShape();
    for (PVector p : points) {
      curveVertex(p.x, p.y);
    }
    endShape();
  
    //nodes
    stroke(255, 133, 51);
    noFill();
    strokeWeight(1);
    for (PVector p : points) {
      rect(p.x-(size+5)/2, p.y-(size+5)/2, size+5, size+5);
    }
    // orange line showing connections of path
    beginShape();
    for (PVector p : points) {
      vertex(p.x, p.y);
    }
    endShape();
    // draws the cars
    for(Car c : cars){
     c.carDraw(); 
    }
    // collision detections
    for (int i=0;i<cars.size();i++){
      Car c = cars.get(i);
    for (int t=0;t<cars.size();t++){
        Car k = cars.get(t);
        if(c.ID!=k.ID && i!=t){ // so we exclude our self since we will alwasy be collision with our self
       c.detectCollision(k);
        }
      }
    }
    
  }
  
  void mousePressed() {
    if(mouseButton==RIGHT){
      Car temp = new Car();
    print("ID=");
    println(temp.ID);
     cars.add(temp);
     
    }
    int error =size+5; // error to give tolorince to user
    for (PVector p : points) {
      if ((mouseX < p.x+error && mouseX > p.x-error) && 
        (mouseY < p.y+error && mouseY > p.y-error)) {
        clickedOn = p;
      }
    }
  }
  
  void mouseReleased() {
    clickedOn =null;
  }
  
  void mouseDragged() {
    if (clickedOn!=null) {
      clickedOn.x=mouseX;
      clickedOn.y=mouseY;
    }
  }
  
  void mouseWheel(MouseEvent e){
    float differince = e.getCount();
     for(Car c : cars){
     c.changeSpeed(-differince); 
    }
    
    
    
    
  }