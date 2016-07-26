import java.util.ArrayDeque;

PVector object = new PVector(0, 0);
ArrayDeque<Box> UnSolvedBoxes = new ArrayDeque<Box>();
int level = 2;
float sizing; // outer box sizing
float scaling; // level scale factor
void setup() {
  scaling = 40;
  size(300, 300);
  gameSetup();
  sizing = (width/4)*3;
}
// loads teh area with boxes with random angles for you to solve..
void gameSetup() {
  if (level>scaling) {
    scaling = level;
  }
  for (int i= 1; i <level; i++) {
    UnSolvedBoxes.add(new Box(((width/2)/scaling)*(scaling-(1*i))));
  }
}


void draw() {
  //checking for end of game mechanics
  if (UnSolvedBoxes.isEmpty()) {
    level++;
    gameSetup();
  }
  background(255);
  translate(width/2, height/2); // so everything working from the center gets ride of the all the weird gometry to work out were we are and stuff

  Box temp[] = new Box[1];
  temp = UnSolvedBoxes.toArray(temp);
  for(int i = temp.length-1 ; i>=0 ; i--)
   temp[i].drawBox();


  // little helper so you can work out if your close or not
  if (UnSolvedBoxes.peek().check(angle())) {
    stroke(0, 255, 0);
  } else {
    stroke(255, 0, 0);
  }
  // draws teh outer box
  rotate(angle());
  rectMode(CENTER);
  noFill();
  rect(0, 0, sizing, sizing);
}


//click to solve
void mousePressed() {
  if (UnSolvedBoxes.peek().check(angle())) {
    UnSolvedBoxes.pop();
  }
}

//works out the angle between the mouse and the up point or roatate (0) and then returns the require rotation.
float angle() {
  PVector mouse = new PVector(mouseX-width/2, mouseY-height/2);
  PVector up = new PVector(0, 1); 

  if (mouse.x>=0) {

    return TWO_PI-PVector.angleBetween(up, mouse);
  } else {

    return PVector.angleBetween(up, mouse);
  }
}