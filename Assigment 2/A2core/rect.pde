class Rect {

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
    /** covers top and bottom but not the corners very well seems to slip past when one side is not with in the bounds
    if ((top()<other.bottom() && other.top() < bottom()) && (left()<other.left() && other.right() < right())) {
      other.move.y*=-1;
      println("Hit on top || Hit on Bottom");
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