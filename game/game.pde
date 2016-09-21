//import java.awt.event.KeyEvent; //<>// //<>//

ArrayList<asteriods> one = new ArrayList<asteriods>();
ArrayList<bullet> bullets = new ArrayList<bullet>();
ArrayList<Bonus> bonus = new ArrayList<Bonus>();

int bonusLevel[] ;
long totalScore=0;
Menu Menu;

keys keys = new keys(); 
ship player;

long score=0;
int timer=0;
int level = 1;

boolean PlayerDead = false;

boolean menu = true;


void setup() {
  Menu= new Menu();
  size(600, 600);
  setupAsteriods();
  generateBonusTable();
  bonus.add(new Bonus(new PVector(width/2, height/2))); 
  frameRate(60);
}

void generateBonusTable() {
  //bonus.clear();
  int number =Math.round(random(level*3));
  bonusLevel = new int [number];
  long max = totalScore -100;
  long min = score;
  for (int i=0; i< number; i++) {
    bonusLevel[i]= Math.round(random(min, max)); //<>//
  }
  println(bonusLevel);
}
void setupAsteriods() {
  one.clear();
  totalScore =score;
  for (int i = 0; i<2; i++) {

    asteriods temp= new asteriods(random(15, 20+level), new PVector(random(3*width/4, width), random(0, height)), random(2*PI), random(0.5, 3)); 
    totalScore = totalScore+Math.round(temp.size);
    one.add(temp);

    temp = new asteriods(random(15, 20+level), new PVector(random(0, width/4), random(0, height)), random(2*PI), random(0.5, 3));
    one.add(temp);
    totalScore = totalScore+Math.round(temp.size);

    temp = new asteriods(random(15, 20+level), new PVector(random(0, width), random(3*height/4, height)), random(2*PI), random(0.5, 3));
    one.add(temp);
    temp = new asteriods(random(15, 20+level), new PVector(random(0, width), random(0, height/4)), random(2*PI), random(0.5, 3));
    totalScore = totalScore+Math.round(temp.size);
    one.add(temp);
    totalScore = totalScore+Math.round(temp.size);
  }
}


void draw() {
  checkBonus();

  background(0);

  for (Bonus b : bonus) {
    b.Draw();
    b.move();
  }
  checkKeys();
  if (!bullets.isEmpty()) {
    for (bullet b : bullets) {
      b.move();
      b.Draw();
    }
  }

  for (asteriods p : one) {

    p.Move();
    p.Draw();
  }
  if (menu) {
    Menu.DrawMenu();
  } else if (one.isEmpty()) {

    if (millis()-timer>2500) {
      level++;
      setupAsteriods();
      generateBonusTable();
    }

    Menu.DrawScorePanel();
    Menu.NextLevel();

    player.Draw();
  } else if (!PlayerDead) {
    Menu.DrawScorePanel();
    player.move();
    player.Draw();

    contacts();
  }
}

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


void contacts() {
  ArrayList<asteriods> add = new ArrayList<asteriods>();
  ArrayList<asteriods> remove = new ArrayList<asteriods>();
  ArrayList<bullet> bulletRemove = new ArrayList<bullet>();

  for (bullet a : bullets) {
    if (a.bounds()) {
      bulletRemove.add(a);
    }
    for (asteriods p : one) {
      if (p.Dead) {
        println("Death to one");
        remove.add(p);
      }

      if ((!bulletRemove.contains(a))&&p.getPolygon().contains(a.loc.x, a.loc.y)) {
        bulletRemove.add(a);
        add.addAll(p.hit());
        remove.add(p);
        score=score +Math.round(p.size);
      }
    }
  }
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
  bonus.removeAll(removed);

  for (asteriods p : one) {
    if (player.Collison(p.getPolygon())) {
      //PlayerDead= true;
    }
  }

  bullets.removeAll(bulletRemove);
  one.removeAll(remove);
  one.addAll(add);

  if (one.isEmpty()) {
    timer = millis();
    player.speed=new PVector(0, 0);
    player.loc= new PVector(width/2, height/2);
    player.ang=-PI/2;
  }
}

void checkKeys() {

  if (keys.space() || keys.K()) { 
  if(player !=null){
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

    player.turn(radians(degrees(player.ang)+(-3)));
  }
  if (keys.right()) {
    player.turn(radians(degrees(player.ang)+3));
  }
  if (keys.L()) {
    if(player != null){
    player.FireLASER();
    if (player.laser) {
      checkLASER(player.ang);
    }
    }
  }
}

void checkLASER(float ang) {
  ArrayList<asteriods> add = new ArrayList<asteriods>();
  ArrayList<asteriods> remove = new ArrayList<asteriods>();
  PVector a = new PVector(player.loc.x, player.loc.y);
  PVector b = PVector.add(a, PVector.fromAngle(ang).mult(1));
  PVector D = PVector.sub(b, a);
  for (float t = 0.0; t<1000.0; t+=1) {

    PVector p1 = PVector.add(a, PVector.mult(D, t));
    //point(p1.x,p1.y);
    for (asteriods p : one) { 
      if ((!remove.contains(p))&&p.getPolygon().contains(p1.x, p1.y)) {

        add.addAll(p.hit());
        remove.add(p);
        score=score +Math.round(p.size);
      }
    }
  }

  one.removeAll(remove);
  one.addAll(add);
}

void keyPressed() {

  if (key==CODED) {
    // print(keyCode);
    if (keyCode==DOWN) {
      //println("down");
      if (menu) {
        Menu.down();
      } else {
        keys.downPressed();
      }
    } else if (keyCode==UP) {
      //println("up");
      if (menu) {
        Menu.up();
      } else {
        keys.upPressed();
      }
    } else if (keyCode==LEFT) {
      //println("LEFT");
      keys.leftPressed();
    } else if (keyCode==RIGHT) {
      // println("Right");
      keys.rightPressed();
    }
  }
  if (key==' ') {
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
    one.clear(); 
    timer = millis();
  } else if (key=='l') {
    keys.LPressed();
  } else if (key=='k') {
    keys.KPressed();
  } else if (key =='t') {
    test();
  } else if (key=='y') {
    for (asteriods o : one) {
      o.printdata();
    }
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
  } else if (key=='l') {
    if(player!=null){
    keys.LReleased();
    if (player.laser) {
      player.laserBlast =player.laserBlast - (millis()-player.lastFire);
      player.lastFire=millis();
      player.laser=false;
    }
    }
  } else if ( key=='k') {
    keys.KReleased();
  }
}

void newGame() {
  totalScore=0;
  score=0;
  generateBonusTable();
  setupAsteriods();
  player = new ship(new PVector(width/2, height/2), -PI/2, 0);
  menu = false;
}

void test() {
  print("bonusLevel= ");
  for (int k : bonusLevel) {
    print( " "+k+", ");
  }
  println();


  print("Level: "+level);
  println(" Asteriods Left: "+ one.size());
}