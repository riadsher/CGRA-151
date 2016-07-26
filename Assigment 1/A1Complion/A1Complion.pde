shapes shape;


void setup(){
 size(300,300);
 background(255);
 frameRate(30);
 shape = new shapes();
 //draws teh first one just so you are not greeted with a white box.
 shape.DrawSquare();
}

void draw(){

}

void keyTyped(){
 if(key == 's'){
 shape.DrawSquare();
 }else if(key =='r'){
   shape.LayerRect();
 } else if (key =='t'){
shape.Triangles();
 }
  
  
}