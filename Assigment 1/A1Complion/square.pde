
class shapes {
 int spacing=2;
void DrawSquare(){
  background(230);
  for(int k =10-spacing; k<height-10; k+=10+spacing){
  for(int i= 10-spacing; i<width-10;i+=10+spacing){
   rect(i,k,10,10);
  }
}
}

void LayerRect(){
  background(230);
  fill(255);
  for(int k =10; k<height-10; k+=10){
  for(int i= 20-spacing; i<width-20;i+=20+(spacing)){
   rect(random(i-3,i+3),k,random(5,20),10);
  }
  }
}
 /*creates the triangle that you see*/
 void Triangles(){
  background(230);
  fill(255);
   
  for(int y =10;y<height;y+=15){
    for(int x = 10;x<width;x+=15){
  
  createTriangle(x,y);
  
    }
  }

}
/*if we jsut made them with a lot of randoms we would loss
the triangle shape very easily so this meathod tries to control
the general shape so that a large part of the created shapes are
triangle in shape*/
/** this takes two coordiattes that are the middle of the triangle**/
void createTriangle(float x,float y){
  float errorX = width/10;
  float errorY = width/10;
  PVector one = new PVector(x - random(-errorX,errorX) ,y + random(-errorY,errorY));
  PVector two =  new PVector(x + random(-errorX,errorX) ,y + random(-errorY,errorY));
  PVector three = new PVector(x - random(-errorX,errorX) ,y - random(-errorY,errorY));
  triangle(one.x,one.y,two.x,two.y,three.x,three.y);
  
}
}