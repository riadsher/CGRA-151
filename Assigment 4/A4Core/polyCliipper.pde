 //<>// //<>// //<>//
float ks;
float ke;

PVector [] clipPolygon(PVector poly[], PVector line []) {

  ArrayList<PVector> list = new ArrayList<PVector>();

  for (int i =0; i< poly.length; i++) {
    PVector p1 = poly[i%poly.length];
    PVector p2 = poly[(i+1)%poly.length];

    float t =intersects(p1, p2, line);
    if ( !Float.isNaN(t) && (0 <= t && t <= 1)) {
       //list.add(p1); // weird error is in this case here!!! 
      list.add(new PVector((1-t)*p1.x+t*p2.x, (1-t)*p1.y+t*p2.y));
    } else {
      if ((ks >0.0 && ke >0.0)) {
           if(i != 0){
          list.add(
          new PVector((1-intersects(poly[(i-1)%poly.length], p1, line))*poly[(i+1)%poly.length].x+t*p1.x,
          (1-intersects(poly[(i-1)%poly.length], p1, line))*poly[(i+1)%poly.length].y+t*p1.y));
           }
        list.add(new PVector((1-t)*p1.x+t*p2.x, (1-t)*p1.y+t*p2.y));
      } else {
        list.add(p1);
        list.add(p2);
      }
    }
  }
  PVector temp[] =new PVector[1];
  return list.toArray(temp);
}

float intersects (PVector s, PVector e, PVector Line[]) {
  float a = -(Line[1].y - Line[0].y);
  float b = (Line[1].x - Line[0].x);
  float c = (Line[1].y*Line[1].x - Line[0].x*Line[0].y);
  ks = (a*s.x+b*s.y+c);
  ke = (a*e.x+b*e.y+c);
  //if (k<0) {
  //  return Float.NaN;
  //}
  if ((ks==0.0 && ke ==0.0) ||(ks >0.0 && ke >0.0) || (ks<0.0 && ke <0.0)) {
    return Float.NaN;
  } 

  float t = ks/(a*(s.x-e.x)+b*(s.y-e.y));

  return t;
}