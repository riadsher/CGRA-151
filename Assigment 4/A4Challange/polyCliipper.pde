//<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
float ks;
float ke;
Boolean _Vertical = false;

PVector [] clipPolygon(PVector poly[], PVector line [], boolean Vertical) {
  _Vertical = Vertical; //<>//
  ArrayList<PVector> list = new ArrayList<PVector>();

  for (int i =0; i< poly.length; i++) {
    //gets the current point on the polygon

    PVector p1 = poly[i%poly.length];
    //gets the second point on the line
    PVector p2 = poly[(i+1)%poly.length];

    float t[] =intersects(p1, p2, line);
    if ( (!Float.isNaN(t[0])) && /*(0 <= t[0] && t[0] <= 1) &&*/ t[1]==0) {
      // puts the end/ beginning point of the polygon
      if (ke >0) {
        list.add(p1);
      }
      //creates the vertual point on the clip line
      float x = (1-t[0])*p1.x+t[0]*p2.x;
      float y = (1-t[0])*p1.y+t[0]*p2.y;
      list.add(new PVector(x, y));
    } else if (t[1]==1) {
      if (!(ks >0.0 && ke >0.0)) {
        // all inside so just add them.
        list.add(p1);
        list.add(p2);
      }
    }
  }
  PVector temp[] =new PVector[1];
  return list.toArray(temp);
}

float[] intersects (PVector s, PVector e, PVector Line[]) {
  if (_Vertical) {
    return intersectsVertical(s, e, Line);
  } else {
    return intersectsHorizontal(s, e, Line);
  }
}


float[] intersectsVertical (PVector s, PVector e, PVector Line[]) {
  float a = -(Line[1].y - Line[0].y); //<>//
  float b = (Line[1].x - Line[0].x);
  float c = (Line[1].y*Line[1].x - Line[0].x*Line[0].y);
  //global verables are used for case detection 
  ks = (a*s.x+b*s.y+c);
  ke = (a*e.x+b*e.y+c);
  float t = ks/(a*(s.x-e.x)+b*(s.y-e.y));
  if ((ks==0.0 && ke ==0.0) ||(ks >0.0 && ke >0.0) || (ks<0.0 && ke <0.0)) {
    //checks for lines completely not in or out
    float temp [] ={t, 1};
    return temp;
  } 
  //finds the point of T for the x and y for the line.


  float temp [] ={t, 0};
  return temp;
}


float[] intersectsHorizontal (PVector s, PVector e, PVector Line[]) {
  float a = (Line[1].y - Line[0].y); //<>//
  float b = -(Line[1].x - Line[0].x);
  float c = (Line[1].y*Line[1].x - Line[0].x*Line[0].y);
  //global verables are used for case detection 
  ks = (a*s.x+b*s.y+c);
  ke = (a*e.x+b*e.y+c);

  float t = ks/(a*(s.x-e.x)+b*(s.y-e.y));

  if ((ks==0.0 && ke ==0.0) ||(ks >0.0 && ke >0.0) || (ks<0.0 && ke <0.0)) {
    //checks for lines completely not in or out
    float temp [] ={t, 1};
    return temp;
  } 
  //finds the point of T for the x and y for the line.


  float temp [] ={t, 0};
  return temp;
}