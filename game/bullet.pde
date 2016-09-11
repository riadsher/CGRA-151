class bullet {

  PVector speed= new PVector(0,0), loc;
  float angle, mag; 



  bullet(PVector loc, float angle, float mag) {

    this.loc=loc; 
       turn(angle);
    chaSpeed(mag);
 
  }

  void Draw() {
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
  
  boolean bounds(){
   if(loc.x>width || loc.x <0) return true;
   if(loc.y>height || loc.y <0 ) return true;
   return false;
  }
}