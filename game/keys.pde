
class keys {

  boolean [] keys = new boolean[26];
  // puts all the keys to the false state
  keys() {
    for (int i =0; i<26; i++) {
      keys[i]=false;
    }
  }
  // checking the keys
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

  boolean A() {
    return keys[5];
  }

  boolean S() {
    return keys[6];
  }

  boolean W() {
    return keys[7];
  }

  boolean D() {
    return keys[8];
  }

  // Pressign teh keys
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

  void APressed() {
    keys[5]=true;
  }

  void SPressed() {
    keys[6]=true;
  }

  void WPressed() {
    keys[7]=true;
  }

  void DPressed() {
    keys[8]=true;
  }



  // releasing the keys
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

  void AReleased() {
    keys[5] = false;
  }

  void SReleased() {
    keys[6] =false;
  }

  void WReleased() {
    keys[7] = false;
  }

  void DReleased() {
    keys[8] = false;
  }
}