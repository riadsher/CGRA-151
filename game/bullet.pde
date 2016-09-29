class bullet {

  PVector speed= new PVector(0, 0), loc;
  float angle, mag; 
  char type ='S';


  bullet(PVector loc, float angle, float mag) {
    type ='S';
    this.loc=loc; 
    turn(angle);
    chaSpeed(mag);
  }
  bullet(PVector loc, float angle, float mag,char Type) {
    type =Type;
    this.loc=loc; 
    turn(angle);
    chaSpeed(mag);
  }

  void Draw() {
    stroke(255);
    ellipse(loc.x, loc.y, 5, 5);
  }
  void move() {
    loc.x =(loc.x+speed.x);
    loc.y =(loc.y+speed.y);
  }


  void turn(float ang) {
    angle = ang;
    //speed = PVector.fromAngle(ang).mult(mag);
  }

  void chaSpeed(float spe) {
    mag = spe;
    speed = PVector.add(speed, PVector.fromAngle(angle).mult(mag));
  }

  boolean bounds() {
    if (loc.x>width || loc.x <0) return true;
    if (loc.y>height || loc.y <0 ) return true;
    return false;
  }
}

class Cluster extends bullet {

  int SIZE;
  Cluster(PVector loc, float angle, float mag, int size) {
    super(loc, angle, mag,'W');
    //type='W';
    SIZE=size;
  }

  void Draw() {
    stroke(4);
    fill(125, 0, 0);
    ellipse(loc.x, loc.y, 20, 20);
  }

  ArrayList<bullet> blast() {
    Rectangle2D bounds = new Rectangle2D.Float(loc.x, loc.y, 20, 20);
    ArrayList<bullet> babys  = new ArrayList<bullet>();
    if (SIZE>5) {
      for (int i =0; i< 8; i++) {
        if ((SIZE-5)>5) {
          //cluster
          babys.add(new Cluster(new PVector(random(Math.round(bounds.getMinX()), Math.round(bounds.getMaxX())), 
            random(Math.round(bounds.getMinY()), Math.round(bounds.getMaxY())) ), random(2*PI), random(mag, 2*mag), 20-10));
        } else {
          //none cluster
          babys.add(new bullet(new PVector(random(Math.round(bounds.getMinX()), Math.round(bounds.getMaxX())), 
            random(Math.round(bounds.getMinY()), Math.round(bounds.getMaxY())) ), random(2*PI), random(mag, 2*mag)));
        }
      }
    }

    return babys;
  }
}


class Wave extends bullet {

  ArrayList<ArrayList<PVector>> points; 
  int lastFrame=0;
  int index =0;
  boolean DEAD=false;

  Wave(PVector loc, float angle, float mag) {
    super(loc, angle, mag,'D');
    //type='D';
    points = new ArrayList<ArrayList<PVector>>() ;
    genPoints();
  }


  void Draw() {
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(angle+HALF_PI);

    stroke(255);
    ArrayList<PVector> temp = points.get(index%points.size());
    for (PVector p : temp) {
      point(p.x, p.y);
    }

    if (millis()-lastFrame>100) {
      lastFrame = millis();
      index = (index +1);
      if (index == points.size()){
       DEAD= true; 
      }
    }
    popMatrix();
  }



  void genPoints() {

    float ind =0; // the length of the steep
    for (ind=0; ind<4; ind+=1.0) {
      float totalStep = 30;
      float step = QUARTER_PI/totalStep;
      float rand = 30; // defines the width of the wave
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

  ArrayList<PVector> waveHit() {
    ArrayList<PVector> temp = new ArrayList<PVector>();
    for(PVector p : points.get(index%points.size())){
     PVector t = new PVector(p.x,p.y);
     t.rotate(angle+HALF_PI);
      t.add(loc);
     temp.add(t); 
      
    }
    return temp;
  }
}