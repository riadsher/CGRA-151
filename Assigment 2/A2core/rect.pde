class Rect{
  
  int Size;
  PVector loc;
 
  Rect(int size, float X, float Y){
   Size =size;
   loc = new PVector (X,Y);
    
  }
  
  void drawRect(){
    
   rect(loc.x-(Size/2),loc.y-(Size/4),Size,Size/2); 
    
  }
  
   
  void contact(Ball other){
   PVector circleD = new PVector(abs(other.loc.x - loc.x+Size/2),abs(other.loc.y - loc.y+Size/4);); 
    
    if (circleD.x > (Size/2 + other.Size)) { return false; }
    if (circleD.y > (Size/4 + other.Size)) { return false; }

    if (circleD.x <= (Size/2)) { return true; } 
    if (circleD.y <= (Size/4)) { return true; }

    float cornerDistance_sq = pow((circleD.x - Size/2),2) + pow((circleD.y - Size/4),2);

    return (cornerDistance_sq <= (circle.r^2));
    
    
    //CASE TWO top-right
    //if () {
      //DO STUFF

     // return;
    //}
    //CASE EIGHT top-lefft
    if ((loc.y-Size/2)+1 < 0 && (loc.x+Size/2)+1 < 0 ) {
      //DO STUFF
    
    
      return;
    }

    //CASE FOUR bottom-right
    if ((loc.y-Size/2)+1 > height && (loc.x+Size/2)+1 >width ) {
      //DO STUFF
    
      return;
    }

    //CASE SIX bottom-left
    if ((loc.y-Size/2)+1 >height && (loc.x+Size/2)+1 < 0 ) {
      //DO STUFF
   
      return;
    }

    //CASE ONE top
  
    if (other.bottomBounds() < topBounds() && other.leftBounds() < leftBounds() && other.rightBounds() > rightBounds()  ) {
      other.move.x *= -1;
      
      
      //DO STUFF

      return;
    }

    //CASE THREE right
    //if ( other.leftBounds() < rightBounds() && other.rightBounds() > leftBounds() ) {
    //  other.move.y *= -1;
      
      
    //  //DO STUFF

    //  return;
    //}

    //CASE FIVE bottom
    if ((loc.y-Size/2)+1 > height) {
     
      //DO STUFF

      return;
    }

    //CASE SEVEN left
    if ((loc.x - Size/2)+1 <0) {
   
      //DO  STUFF

      return;
    }
    
  }
  /** this returns the top of the object**/
  float topBounds(){
    return loc.x;
  }
  
  /** this returns the bottom of the object**/
  float bottomBounds(){
   return loc.x+Size/2; 
  }
  /**this returns the left hand point point of the object **/
  float leftBounds(){
   return loc.y; 
  }
  
  /**this returns the right hand point of the object**/
  float rightBounds(){
   return loc.y+Size; 
  }
  
  void update(float x ,float y){
   loc.x=x;
   loc.y=y;
  }
  
}