GamePhasesCaptain gamePhasesCaptain;
GamePhase gamePhase = GamePhase.title;

Environment envirnment;

ArrayList<Player> players;
ArrayList<MassBomb> massBombs;
ArrayList<GravityWhell> gravityWhells;

float bigG = 6.67408 * pow(10, -11);

boolean gameOver = false;
boolean gamePaused = false;

enum GamePhase {
  opening, 
    title, 
    settings, 
    playerSelect, 
    game, 
    gameWon, 
    pause,
}

void setup() {
  fullScreen();
  smooth(10);
  gravityWhells = new ArrayList<GravityWhell>();
  massBombs = new ArrayList<MassBomb>();
  players = new ArrayList<Player>();
  gamePhasesCaptain = new GamePhasesCaptain();
  envirnment = new Environment();
}

void draw() {
  background(0);
  rectMode(CENTER);
  textAlign(CENTER);
  imageMode(CENTER);
  noStroke();
  switch(gamePhase) {
  case title:
    gamePhasesCaptain.title();
    break;
  case game:
    gamePhasesCaptain.runGame();
    break;
  case playerSelect:
    gamePhasesCaptain.playerSelect();
    break;
  case gameWon:
    gamePhasesCaptain.gameWon();
    break;
  case pause:
    envirnment.pausedGameRun();
    break;
  case settings:
    break;
  }
}


void testLevel() {
  players.add(new Player(width/4, height/4, .07, 12, 'a', 'd', 'w', ' ', 255, 10, 10, "Player 1"));
  players.add(new Player(width/4 * 3, height/4 * 3, .07, 12, 'j', 'l', 'i', '.', 10, 10, 255, "Player 2"));
  //players.add(new Player(width/6 * 5, height/6 * 5, .07, 12, 'j', 'l', 'i', '.', 10, 255, 10));
  //players.add(new Player(width/6, height/6, .07, 12, 'j', 'l', 'i', '.', 255, 255, 255));

  gravityWhells.add(new GravityWhell(width/4 * 3, height/2, 1500000, 50, 0, 0));
  gravityWhells.add(new GravityWhell(width/4, height/2, 1500000, 50, 0, 0));

  //gravityWhells.add(new GravityWhell(width/2, height/4 * 3, 1500000, 50, 0, 0));
  //gravityWhells.add(new GravityWhell(width/2, height/4, 1500000, 50, 0, 0));
}

void keyPressed() {
  for (int i = 0; i < players.size(); i++) { 
    players.get(i).playerKeyPressed();
  }
}

void keyReleased() {
  for (int i = 0; i < players.size(); i++) { 
    players.get(i).playerKeyReleased();
  }
  if (gamePhase == gamePhase.game || gamePhase == gamePhase.pause) {
    gamePhasesCaptain.keyReleasedPauses();
  }
}
