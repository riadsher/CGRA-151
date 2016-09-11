
class keys {

  boolean [] keys = new boolean[26];

  keys() {
    for (int i =0; i<26; i++) {
      keys[i]=false;
    }
  }

  boolean space() {
    return keys[0];
  }
  boolean left() {
    return keys[1];
  }
  boolean right() {
    return keys[2];
  }
  boolean up() {
    return keys[3];
  }
  boolean down() {
    return keys[4];
  }

  void spacePressed() {
    keys[0]=true;
  }
  void leftPressed() {
    keys[1]=true;
  }
  void rightPressed() {
    keys[2]=true;
  }
  void upPressed() {
    keys[3]=true;
  }
  void downPressed() {
    keys[4]=true;
  }
  
    void spaceReleased() {
    keys[0]=false;
  }
  void leftReleased() {
    keys[1]=false;
  }
  void rightReleased() {
    keys[2]=false;
  }
  void upReleased() {
    keys[3]=false;
  }
  void downReleased() {
    keys[4]=false;
  }
  
}