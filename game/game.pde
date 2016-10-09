 //<>// //<>// //<>//
//list of multiply objects.

ArrayList<asteriods> Asteriods = new ArrayList<asteriods>();
ArrayList<bullet> bullets = new ArrayList<bullet>();
ArrayList<Bonus> bonus = new ArrayList<Bonus>();


//bonus and score keeping also the biggest score you cang et per level
//and level counter
int bonusLevel[] ;
long totalScore=0;
long score=0;
int level = 1;

//any test on the screen is handled here
Menu Menu;
// used to keep track of key events
keys keys = new keys(); 

// teh player only one player is possible
// possible to include networking of this
// in future revisions ( don't think processing does that)
ship player;

// basic timer for timed events
int timer=0;

// state switches
boolean PlayerDead = false;
boolean fireWave = false;
boolean menu = true;
boolean LevelRun= false;

void setup() {
  Menu= new Menu();
  size(600, 600);
  setupAsteriods();
  generateBonusTable();
  bonus.add(new Bonus(new PVector(width/2, height/2))); 
  frameRate(60);
}
// generates the bonus so that power ups can be dropped
// just works out at what score to release teh power up.
void generateBonusTable() {
  bonus.clear();
  int number =Math.round(random(level*3));
  bonusLevel = new int [number];
  long max = totalScore;
  long min = score+1;
  for (int i=0; i< number; i++) {
    bonusLevel[i]= Math.round(random(min, max));
  }
}

// builds the asteroids so far tehre is always 4 asteriods but the size does change and location speed and rotation.
// may add some random amounts into the number but 4 should be fine for now
void setupAsteriods() {
  Asteriods.clear();
  totalScore =score;
  //it is done this way so teh player is not spawn on a aasteriods
  for (int i = 0; i<2; i++) {
    //east sector
    asteriods temp= new asteriods(random(15, 20+level), new PVector(random(3*width/4, width), random(0, height)), random(2*PI), random(0.5, 3)); 
    totalScore = totalScore+Math.round(temp.size);
    Asteriods.add(temp);
    //north sector
    temp = new asteriods(random(15, 20+level), new PVector(random(0, width/4), random(0, height)), random(2*PI), random(0.5, 3));
    Asteriods.add(temp);
    totalScore = totalScore+Math.round(temp.size);
    //south sector
    temp = new asteriods(random(15, 20+level), new PVector(random(0, width), random(3*height/4, height)), random(2*PI), random(0.5, 3));
    Asteriods.add(temp);
    totalScore = totalScore+Math.round(temp.size);
    //west sector
    temp = new asteriods(random(15, 20+level), new PVector(random(0, width), random(0, height/4)), random(2*PI), random(0.5, 3));
    Asteriods.add(temp);
    totalScore = totalScore+Math.round(temp.size);
  }
}

//draw function
void draw() {
  checkBonus();

  background(0);
  //checks to see what hold key events are being fired
  checkKeys();
  // draw any bonus on the screen
  if (!bonus.isEmpty()) {
    for (Bonus b : bonus) {
      b.Draw();
      b.move();
    }
  }
  //draws all the bullets
  if (!bullets.isEmpty()) {
    for (bullet b : bullets) {
      // checking if it is teh WAVE bullet
      if (!(b.type=='D')) {
        b.move();
        b.Draw();
      } else if (b.type=='D') {
        Wave temp = (Wave) b;

        if (fireWave) {

          if (temp.index==(temp.points.size())) {
            fireWave=false;
          }
          temp.move();
          temp.Draw();
        }
      }
    }
  }
  //drawing and moving all asteriods
  for (asteriods p : Asteriods) {

    p.Move();
    p.Draw();
  }
  // checking states
  if (menu) {
    Menu.DrawMenu();
  } else if (PlayerDead) { 
    Menu.PlayerDead();
  } else if (Asteriods.isEmpty()) {
    // level cleared condition
    if (millis()-timer>2500) {
      level++;
      bonus.clear();
      setupAsteriods();
      generateBonusTable();
      LevelRun = false;
    }
    // next level text
    Menu.DrawScorePanel();
    Menu.NextLevel();

    player.Draw();
  } else if (!PlayerDead) {

    Menu.DrawScorePanel();
    player.move();
    player.Draw();
  }
  if (player!=null) {
    contacts();
  }
}
// so this adds the bonus to the level and marks the point as -1 to show that it has been consumed.
void checkBonus() {

  for (int i =0; i<bonusLevel.length; i++) {
    int a = bonusLevel[i];
    if (a!=-1&&score >= a) {
      bonusLevel[i]=-1;
      Bonus temp = new Bonus(new PVector(random(width), random(height)));

      temp.turn(random(2*PI));
      temp.chaSpeed(random(1));
      bonus.add(temp);
    }
  }
}

