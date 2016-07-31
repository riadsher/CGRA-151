ArrayList<Ball> balls;

Rect Mouse;
ArrayList<Rect> blockes;


void setup() {
  balls = new ArrayList<Ball>();

  balls.add(new Ball(30, 10, 40, 5, 2, 0, 2.1));


  size(300, 600);
  frameRate(60);

  Mouse = new Rect(100, 200, 300);
}


void draw() {
  Mouse.update(mouseX, mouseY);

  background(0);
  fill(255);
  Mouse.drawRect();

  for (Ball t : balls) {
    fill(0, 0, 125);
    move(t);
    t.drawBall();
    stroke(255, 0, 0);
    // rect(Math.round(t.createBounds().getX()), Math.round(t.createBounds().getY()), Math.round(t.createBounds().getWidth()), Math.round(t.createBounds().getHeight()));
  }
}


void move(Ball t) { //<>//
  //statement one {
  /**so devide move plus ass into 10 piece and then apply piece by piece and check if we have a hit **/
   PVector moving;
    moving = PVector.add(t.move, PVector.div(t.acc, 2));

   // moving.div(10);
  //for (int i =0; i< 10; i++) {
   
   

   // t.loc = t.loc.add(moving);
   // t.contactSide(moving );
   // Mouse.contact(t,moving);
  //}
//t.move.add(moving.mult(10)); 
  //}statement two {
  t.move= t.move.add(PVector.div(t.acc, 2));
  t.loc = t.loc.add(t.move);

  t.contactSide();
  Mouse.contact(t);
  t.move= t.move.add(PVector.div(t.acc, 2));
  //}
}