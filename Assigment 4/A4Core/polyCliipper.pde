

PVector [] clipPolygon(PVector poly[], PVector line []){

  float xmin;
  float xmax;

  if(line[0].x<line[1].x){
   xmin = line[0].x;
   xmax = line[1].x;
  } else {
    xmin = line[1].x;
    xmax = line[0].x;
  }
   
  for(int i =0; i< poly.length;i++){
    PVector p1 = poly[i];
    PVector p2 = poly[i%poly.length-1];
      
    
    
    
  }
  
 return null;
}

intersects (PVector p1, PVector p2, PVector xMin, PVector xMax){
  float tLMin = (xMin -p1.x)/(p2.x-p1.x);
  float tLmax = (xMax -p1.x)/(p2.x-p1.x);
 
}