//checks all the contacts
void contacts() {
  // lists of things to add and thigs to remove
  ArrayList<asteriods> add = new ArrayList<asteriods>();
  ArrayList<asteriods> remove = new ArrayList<asteriods>();
  ArrayList<bullet> bulletAdd = new ArrayList<bullet>();
  ArrayList<bullet> bulletRemove = new ArrayList<bullet>();

  for (bullet a : bullets) {
    // check to see if anything is gone beyound the screen and adds it to the remove file
    if (a.bounds()) {

      bulletRemove.add(a);
      if (a.type=='D') {
        // so if it is a WAVE attack then it turns the wave state off
        fireWave = false;
      }
    }
    for (asteriods p : Asteriods) {

      if (a.type=='D') {

        Wave temp = (Wave) a;
        if (temp.DEAD) {
          bulletRemove.add(a);

          fireWave=false;
        }
        // so this just goes throught all the points on the wave and checks to see if it hits anything
        // has to be done this way because its faster to pregenerate the wave than generate it each fire (possible to make it 
        // static and which case it would only be generated if the garbage collect has got it)
        for (PVector point : temp.waveHit()) {
          // did we get a hit check  
          if (!p.Dead&&p.getPolygon().contains(point.x, point.y)) {
            p.Dead=true;
            add.addAll(p.hit());
            remove.add(p);
            score=score +Math.round(p.size);
          }
        }
      } else if (!p.Dead&&(!bulletRemove.contains(a))&&p.getPolygon().contains(a.loc.x, a.loc.y)) {
        // this is for normal shots
        if (a.type=='S') {

          bulletRemove.add(a);
          add.addAll(p.hit());
          remove.add(p);
          p.Dead=true;
          score=score +Math.round(p.size);
        } else if (a.type == 'W') {
          // this si for cluster bombs 
          bulletRemove.add(a);
          Cluster temp = (Cluster) a;
          ArrayList<bullet> test = temp.blast();
          bulletAdd.addAll(test);
          add.addAll(p.hit());
          remove.add(p);
          p.Dead=true;
          score=score +Math.round(p.size);
        }
      }
    }
  }
  // checking to see if the bonus have left teh screen or bean picked up buy the player.
  ArrayList<Bonus> removed = new ArrayList<Bonus>();
  for (Bonus b : bonus) {
    if (!b.bounds()) {
      if (b.contact(player)) {
        player.addBonus(b.current); 
        removed.add(b);
      }
    } else {
      removed.add(b);
    }
  }
  // removing them from teh game lists
  bonus.removeAll(removed);
  // finding all dead asteriods and checking if player is dead
  for (asteriods p : Asteriods) {
    if (p.Dead) {
      remove.add(p);
    }
    if (!p.Dead&&player.Collison(p.getPolygon())) {
      PlayerDead= true;
    }
  }
  // removing and adding anything that has changed during the run of this meathod
  bullets.addAll(bulletAdd);
  bullets.removeAll(bulletRemove);
  Asteriods.removeAll(remove);
  Asteriods.addAll(add);

  // end of level check to see we need to declear that its the end of level.
  if (!LevelRun && Asteriods.isEmpty()) {
    timer = millis();
    player.speed=new PVector(0, 0);
    player.loc= new PVector(width/2, height/2);
    player.ang=-PI/2;
    player.move();
    LevelRun =true;
  }
}

// because of the way the keyevents fire off this just makes it more consistant
// otherwise you get jerky movements.
void checkKeys() {

  if (keys.space() || keys.S()) { 
    if (player !=null) {
      bullet shot = player.fire();
      if (shot != null)
        bullets.add(shot);
    }
  }
  if (keys.down()) {
    player.chaSpeed(-0.5);
  }
  if (keys.up()) {
    player.chaSpeed(+0.5);
  }
  if (keys.left()) {
    if (player != null) {
      player.turn(radians(degrees(player.ang)+(-3)));
    }
  }
  if (keys.right()) {
    if (player != null) {
      player.turn(radians(degrees(player.ang)+3));
    }
  }
  if (keys.A()) {
    if (player != null) {
      player.FireLASER();
      if (player.laser) {
        checkLASER(player.ang);
      }
    }
  }
  if (keys.W()) {
    if (player != null && player.ClusterBomb>0) {
      bullet temp = player.DropBomb();
      if (temp != null) {
        bullets.add(temp);
      }
    }
  }
  if (keys.D()) {
    if (player != null && player.Wave>0) {
      if (!fireWave) {
        Wave temp = player.FireWave();
        if (temp != null) {
          bullets.add(temp );
          fireWave=true;
        } else {
          fireWave=false;
        }
      }
    }
  }
}

