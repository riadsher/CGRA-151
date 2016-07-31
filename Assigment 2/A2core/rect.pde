import java.awt.geom.Rectangle2D;


class Rect {


  int life =3;
  int Size;
  PVector loc;

  Rect(int size, float X, float Y) {
    Size =size;
    loc = new PVector (X, Y);
  }

  void drawRect() {

    rect(loc.x-(Size/2), loc.y-(Size/4), Size, Size/2);
  }



  void contact(Ball other) {
    Rectangle2D.Float bounds = new Rectangle2D.Float(left(), top(), width(), height());
    Rectangle2D.Float otherbounds = other.createBounds();
    /** covers top and bottom but not the corners very well seems to slip past when one side is not with in the bounds*/
    if (bounds.intersects(otherbounds.getX(), otherbounds.getY(), otherbounds.getWidth(), otherbounds.getHeight())) {

      //Top hit  from the rectangle
      if (bounds.contains(other.loc.x, otherbounds.getMaxY())) {
        println("hit Y max");

     
        other.move.y*=-1;
        other.loc.y = Math.round(bounds.getY()-other.Size/2);
        return;
      }

      //Bottom hit  from the rectangle
      if (bounds.contains(other.loc.x, otherbounds.getY())) {
        println("hit Y min");

       
        other.move.y*=-1;
        other.loc.y = Math.round(bounds.getMaxY()+other.Size/2);
        return;
      }

      //Right hit  from the rectangle
      if (bounds.contains(otherbounds.getX(), other.loc.y)) {
        println("hit X right");
       
        other.move.x*=-1;
        other.loc.x = Math.round(bounds.getMaxX()+other.Size/2);
        return;
      }

      //Left hit  from the rectangle
      if (bounds.contains(otherbounds.getMaxX(), other.loc.y)) {
        println("hit X left");
      
        other.move.x*=-1;
        other.loc.x = Math.round(bounds.getX()-other.Size/2);
        return;
      } 
      // bottom Left Hit  from the rectangle
      if (bounds.contains(otherbounds.getMaxX(), otherbounds.getY())) {
        println("hit bottom Left");
        other.move.mult(-1);
       
        other.loc.x = Math.round(bounds.getX()-other.Size/2);
        other.loc.y = Math.round(bounds.getMaxY()+other.Size/2);
        return;
      }
      // top left hit  from the rectangle
      if (bounds.contains(otherbounds.getMaxX(), otherbounds.getMaxY())) {
        println("hit top left");
        other.move.mult(-1);
        
        other.loc.x = Math.round(bounds.getX()-other.Size/2);
        other.loc.y = Math.round(bounds.getY()-other.Size/2);
        return;
      }
      //top right hit  from the rectangle
      if (bounds.contains(otherbounds.getX(), otherbounds.getMaxY())) {
        println("hit top Right");
        other.move.mult(-1);
       
        other.loc.x = Math.round(bounds.getMaxX()+other.Size/2);
        other.loc.y = Math.round(bounds.getY()-other.Size/2);
        return;
      }
      //bottom right hit from the rectangle
      if (bounds.contains(otherbounds.getX(), otherbounds.getY())) {
        println("hit bottom right");
        other.move.mult(-1);
       
        other.loc.x = Math.round(bounds.getMaxX()+other.Size/2);
        other.loc.y = Math.round(bounds.getMaxY()+other.Size/2);
        return;
      }
    }
  }
  /** this returns the top of the object**/
  float top() {
    return loc.y-(Size/4);
  }

  /** this returns the bottom of the object**/
  float bottom() {
    return top() + Size/2;
  }
  /**this returns the left hand point point of the object **/
  float left() {
    return loc.x-(Size/2);
  }

  /**this returns the right hand point of the object**/
  float right() {
    return left()+Size;
  }

  void update(float x, float y) {
    loc.x=x;
    loc.y=y;
  }



  float height() {
    return 1.0*Size/2;
  }
  float width() {
    return 1.0*Size;
  }
}