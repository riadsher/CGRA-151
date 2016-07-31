class Ball {

  int Size;
  PVector loc, move, acc;

  Ball(int x, int y, int size, float MOVEx, float MOVEy, float ACCx, float ACCy) {
    loc = new PVector(x, y);
    move = new PVector(MOVEx, MOVEy);
    acc = new PVector(ACCx, ACCy);
    Size=size;
  }


  void drawBall() {
    
    ellipse(loc.x, loc.y, Size, Size);
  }

  boolean contact(Ball other) {




    return false;
  }
  
  boolean contact(Rect other){
    
    
    
    
    return false;
  }


 

  /** there is a reason behind teh weird layering of the if statements
   as if we put if one first we will fire off and miss case 8 and 2 and so on **/
  void contactSide() {

    //CASE TWO
    if ((loc.y-Size/2) < 0 && (loc.x+Size/2)+1 >width) {
      //DO STUFF
      loc.y= 0+Size/2;
      loc.x = width - Size/2;
      
      move.y*=-1;
      move.x*=-1;
      return;
    }
    //CASE EIGHT
    if ((loc.y-Size/2)+1 < 0 && (loc.x+Size/2)+1 < 0 ) {
      //DO STUFF
      loc.x = 0+Size/2;
      loc.y= 0+Size/2;
      
      move.y*=-1;
      move.x*=-1;
      return;
    }

    //CASE FOUR
    if ((loc.y-Size/2)+1 > height && (loc.x+Size/2)+1 >width ) {
      //DO STUFF
      loc.y = height - Size/2;
      loc.x = width - Size/2;
      
      move.y*=-1;
      move.x*=-1;
      return;
    }

    //CASE SIX
    if ((loc.y-Size/2)+1 >height && (loc.x+Size/2)+1 < 0 ) {
      //DO STUFF
      loc.y = height - Size/2;
      loc.x = 0 + Size/2;
      
      move.y*=-1;
      move.x*=-1;
      return;
    }

    //CASE ONE
    if ((loc.y-Size/2)+1 < 0) {
      loc.y= 0+Size/2;
      
      move.y*=-1;
      //DO STUFF

      return;
    }

    //CASE THREE
    if ( (loc.x+Size/2)+1 >width ) {
      loc.x = width - Size/2;
      
      move.x*=-1;
      //DO STUFF

      return;
    }

    //CASE FIVE
    if ((loc.y+Size/2)+1 > height) {
      loc.y = height - Size/2;
     
      move.y*=-1;
      //DO STUFF

      return;
    }

    //CASE SEVEN
    if ((loc.x - Size/2) +1<0) {
      loc.x = 0+Size/2;
      
      //DO  STUFF

      return;
    }
  }

  boolean ContactSideY() {
    if ((loc.y+Size/2<height && loc.y-Size/2>=0)) {
      return false;
    } else {
      return true;
    }
  }

   Rectangle2D.Float createBounds(){
   return new Rectangle2D.Float(loc.x-Size/2,loc.y-Size/2,Size,Size); 
  }
  
}