// this is all for the laser beam as it checks everyting in one hit and is very comlicated also 
//it is not a standard bullet it gets its own meathod that checks it all.
void checkLASER(float ang) {
  // we generate a infante line and check a 1000.0 points on the line
  //there are holes in this but i feel the holes are small enough that
  // it doesn't effect the game to much.
  ArrayList<asteriods> add = new ArrayList<asteriods>();
  ArrayList<asteriods> remove = new ArrayList<asteriods>();
  PVector a = new PVector(player.loc.x, player.loc.y);
  PVector b = PVector.add(a, PVector.fromAngle(ang).mult(1));
  PVector D = PVector.sub(b, a);
  for (float t = 0.0; t<1000.0; t+=1) {

    PVector p1 = PVector.add(a, PVector.mult(D, t));
    //point(p1.x,p1.y);
    for (asteriods p : Asteriods) { 
      if ((!remove.contains(p))&&p.getPolygon().contains(p1.x, p1.y)) {
        add.addAll(p.hit());
        remove.add(p);
        score=score +Math.round(p.size);
      }
    }
  }

  Asteriods.removeAll(remove);
  Asteriods.addAll(add);
}
// key events
void keyPressed() {

  if (key==CODED) {
    // print(keyCode);
    if (keyCode==DOWN) {

      if (menu) {
        Menu.down();
      } else {
        keys.downPressed();
      }
    } else if (keyCode==UP) {

      if (menu) {
        Menu.up();
      } else {
        keys.upPressed();
      }
    } else if (keyCode==LEFT) {

      keys.leftPressed();
    } else if (keyCode==RIGHT) {

      keys.rightPressed();
    }
  }
  if (key=='n') {
    newGame();
  } else if (key==' ') {
    if (menu) {
      if (Menu.select==0) {
        newGame();
      } else if (Menu.select==1) {
        Menu.Score=true;
      } else if (Menu.select==2) {
        System.exit(0);
      }
    } else {
      keys.spacePressed();
    }
  } else if (key=='r') {
    PlayerDead = false;
    menu = true;
    setupAsteriods();
  } else if (key=='b') {
    if (menu && Menu.Score) {
      Menu.Score=false;
    } else if (!menu) {
      menu = true;
    }
  } else if (key=='p') {
    Asteriods.clear(); 
    timer = millis();
  } else if (key=='a') {
    keys.APressed();
  } else if (key=='s') {
    keys.SPressed();
  } else if (key=='w') {
    keys.WPressed();
  } else if (key=='d') {
    if (!fireWave) {
      Wave temp = player.FireWave();
      if (temp != null) {
        bullets.add(temp );
        fireWave=true;
      } else {
        fireWave=false;
      }
    } 

    keys.DPressed();
  } else if (key =='t') {
    test();
  } else if (key=='y') {
    for (asteriods o : Asteriods) {
      o.printdata();
    }
  } else if (key=='o') {
    PlayerDead= !PlayerDead;
  }
}

void keyReleased() {
  if (key==CODED) {
    if (keyCode==DOWN) {
      keys.downReleased();
    } else if (keyCode==UP) {
      keys.upReleased();
    } else if (keyCode==LEFT) {
      keys.leftReleased();
    } else if (keyCode==RIGHT) {
      keys.rightReleased();
    }
  }
  if (key==' ') {
    keys.spaceReleased();
  } else if (key=='a') {
    if (player!=null) {
      keys.AReleased();
      if (player.laser) {
        player.laserBlast =player.laserBlast - (millis()-player.lastFire);
        player.lastFire=millis();
        player.laser=false;
      }
    }
  } else if ( key=='s') {
    keys.SReleased();
  } else if (key=='w') {
    keys.WReleased();
  } else if (key=='d') {
    //fireWave= false;

    keys.DReleased();
  }
}
// new Game
void newGame() {
  // start from 1 so reset everthing
  level = 1; 
  totalScore=0; 
  score=0;

  bonus.clear();
  Asteriods.clear();
  setupAsteriods();
  generateBonusTable();
  player = new ship(new PVector(width/2, height/2), -PI/2, 0);
  PlayerDead= false;
  menu = false;
}
// sanity checker
void test() {
  print("bonusLevel= ");
  for (int k : bonusLevel) {
    print( " "+k+", ");
  }
  println();
  print("Level: "+level);
  println(" Asteriods Left: "+ Asteriods.size());
}