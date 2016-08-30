
float ks;
float ke;

PVector [] clipPolygon(PVector poly[], PVector line []) {

  ArrayList<PVector> list = new ArrayList<PVector>();

  for (int i =0; i< poly.length; i++) {
    //gets the current point on the polygon
    PVector p1 = poly[i%poly.length]; //<>// //<>//
    //gets the second point on the line
    PVector p2 = poly[(i+1)%poly.length];

    float t =intersects(p1, p2, line);
    if ( !Float.isNaN(t) && (0 <= t && t <= 1)) {
      // puts the end/ beginning point of the polygon
        if(ke >0){list.add(p1);}
     //creates the vertual point on the clip line
        list.add(new PVector((1-t)*p1.x+t*p2.x, (1-t)*p1.y+t*p2.y));
         } else {
      if ((ks >0.0 && ke >0.0)) {
        // creats a virtual polygon mfor one that is completely behind the cut line
        if (i != 0) {
          list.add(
          new PVector((1-intersects(poly[(i-1)%poly.length], p1, line))*poly[(i+1)%poly.length].x+t*p1.x, 
          (1-intersects(poly[(i-1)%poly.length], p1, line))*poly[(i+1)%poly.length].y+t*p1.y));
        }
        //creates the second virtual point on the polygon
        list.add(new PVector((1-t)*p1.x+t*p2.x, (1-t)*p1.y+t*p2.y));
      } else {
        // all inside so just add them.
        list.add(p1);
        list.add(p2);
      }
    }
  }
  PVector temp[] =new PVector[1];
  return list.toArray(temp);
}

float intersects (PVector s, PVector e, PVector Line[]) {
  float a = -(Line[1].y - Line[0].y); //<>// //<>//
  float b = (Line[1].x - Line[0].x);
  float c = (Line[1].y*Line[1].x - Line[0].x*Line[0].y);
 //global verables are used for case detection 
  ks = (a*s.x+b*s.y+c);
  ke = (a*e.x+b*e.y+c);

  if ((ks==0.0 && ke ==0.0) ||(ks >0.0 && ke >0.0) || (ks<0.0 && ke <0.0)) {
  //checks for lines completely not in or out
    return Float.NaN;
  } 
  //finds the point of T for the x and y for the line.
 
  float t = ks/(a*(s.x-e.x)+b*(s.y-e.y));

  return t;
}