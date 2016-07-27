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

    
  }
  /** this returns the top of the object**/
  float topBounds() {
    return loc.x;
  }

  /** this returns the bottom of the object**/
  float bottomBounds() {
    return loc.x+Size/2;
  }
  /**this returns the left hand point point of the object **/
  float leftBounds() {
    return loc.y;
  }

  /**this returns the right hand point of the object**/
  float rightBounds() {
    return loc.y+Size;
  }

  void update(float x, float y) {
    loc.x=x;
    loc.y=y;
  }

 
  
  float height(){
            return 1.0*Size/2;
    }
    float width(){
      return 1.0*Size;
    }
}