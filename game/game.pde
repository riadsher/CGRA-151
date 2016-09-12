import java.awt.event.KeyEvent; //<>// //<>//

ArrayList<asteriods> one = new ArrayList<asteriods>();
ArrayList<bullet> bullets = new ArrayList<bullet>();
Menu Menu;

keys keys = new keys(); 
ship player;


int lastFire=0;

boolean PlayerDead = false;

boolean menu = true;


void setup() {
  Menu= new Menu();
  size(600, 600);
  setupAsteriods();


  frameRate(60);
}

void setupAsteriods() {
  one.clear();
  for (int i = 0; i<10; i++)
    one.add(new asteriods(20, new PVector(random(width), random(height)), random(2*PI), random(0.5, 3)));
}


void draw() {
  checkKeys();

  background(0);

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
  } else if (!PlayerDead) {

    player.move();
    player.Draw();

    contacts();
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


      if ((!bulletRemove.contains(a))&&p.getPolygon().contains(a.loc.x, a.loc.y)) {
        bulletRemove.add(a);
        add.addAll(p.hit());

        remove.add(p);
      }
    }
  }

  for (asteriods p : one) {
    if (player.Collison(p.getPolygon())) {
      PlayerDead= true;
    }
  }

  bullets.removeAll(bulletRemove);
  one.removeAll(remove);
  one.addAll(add);
}

void checkKeys() {
  if (keys.space()) { 
    if ((millis()-lastFire)>100) {
      bullets.add(player.fire());
      lastFire=millis();
    }
  }
  if (keys.down()) {
    player.chaSpeed(-0.5);
  }
  if (keys.up()) {
    player.chaSpeed(+0.5);
  }
  if (keys.left()) {
    player.turn(radians(degrees(player.ang)-5));
  }
  if (keys.right()) {
    player.turn(radians(degrees(player.ang)+5));
  }
}

void keyPressed() {
  if (key==CODED) {
    if (keyCode==DOWN) {
      if (menu) {
        Menu.down();
      } else {
        keys.downPressed();
      }
    }
    if (keyCode==UP) {
      if (menu) {
        Menu.up();
      } else {
        keys.upPressed();
      }
    }
    if (keyCode==LEFT) {
      keys.leftPressed();
    }
    if (keyCode==RIGHT) {
      keys.rightPressed();
    }
  }
  if (key==' ') {
    if (menu) {
      if (Menu.select==0) {
        player = new ship(new PVector(width/2, height/2), -PI/2, 0);
        menu = false;
      } else if (Menu.select==1) {
        // Menu.Score();
      } else if (Menu.select==2) {
        System.exit(0);
      }
    } else {
      keys.spacePressed();
    }
  }
  if (key=='r') {
    PlayerDead = false;
    menu = true;
    setupAsteriods();
  }
}

void keyReleased() {
  if (key==CODED) {
    if (keyCode==DOWN) {
      keys.downReleased();
    }
    if (keyCode==UP) {
      keys.upReleased();
    }
    if (keyCode==LEFT) {
      keys.leftReleased();
    }
    if (keyCode==RIGHT) {
      keys.rightReleased();
    }
  }
  if (key==' ') {
    keys.spaceReleased();
  }
}