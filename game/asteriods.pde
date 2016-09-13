import java.util.Random; //<>// //<>// //<>//
import java.awt.Polygon;
import java.awt.geom.Area;
import java.awt.geom.Rectangle2D;

class asteriods {

  PVector center;
  PVector colour;
  PVector shape[];
  PVector speed = new PVector(0, 0);
  float size;
  float mag;
  float angle;

  asteriods(float s, PVector center, float angle, float speed) {
    this.center = center;
    colour=new PVector(125, 125, 125);
    size = s;
    this.angle=angle;
    chaSpeed(speed);
    turn(angle);
    defineShape();
    colour=new PVector(random(50,255), random(50,255), random(50,255));
  }

  void defineShape() {

    float R2 = Math.round(size/Math.sqrt(2));

    PVector pt[] = new PVector [8] ;
    float sign;
    if (random(5)>2.5)sign = -1;
    else sign = 1;

    pt[0] = new PVector();
    pt[0].x = center.x+(sign*random(size/4)); 
    pt[0].y = center.y+(sign*random(size/4)) - size;

    if (random(5)>2.5)sign = -1;
    else sign = 1;
    pt[1] = new PVector();
    pt[1].x = center.x+(sign*random(size/4)) + R2 ;
    pt[1].y = center.y+(sign*random(size/4)) - R2;

    if (random(5)>2.5)sign = -1;
    else sign = 1;
    pt[2] = new PVector();
    pt[2].x = center.x+(sign*random(size/4)) + size; 
    pt[2].y = center.y+(sign*random(size/4));

    if (random(5)>2.5)sign = -1;
    else sign = 1;
    pt[3] = new PVector();
    pt[3].x = center.x+(sign*random(size/4)) + R2; 
    pt[3].y = center.y+(sign*random(size/4)) + R2;

    if (random(5)>2.5)sign = -1;
    else sign = 1;
    pt[4] = new PVector();
    pt[4].x = center.x+(sign*random(size/4)); 
    pt[4].y = center.y+(sign*random(size/4)) + size;

    if (random(5)>2.5)sign = -1;
    else sign = 1;
    pt[5] = new PVector();
    pt[5].x = center.x+(sign*random(size/4)) - R2; 
    pt[5].y = center.y+(sign*random(size/4)) + R2;

    if (random(5)>2.5)sign = -1;
    else sign = 1;
    pt[6] = new PVector();
    pt[6].x = center.x+(sign*random(size/4)) - size; 
    pt[6].y = center.y+(sign*random(size/4));

    if (random(5)>2.5)sign = -1;
    else sign = 1;
    pt[7] = new PVector();
    pt[7].x = center.x+(sign*random(size/4)) - R2; 
    pt[7].y = center.y+(sign*random(size/4)) - R2;

    shape = pt;
  }

  void Draw() {
    strokeWeight(2);
    stroke(colour.x, colour.y, colour.z);
    noFill();

    beginShape();
    for (PVector p : shape) {
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
  }

  void Move() {
    center.x =(center.x+speed.x);
    center.y =(center.y+speed.y);

    //if (center.x<-size)center.x=(width+size);
    //if (center.y<-size)center.y=(height+size);

    boolean over=false;
    boolean under = false;
    boolean xOver=false;
    for (PVector p : shape) {
      p.x =(p.x+speed.x);
      if (p.x >width+(2*size+size/4)) { 
        over=true; 
        xOver=true;
      }
      if (p.x<0-(2*size+size/4)) {
        under=true; 
        xOver=true;
      }
      p.y =(p.y+speed.y);
      if (p.y > height + (2*size+size/4)) over = true;
      if (p.y < 0-(2*size+size/4) ) under=true;
    }
    if (over || under) {
      changeLocation(over, xOver);
    }
  }

  void changeLocation(boolean over, boolean xOver) {
    for (PVector p : shape) {
      if (over) {
        if (xOver) {
          //x
          p.x =p.x-(width+(2*size+size/4));
          center.x =center.x-(width+(2*size+size/4));
        } else {
          //y
          p.y =p.y-(height+(2*size+size/4));
          center.y=center.y-(height+(2*size+size/4));
        }
      } else {
        if (xOver) {
          //x 
          p.x=p.x+(width+(2*size+size/4));
          center.x=center.x+(width+(2*size+size/4));
        } else {
          //y
          p.y=p.y+(height+(2*size+size/4));
          center.y=center.y+(height+(2*size+size/4));
        }
      }
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
    for (PVector p : shape) {
      poly.addPoint(p.x, p.y);
    }
    return poly;
  }

  void turn(float angle) {
    this.angle = angle;
    //speed = PVector.fromAngle(ang).mult(mag);
  }

  void chaSpeed(float spe) {
    mag = spe;
    speed = PVector.add(speed, PVector.fromAngle(angle).mult(mag));
  }

  ArrayList<asteriods> hit() {
    Rectangle2D bounds = getPolygon().getBounds2D();
    ArrayList<asteriods> babys  = new ArrayList<asteriods>();
    if (size>5) {
      for (int i =0; i< size/10; i++) {
          babys.add(new asteriods(size-5, new PVector(random(Math.round(bounds.getMinX()), Math.round(bounds.getMaxX())), 
          random(Math.round(bounds.getMinY()), Math.round(bounds.getMaxY())) ), random(2*PI), random(mag, 2*mag)));
      }
    }


    return babys;
  }
}