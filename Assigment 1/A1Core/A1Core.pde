

void setup() {
  size(300, 300);
  background(255);
  
}

void draw() {
  drawRect();
  drawEllipse();
  drawTraingle();
  drawPolygon(width*(2f/3f), height*(0f/6f));
  drawLines(width*(2f/3f), height*(3f/6f), width*(3f/3f), height*(6f/6f), 2);
}

//Draws teh rectangle
void drawRect() {
  //REct draw function
  fill(255, 0, 0);
  //crazy maths makes it alwasy in the same place and changes size to fit the screen
  rect(width*(0.0/3.0)+10, height*(0f/6f)+10, width*(1f/3f)-
    width*(0f/3f)-10, height*(1f/6f)-height*(0f/6f));
}


void drawEllipse() {
  //Ellipse draw function
  fill(0, 255, 0);
  ellipseMode(CENTER);
  //crazy maths makes it alwasy in the same place and changes size to fit the screen  
  float startx =width*(0.0/3.0)+10;
  float endx = width*(1.0/3.0);
  float starty = height*(2f/6f);
  float endy = height*(3f/6f);
  ellipse(startx+(endx-startx)/2, starty+(endy-starty)/2, endx-startx, endy-starty);
}

void drawTraingle() {
  //Traingle draw function
   //crazy maths makes it alwasy in the same place and changes size to fit the screen
  fill(0, 0, 255);
  float x1 = width*(0f/3f)+10;
  float y1 = height*(4f/6f)+height*(1f/12f);

  float x2 = width*(1f/3f);
  float y2 = height*(4f/6f);

  float x3 = x1 +width*(1f/6f);
  float y3 = height*(5f/6f);

  triangle(x1, y1, x2, y2, x3, y3);
}

/** this method doesn't take into count the window size and so gets a little buggy when changed**/
void drawPolygon(float xOffSet, float yOffSet) {
  //Polygon Draw
  fill(117, 26, 255);
  beginShape();
  vertex(xOffSet+10, yOffSet+20);
  vertex(xOffSet+40, yOffSet+10);
  vertex(xOffSet+90, yOffSet+50);
  vertex(xOffSet+80, yOffSet+60);
  vertex(xOffSet+40, yOffSet+80);
  vertex(xOffSet+20, yOffSet+70);
  endShape(CLOSE);
}

void drawLines(float xOffSetS, float yOffSetS, float xOffSetE, 
  float yOffSetE, int seed) {
     //crazy maths makes it alwasy in the same place and changes size to fit the screen
  float beginning = xOffSetS-10;
  float end = xOffSetS+10;
  stroke(179, 134, 0);
  strokeWeight(seed);
  line(end, yOffSetS, beginning, yOffSetE-20);

  beginning = end;
  end = end + 20;

  stroke(0, 179, 179);
  strokeWeight(seed*2);
  line(end, yOffSetS, beginning, yOffSetE-20);

  beginning = end;
  end = end + 20;

  stroke(128, 0, 128);
  strokeWeight(seed*3);  
  line(end, yOffSetS, beginning, yOffSetE-20);

  stroke(0);
  strokeWeight(1);
}