class Box {

  float angle;
  float size;

  Box(float Size) {
    size = Size;
    angle= random(0, TWO_PI);
  }


  void drawBox() {
    stroke(0);
    rotate(0);
    rotate(angle);
    fill(100);
    rect(0, 0, size, size);

    rotate(-angle);
  }


  //checks to see if you boxhas been solved.
  boolean check(float other) {

    return  (degrees(other) < degrees(angle)+2 && degrees(other) >= degrees(angle)-2);
  }
}