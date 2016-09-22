class bullet {

  PVector speed= new PVector(0,0), loc;
  float angle, mag; 
  char type ='N';


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

class Cluster extends bullet{

   int SIZE;
  Cluster(PVector loc, float angle, float mag,int size) {
   super(loc, angle,mag);
   type='C';
   SIZE=size;
  }
  
  void Draw() {
    fill(125,0,0);
    ellipse(loc.x, loc.y, 20, 20);
  }
  
  ArrayList<bullet> blast(){
      Rectangle2D bounds = new Rectangle2D.Float(loc.x,loc.y,20,20);
    ArrayList<bullet> babys  = new ArrayList<bullet>();
    if (SIZE>5) {
      for (int i =0; i< 8; i++) {
        if((SIZE-5)>5){
          //cluster
           babys.add(new Cluster(new PVector(random(Math.round(bounds.getMinX()), Math.round(bounds.getMaxX())),
          random(Math.round(bounds.getMinY()), Math.round(bounds.getMaxY())) ),random(2*PI),random(mag, 2*mag),20-10));
        }else{
          //none cluster
          babys.add(new bullet(new PVector(random(Math.round(bounds.getMinX()), Math.round(bounds.getMaxX())),
          random(Math.round(bounds.getMinY()), Math.round(bounds.getMaxY())) ),random(2*PI),random(mag, 2*mag)));
        }
          
      }
    }
    
    return babys;
  }
  
  
}