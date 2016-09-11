class Menu {

  PFont Title;
  String selected="game";
  int select =0;
  String selection[] = {"game", "score", "exit"};
  boolean Score = false;

  Menu() {

    Title = loadFont("Stencil-100.vlw");
  }

  void Draw() {
    if (Score) {
    } else {
      textFont(Title, 100);
      fill(255);
      textAlign(CENTER);
      char t = 187;
      text("ASTERIOD\n\n", width/2, 150);

      textFont(Title, 70);
      if (selected.equals("game")) {
        text(""+t+"New Game", width/2-30, 300);
      } else {
        text(" New Game", width/2-30, 300);
      }
      if (selected.equals("score")) {
        text(""+t+"High Score", width/2, 370);
      } else {
        text(" High Score", width/2, 370);
      }
      if (selected.equals("exit")) {
        text(""+t+"Exit", width/2-130, 440);
      } else {
        text(" Exit", width/2-130, 440);
      }
    }
  }

  void down() {
    select++;
    selected=selection[select%3];
  }

  void up() {
    select--; 
    if (select<0)select=2;
    selected=selection[select];
  }
}