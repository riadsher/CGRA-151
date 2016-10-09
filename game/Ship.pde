class ship { //<>//
  //location speed angle and level of speed
  PVector loc;
  PVector speed = new PVector(0, 0);
  float ang;
  float mag;


  // when last did we fire
  int lastFire=0;

  // special weapons count
  int Wave = 3;
  int laserBlast =5000;
  int ClusterBomb = 3;
  // is the laser being fired
  boolean laser=false; 

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
  // firing a normal bullet
  bullet fire() {
    // laser is so that you can't fire when you are usin the laser
    if (!laser&&(millis()-lastFire)>100) {

      PVector bultLoc = PVector.add(loc, PVector.fromAngle(ang).mult(25));
      lastFire=millis();
      return new bullet(bultLoc, ang, 8.0);
    } else {
      return null;
    }
  }

  //firing a clusterbomb
  Cluster DropBomb() {
    // so the check goes in the keypressed event area and teh time check goes over here
    if ((millis()-lastFire)>500) {
      PVector bultLoc = PVector.add(loc, PVector.fromAngle(ang).mult(25));
      ClusterBomb--;
      lastFire=millis();
      return new Cluster(bultLoc, ang, 8.0, 20);
    } else {
      return null;
    }
  }
  //fire a wave attack
  Wave FireWave() {
    // checking you have a Wave attack and if you have fired soemthing in a certain amount of time
    if (Wave>0&&(millis()-lastFire)>400) {
      PVector bultLoc = PVector.add(loc, PVector.fromAngle(ang).mult(25));
      Wave--;
      return new Wave(bultLoc, ang, 8.0);
    } else {
      return null;
    }
  }
  //move functin with loop around added
  void move() {
    //loc = loc.add(speed);
    loc.x =(loc.x+speed.x)%(width+10);
    loc.y =(loc.y+speed.y)%(height+25);

    if (loc.x<-10)loc.x=width+10;
    if (loc.y<-25)loc.y=(height+25);
  }
  // turning
  void turn(float angle) {
    ang = angle;
  }
  //so this has some weird maths because the turning is including momentum if you will
  void chaSpeed(float spe) {

    mag = spe;

    speed = PVector.add(speed, PVector.fromAngle(ang).mult(mag));

    if (speed.mag()>5) {
      speed.normalize();
      speed.mult(2);
    }
  }
  //detecting collsion by match polygones and getting areas
  boolean Collison(Polygon2D other) {

    Polygon2D poly = getPolygon();
    Area otherArea = new Area(other);
    Area area = new Area(poly);
    area.intersect(otherArea);
    return !area.isEmpty();
  }
  // gets polygon that definds teh shape of the  object
  Polygon2D getPolygon() {
    Polygon2D poly = new Polygon2D(); 
    poly.addPoint(loc.x+0, loc.y+(-25));
    poly.addPoint(loc.x+10, loc.y+10);
    poly.addPoint(loc.x+0, loc.y+0);
    poly.addPoint(loc.x+(-10), loc.y+-10);
    return poly;
  }
  //firing a LASER 
  void FireLASER() {
    // checking to see if you can use the laser
    if (laserBlast>0) {
      // just so you don't spew bulltes everywere
      if (!laser) {
        lastFire = millis();
      }
      laser =true;

      strokeWeight(5);
      stroke(255);
      pushMatrix();
      translate(loc.x, loc.y);
      rotate(HALF_PI+ang);
      line(0, -28, 0, -2*height);
      popMatrix();
      if (millis()-lastFire>laserBlast) {
        laser=false;
        laserBlast=0;
      }
    }
  }


  // adding bonus to the player
  void addBonus(char p) {
    if (p == 'A' ) {
      laserBlast+=5000;
    } else if (p=='W') {
      ClusterBomb+=3;
    } else if (p=='D') {
      Wave+=1;
    }
  }
}