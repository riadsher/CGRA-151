ArrayList<Picture> images =new ArrayList<Picture>(); 

void setup() {
  size(800, 600);
  images.add(new Picture(loadImage("backEnd.png"),new PVector (width/2,height-49),new PVector(68,49)));
  frameRate(60);
}
float t=0.5;
float k=0;
void draw() {
  background(0);

  
  drawRoad(new PVector((width/2)-k, (height/4)*3));
  
  for(Picture p : images){
    image(p.img,p.location().x,p.location().y);
  }
  k= (k+t); 
  if (!(k<100 && k>-100)) t=t*-1;
}


float step =0.0;
void drawRoad(PVector point) {
PVector middle =new PVector((width/2), (height/4)*3);  
  if(frameCount%30==0){
    step=((step+5)%20);
    
    
  }
  
 
  PVector dots[] = new PVector [4]; 
  dots[0] = new PVector(0, 600);
  dots[1] = new PVector(point.x-50, point.y);
  dots[2] = new PVector(800, 600);
  dots[3] = new PVector(point.x+50, point.y);
   
    
  PVector bottom= new PVector(width/2, height);
  PVector D = PVector.sub(bottom,point);

  for (int i=5; i> 0; i--) { //<>//
    strokeWeight(i);
    stroke(255-(51*i));
    line(dots[0].x, dots[0].y, dots[1].x, dots[1].y);
    line(dots[2].x, dots[2].y, dots[3].x, dots[3].y);
    
    
    
    for (float k = 0.0; k>=-1.20; k=k-0.2) {
      PVector p1 = PVector.add(bottom, PVector.mult(D,k-(0.10)));
      PVector p2 = PVector.add(bottom, PVector.mult(D,k));
      line(p1.x, (p1.y+step), p2.x,( p2.y+step));
    
    }
    
  }
    stroke(0);
    fill(0);
    rect(point.x+50,point.y,-100,-50);
}

Picture clickedOn;
void mousePressed(){
 for(Picture p:images){
   if(p.on(mouseX,mouseY))clickedOn=p;
   
 }
}

void mouseReleased() {
  clickedOn =null;
}


void mouseDragged() {
  if (clickedOn!=null) {
    clickedOn.place.x=mouseX;
    clickedOn.place.y=mouseY;
  }
}

class Picture{
 PImage img;
 PVector place;
 PVector size;
 
 Picture(PImage image, PVector Place, PVector Size){
   img =image;
   size = Size;
   place = PVector.sub(Place,PVector.div(size,2));
 }
 
 PVector location(){
   return  PVector.sub(place,PVector.div(size,2));
   
 }
 boolean on(float x,float y){
  return (x< place.x+size.x && x> place.x) && (y < place.y+size.y && y >place.y); 
 }
 }