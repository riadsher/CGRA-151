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
  
   
  void conatact(Ball other){
   
    //CASE TWO
    if ((loc.y-Size/2)+1 <  && (loc.x+Size/2)+1 >width) {
      //DO STUFF

      return;
    }
    //CASE EIGHT
    if ((loc.y-Size/2)+1 < 0 && (loc.x+Size/2)+1 < 0 ) {
      //DO STUFF
    
    
      return;
    }

    //CASE FOUR
    if ((loc.y-Size/2)+1 > height && (loc.x+Size/2)+1 >width ) {
      //DO STUFF
    
      return;
    }

    //CASE SIX
    if ((loc.y-Size/2)+1 >height && (loc.x+Size/2)+1 < 0 ) {
      //DO STUFF
   
      return;
    }

    //CASE ONE
    if ((loc.y-Size/2)+1 < 0) {

      
      
      //DO STUFF

      return;
    }

    //CASE THREE
    if ( (loc.x+Size/2)+1 >width ) {
      
      
      
      //DO STUFF

      return;
    }

    //CASE FIVE
    if ((loc.y-Size/2)+1 > height) {
     
      //DO STUFF

      return;
    }

    //CASE SEVEN
    if ((loc.x - Size/2)+1 <0) {
   
      //DO  STUFF

      return;
    }
    
  }
  
  void update(float x ,float y){
   loc.x=x;
   loc.y=y;
  }
  
}