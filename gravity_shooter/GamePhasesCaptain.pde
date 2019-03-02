
class GamePhasesCaptain {
  PImage pressAnyKey = loadImage("Press-any-key-to-continue.png");
  PImage starsBackground = loadImage("background-menu.jpg");
  
  boolean menuTransition = false;

  int playerAmount = 2;
  int arenaLayout = 1;

  char pOneMove = 'w';
  char pTwoMove = '8';
  char pThreeMove = 'i';
  char pFourMove = 't';

  char pOneLeft = 'a';
  char pTwoLeft = '4';
  char pThreeLeft = 'j';
  char pFourLeft = 'f';

  char pOneRight = 'd';
  char pTwoRight = '6';
  char pThreeRight = 'l';
  char pFourRight = 'h';

  char pOneShoot = ' ';
  char pTwoShoot = '0';
  char pThreeShoot = '.';
  char pFourShoot = 'n';

  void setupDirector() {
    starsBackground.resize(width, height);
  }

  void title() {
    background(255);
    image(pressAnyKey, width/2, height * (3/4.0));
    if (keyPressed) {
      gamePhase = GamePhase.playerSelect;
    }
  }

  void playerSelect() {
    fill(255);
    text("Choose how many players", width/2, height * (1/10.0));
    text("Press ENTER to continue", width*(9/10.0), height * (7/8.0));

    for (int i = 1; i <= 3; i++) {
      strokeWeight(5);
      fill(255);
      if (playerAmount == i+1) {
        stroke(255, 20, 20);
      } else {
        noStroke();
      }
      rect(width * (i/4.0), height/3, width/10, height/10, 20, 20, 20, 20);
      fill(0, 0, 255);
      text(i+1, width * (i/4.0), height/3);
      if (mousePressed) {
        if (mouseX < (width * (i/4.0)) + width/20 && mouseX > (width * (i/4.0)) - width/20 && mouseY < height/3 + height/20 && mouseY > height/3 - height/20) {
          playerAmount = i+1;
        }
      }
    }

    if (keyPressed) {
      if (key == ENTER) {
        gamePhase = gamePhase.arenaSelect;
      }
    }
  }

  void arenaSelect() {
    background(starsBackground);
    fill(255);
    text("Choose arena layout", width/2, height * (6/9.0));

    for (int i = 1; i <= 2; i++) {
      strokeWeight(5);
      fill(255);
      if (arenaLayout == i) {
        stroke(255, 20, 20);
      } else {
        noStroke();
      }
      rect(width * (i/3.0), height*(3/4.0), width/10, height/10, 20, 20, 20, 20);
      fill(0, 0, 255);
      text(i, width * (i/3.0), height*(3/4.0));
      if (mousePressed) {
        if (mouseX < (width * (i/3.0)) + width/20 && mouseX > (width * (i/3.0)) - width/20 && mouseY < height*(3/4.0) + height/20 && mouseY > height*(3/4.0) - height/20) {
          arenaLayout = i;
        }
      }
    }
    if (keyPressed) {
      if (key == ENTER) {
        loadSelectedSettings();
        gamePhase = gamePhase.game;
      }
    }
  }

  void loadSelectedSettings() {
    if (playerAmount == 2) {
      players.add(new Player(width/4, height/4, .07, 12, pOneLeft, pOneRight, pOneMove, pOneShoot, 255, 10, 10, "Player 1"));
      players.add(new Player(width/4 * 3, height/4 * 3, .07, 12, pTwoLeft, pTwoRight, pTwoMove, pTwoShoot, 10, 10, 255, "Player 2"));
    } else if (playerAmount == 3) {
      players.add(new Player(width/4, height/4, .07, 12, pOneLeft, pOneRight, pOneMove, pOneShoot, 255, 10, 10, "Player 1"));
      players.add(new Player(width/4 * 3, height/4 * 3, .07, 12, pTwoLeft, pTwoRight, pTwoMove, pTwoShoot, 10, 10, 255, "Player 2"));
      players.add(new Player(width/6 * 5, height/6 * 5, .07, 12, pThreeLeft, pThreeRight, pThreeMove, pThreeShoot, 10, 255, 10, "Player 3"));
    } else {
      players.add(new Player(width/4, height/4, .07, 12, pOneLeft, pOneRight, pOneMove, pOneShoot, 255, 10, 10, "Player 1"));
      players.add(new Player(width/4 * 3, height/4 * 3, .07, 12, pTwoLeft, pTwoRight, pTwoMove, pTwoShoot, 10, 10, 255, "Player 2"));
      players.add(new Player(width/6 * 5, height/6 * 5, .07, 12, pThreeLeft, pThreeRight, pThreeMove, pThreeShoot, 10, 255, 10, "Player 3"));
      players.add(new Player(width/6, height/6, .07, 12, pFourLeft, pFourRight, pFourMove, pFourShoot, 255, 255, 255, "Player 4"));
    }

    if (arenaLayout == 1) {
      gravityWhells.add(new GravityWhell(width/4 * 3, height/2, 50000000, 50, 0, 0));
      gravityWhells.add(new GravityWhell(width/4, height/2, 50000000, 50, 0, 0));
    } else if (playerAmount == 2) {
      gravityWhells.add(new GravityWhell(width/4 * 3, height/2, 35000000, 50, 0, 0));
      gravityWhells.add(new GravityWhell(width/4, height/2, 35000000, 50, 0, 0));
      gravityWhells.add(new GravityWhell(width/2, height/4 * 3, 35000000, 50, 0, 0));
      gravityWhells.add(new GravityWhell(width/2, height/4, 35000000, 50, 0, 0));
    }
  }

  void game() {
    envirnment.runAll();
  }

  void keyReleasedPauses() {
    if (key == '`') {
      if (gamePaused == false) {
        gamePhase = gamePhase.pause;
      } else {
        gamePhase = gamePhase.game;
      }
      gamePaused =! gamePaused;
    }
  }

  void gamePaused() {
  }

  void gameWon() {
    fill(255);
    for (int i = 0; i < players.size(); i++) {
      textSize(100);
      fill(players.get(i).r, players.get(i).g, players.get(i).b);
      text(players.get(i).playerName + " Won", width/2, height/2);
    }
  }
}
