class ship { //<>//

  PVector loc;
  PVector speed = new PVector(0, 0);
  float ang;
  float mag;

  ArrayList<ArrayList<PVector>> points; 

  int lastFire=0;

  int laserBlast =5000;
  int ClusterBomb = 3;

  boolean laser=false; 

  ship(PVector location, float angle, float spe) {
    loc=location;
    chaSpeed(spe);
    turn(angle);

    points = new ArrayList<ArrayList<PVector>>() ;
    genPoints();
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
    if (!laser&&(millis()-lastFire)>100) {
      PVector bultLoc = PVector.add(loc, PVector.fromAngle(ang).mult(25));

      lastFire=millis();
      return new bullet(bultLoc, ang, 8.0);
    } else {
      return null;
    }
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

    if (speed.mag()>5) {
      speed.normalize();
      speed.mult(2);
    }
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
    poly.addPoint(loc.x+(-10), loc.y+-10);
    return poly;
  }

  void FireLASER() {
    //println(laserBlast);
    if (laserBlast>0) {
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

  Cluster DropBomb() {
    if ((millis()-lastFire)>100) {
      PVector bultLoc = PVector.add(loc, PVector.fromAngle(ang).mult(25));
      ClusterBomb--;
      lastFire=millis();
      return new Cluster(bultLoc, ang, 8.0, 20);
    } else {
      return null;
    }
  }

  void addBonus(char p) {
    if (p == 'L' ) {
      laserBlast+=5000;
    } else if (p=='C') {
      ClusterBomb+=3;
    }
  }


  int lastFrame=0;
  int index =0;

  void fireWave() {
    translate(loc.x, loc.y);
    rotate(ang+HALF_PI);

    stroke(255);
    ArrayList<PVector> temp = points.get(index);
    for(PVector p: temp){
     point(p.x,p.y); 
    }
    
    if (millis()-lastFrame>100) {
      lastFrame = millis();
      index = (index +1);
    }
  }

  void genPoints() {

    int ind =0;
    for (ind=0; ind<20; ind++) {
      float totalStep = 40;
      float step = QUARTER_PI/totalStep;
      float rand = 10;
      ArrayList<PVector> temp = new ArrayList<PVector>();
      for (int K=0; K<totalStep; K++) {
        float xt = 0 + (ind*rand)*(cos(QUARTER_PI+(step*K)));
        float yt = 0 - (ind*rand)*(sin(QUARTER_PI+(step*K)));
        temp.add(new PVector(xt, yt));
        xt = 0 + (ind*rand)*(cos(HALF_PI+(step*K)));
        yt = 0 - (ind*rand)*(sin(HALF_PI+(step*K)));
        temp.add(new PVector(xt, yt));
      } 
      points.add(temp);
    }
  }
  
  ArrayList<PVector> waveHit(){
   return points.get(index); 
  }
}