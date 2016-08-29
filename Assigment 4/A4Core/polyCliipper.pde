

PVector [] clipPolygon(PVector poly[], PVector line []) {
 
  ArrayList<PVector> list = new ArrayList<PVector>();
 
  for (int i =0; i< poly.length+2; i++) {
    PVector p1 = poly[i%poly.length];
    PVector p2 = poly[(i+1)%poly.length];

    float t =intersects(p1, p2, line);
    if (!Float.isNaN(t)&& (0 <= t && t <= 1)) {
      list.add(new PVector((1-t)*p1.x+t*p2.x, (1-t)*p1.y+t*p2.y));
    } else {
      list.add(p2);
    }
  }
  PVector temp[] =new PVector[1];
  return list.toArray(temp); //<>//
}

float intersects (PVector s, PVector e, PVector Line[]) {
  float a = -(Line[1].y - Line[0].y); //<>//
  float b = (Line[1].x - Line[0].x);
  float c = (Line[1].y*Line[1].x - Line[0].x*Line[0].y); //<>//
  float k = (a*s.x+b*s.y+c);
   if(k<0){
   return Float.NaN;
   }


  float t = k/(a*(s.x-e.x)+b*(s.y-e.y));

  return t;
}