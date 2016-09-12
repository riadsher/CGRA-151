class ship {

  PVector loc;
  PVector speed = new PVector(0, 0);
  float ang;
  float mag;


  ship(PVector location, float angle, float spe) {
    loc=location;
    chaSpeed(spe);
    turn(angle);
  }

  void Draw() {
    strokeWeight(2);
    stroke(255);
    noFill();
    pushMatrix();

    translate(loc.x, loc.y);
    rotate(PI/2+ang);
    beginShape();
    vertex(0, -25);
    vertex(10, 10);
    vertex(0, 0);
    vertex(-10, 10);
    endShape(CLOSE);
    popMatrix();
  }

  bullet fire() {
    PVector bultLoc = PVector.add(loc, PVector.fromAngle(ang).mult(25));
    return new bullet(bultLoc,ang,6.0);
  }

  void move() {
    //loc = loc.add(speed);
    loc.x =(loc.x+speed.x)%(width+10);
    loc.y =(loc.y+speed.y)%(height+25);

    if (loc.x<-10)loc.x=width+10;
    if (loc.y<-25)loc.y=(height+25);
  }

  void turn(float angle) {
    ang = angle;
    }

  void chaSpeed(float spe) {
    mag = spe;
    speed = PVector.add(speed, PVector.fromAngle(ang).mult(mag));
  }
  
  boolean Collison(Polygon2D other) {

    Polygon2D poly = getPolygon();
    Area otherArea = new Area(other);
    Area area = new Area(poly);
    area.intersect(otherArea);
    return !area.isEmpty();
  }

  Polygon2D getPolygon() {
    Polygon2D poly = new Polygon2D(); 
    poly.addPoint(loc.x+0, loc.y+(-25));
    poly.addPoint(loc.x+10, loc.y+10);
    poly.addPoint(loc.x+0, loc.y+0);
    poly.addPoint(loc.x+(-10),loc.y+-10);
    return poly;
  }
}