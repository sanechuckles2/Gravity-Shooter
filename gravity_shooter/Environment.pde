
class Environment {

  void removeLostMissiles() {
    for (int i = 0; i < massBombs.size(); i++) {
      if (massBombs.get(i).x > width || massBombs.get(i).x < 0 || massBombs.get(i).y < 0 || massBombs.get(i).y > height) {
        massBombs.remove(i);
      }
    }
  }

  void runGravityOnPlayerAndMassBombs() {
    for (int g = 0; g < gravityWhells.size(); g++) {

      for (int i = 0; i < players.size(); i++) {
        if (players.get(i).immunityFrames == false) {
          float f = ( bigG * (gravityWhells.get(g).mass * players.get(i).mass) ) / pow( dist(players.get(i).x, players.get(i).y, gravityWhells.get(g).x, gravityWhells.get(g).y), 2);
          float angle = atan( (players.get(i).y - gravityWhells.get(g).y) / (gravityWhells.get(g).x - players.get(i).x) );

          if (players.get(i).x > gravityWhells.get(g).x) {
            players.get(i).xVelocity -= f * (cos(angle));
            players.get(i).yVelocity += f * (sin(angle));
          } else {
            players.get(i).xVelocity += f * (cos(angle));
            players.get(i).yVelocity -= f * (sin(angle));
          }
        }
      }

      for (int i = 0; i < massBombs.size(); i++) {
        float f = ( bigG * (gravityWhells.get(g).mass * massBombs.get(i).mass) ) / pow( dist(massBombs.get(i).x, massBombs.get(i).y, gravityWhells.get(g).x, gravityWhells.get(g).y), 2);
        float angle = atan( (massBombs.get(i).y - gravityWhells.get(g).y) / (gravityWhells.get(g).x - massBombs.get(i).x) );

        if (massBombs.get(i).x > gravityWhells.get(g).x) {
          massBombs.get(i).xVelocity -= f * (cos(angle));
          massBombs.get(i).yVelocity += f * (sin(angle));
        } else {
          massBombs.get(i).xVelocity += f * (cos(angle));
          massBombs.get(i).yVelocity -= f * (sin(angle));
        }
      }
    }
  }

  void runGravityOnGravityWhell() {
    for (int g = 0; g < gravityWhells.size(); g++) {
      for (int i = 0; i < gravityWhells.size(); i++) {
        if (i != g) {

          float f = ( bigG * (gravityWhells.get(i).mass * gravityWhells.get(g).mass) ) / pow( (dist(gravityWhells.get(i).x, gravityWhells.get(i).y, gravityWhells.get(g).x, gravityWhells.get(g).y))*10, 2);
          float angle = atan( (gravityWhells.get(i).y - gravityWhells.get(g).y) / (gravityWhells.get(g).x - gravityWhells.get(i).x) );

          if ( gravityWhells.get(i).x > gravityWhells.get(g).x) {
            gravityWhells.get(i).xVelocity -= f * (cos(angle));
            gravityWhells.get(i).yVelocity += f * (sin(angle));
          } else {
            gravityWhells.get(i).xVelocity += f * (cos(angle));
            gravityWhells.get(i).yVelocity -= f * (sin(angle));
          }
        }
      }
    }
  }

  void runGravitybetweenMassBombs() {
    for (int g = 0; g < massBombs.size(); g++) {
      for (int i = 0; i < massBombs.size(); i++) {
        if (i != g) {

          float force = ( bigG * (massBombs.get(i).mass * massBombs.get(g).mass) ) / pow( (dist(massBombs.get(i).x, massBombs.get(i).y, massBombs.get(g).x, massBombs.get(g).y)), 2);
          float angle = atan( (massBombs.get(i).y - massBombs.get(g).y) / (massBombs.get(g).x - massBombs.get(i).x) );

          if ( massBombs.get(i).x > massBombs.get(g).x) {
            massBombs.get(i).xVelocity -= force * (cos(angle));
            massBombs.get(i).yVelocity += force * (sin(angle));
          } else {
            massBombs.get(i).xVelocity += force * (cos(angle));
            massBombs.get(i).yVelocity -= force * (sin(angle));
          }
        }
      }
    }
  }

  void runGravitybetweenPlayers() {
    for (int g = 0; g < players.size(); g++) {
      for (int i = 0; i < players.size(); i++) {
        if (i != g) {
          if (players.get(i).lives >=1 && players.get(g).lives >= 1) {

            float force = ( bigG * (players.get(i).mass * players.get(g).mass) ) / pow( (dist(players.get(i).x, players.get(i).y, players.get(g).x, players.get(g).y)), 2);
            float angle = atan( (players.get(i).y - players.get(g).y) / (players.get(g).x - players.get(i).x) );

            if ( players.get(i).x > players.get(g).x) {
              players.get(i).xVelocity -= force * (cos(angle));
              players.get(i).yVelocity += force * (sin(angle));
            } else {
              players.get(i).xVelocity += force * (cos(angle));
              players.get(i).yVelocity -= force * (sin(angle));
            }
          }
        }
      }
    }
  }

  void gravityWhellMurging() {
    for (int g = gravityWhells.size() - 1; g >= 0; g--) {
      for (int i = gravityWhells.size() - 1; i >= 0; i--) {
        if (i != g) {
          if (dist(gravityWhells.get(i).x, gravityWhells.get(i).y, gravityWhells.get(g).x, gravityWhells.get(g).y) < (gravityWhells.get(g).radius + gravityWhells.get(g).radius) /2) {
            // gravityWhells.add(new GravityWhell(gravityWhells.get(g).x - gravityWhells.get(g).radius/2, gravityWhells.get(g).y, (gravityWhells.get(i).mass + gravityWhells.get(g).mass) * 1.2, gravityWhells.get(g).radius + gravityWhells.get(i).radius, 0, 0));
            float newWhellPositionX = (gravityWhells.get(g).x + gravityWhells.get(g).x)/2;
            float newWhellPositionY = (gravityWhells.get(g).y + gravityWhells.get(g).y)/2;

            gravityWhells.get(g).mass += gravityWhells.get(i).mass;
            gravityWhells.get(g).radius += gravityWhells.get(i).radius;
            gravityWhells.get(g).xVelocity += gravityWhells.get(i).xVelocity;
            gravityWhells.get(g).yVelocity += gravityWhells.get(i).yVelocity;

            gravityWhells.get(g).x = newWhellPositionX;
            gravityWhells.get(g).y = newWhellPositionY;

            gravityWhells.get(i).mass = 0;
            gravityWhells.get(i).radius = 0;
            gravityWhells.get(i).xVelocity = 0;
            gravityWhells.get(i).yVelocity = 0;

            //gravityWhells.remove(i);
            //i = 0;
            //g = 0;
          }
        }
      }
    }
  }

  void MassBombsMurging() {
    for (int g = massBombs.size() - 1; g >= 0; g--) {
      for (int i = massBombs.size() - 1; i >= 0; i--) {
        if (i != g) {
          if (dist(massBombs.get(i).x, massBombs.get(i).y, massBombs.get(g).x, massBombs.get(g).y) < (massBombs.get(g).size + massBombs.get(g).size) /2) {
            // gravityWhells.add(new GravityWhell(gravityWhells.get(g).x - gravityWhells.get(g).radius/2, gravityWhells.get(g).y, (gravityWhells.get(i).mass + gravityWhells.get(g).mass) * 1.2, gravityWhells.get(g).radius + gravityWhells.get(i).radius, 0, 0));
            float newMassBombPositionX = (massBombs.get(g).x + massBombs.get(g).x)/2;
            float newMassBombPositionY = (massBombs.get(g).y + massBombs.get(g).y)/2;

            massBombs.get(g).mass += massBombs.get(i).mass;
            massBombs.get(g).size += 10;
            massBombs.get(g).xVelocity += massBombs.get(i).xVelocity;
            massBombs.get(g).yVelocity += massBombs.get(i).yVelocity;

            massBombs.get(g).x = newMassBombPositionX;
            massBombs.get(g).y = newMassBombPositionY;

            massBombs.get(i).mass = 0;
            massBombs.get(i).size = 0;
            massBombs.get(i).xVelocity = 0;
            massBombs.get(i).yVelocity = 0;

            //massBombs.remove(i);
            //i = 0;
            //g = 0;
          }
        }
      }
    }
  }

  void playerGravityWhellBounce() {
    for (int g = 0; g < gravityWhells.size(); g++) {
      for (int i = 0; i < players.size(); i++) {
        if (dist(players.get(i).x, players.get(i).y, gravityWhells.get(g).x, gravityWhells.get(g).y) < gravityWhells.get(g).radius/2) {
          players.get(i).xVelocity = -players.get(i).xVelocity;
          players.get(i).yVelocity = -players.get(i).yVelocity;
        }
      }
    }
  }

  void offScreenArrows() {
    for (int i = 0; i < players.size(); i++) {
      if (players.get(i).x > width) {
        fill(players.get(i).r, players.get(i).g, players.get(i).b);
        ellipse(width, players.get(i).y, 20, 20);
      }
      if (players.get(i).x < 0) {
        fill(players.get(i).r, players.get(i).g, players.get(i).b);
        ellipse(0, players.get(i).y, 20, 20);
      }
      if (players.get(i).y > height) {
        fill(players.get(i).r, players.get(i).g, players.get(i).b);
        ellipse(players.get(i).x, height, 20, 20);
      }
      if (players.get(i).y < 0) {
        fill(players.get(i).r, players.get(i).g, players.get(i).b);
        ellipse(players.get(i).x, 0, 20, 20);
      }
      if (players.get(i).x < 0 && players.get(i).y < 0) {
        fill(players.get(i).r, players.get(i).g, players.get(i).b);
        ellipse(0, 0, 20, 20);
      }
      if (players.get(i).x < 0 && players.get(i).y > height) {
        fill(players.get(i).r, players.get(i).g, players.get(i).b);
        ellipse(0, height, 20, 20);
      }
      if (players.get(i).x > width && players.get(i).y > height) {
        fill(players.get(i).r, players.get(i).g, players.get(i).b);
        ellipse(width, height, 20, 20);
      }
      if (players.get(i).x > width && players.get(i).y < 0) {
        fill(players.get(i).r, players.get(i).g, players.get(i).b);
        ellipse(width, 0, 20, 20);
      }
    }
  }

  void playerOnPlayerBounce() {
    for (int i = 0; i < players.size(); i++) {
      if (players.get(i).immunityFrames == false) {
        for (int j = 0; j < players.size(); j++) {
          if (players.get(j).immunityFrames == false) {
            if (i != j && dist(players.get(i).x, players.get(i).y, players.get(j).x, players.get(j).y) <= players.get(i).size + players.get(j).size) {
              if (players.get(i).lives >=1 && players.get(j).lives >= 1) {

                float player1Power = atan(players.get(i).yVelocity/players.get(i).xVelocity);
                float player2Power = atan(players.get(j).yVelocity/players.get(j).xVelocity);

                float momentumTransferXi = (players.get(i).mass * players.get(i).xVelocity) + (players.get(j).mass * players.get(j).xVelocity) / (players.get(i).mass);
                float momentumTransferXj = (players.get(i).mass * players.get(i).xVelocity) + (players.get(j).mass * players.get(j).xVelocity) / (players.get(j).mass);
                float momentumTransferYi = (players.get(i).mass * players.get(i).yVelocity) + (players.get(j).mass * players.get(j).yVelocity) / (players.get(i).mass);
                float momentumTransferYj = (players.get(i).mass * players.get(i).yVelocity) + (players.get(j).mass * players.get(j).yVelocity) / (players.get(j).mass);

                if (player1Power < player2Power) {
                  players.get(i).xVelocity += momentumTransferXi;
                  players.get(i).yVelocity -= momentumTransferYi;
                  players.get(j).xVelocity = 0;
                  players.get(j).yVelocity = 0;
                } else {
                  players.get(j).xVelocity += momentumTransferXj;
                  players.get(j).yVelocity -= momentumTransferYj;
                  players.get(i).xVelocity = 0;
                  players.get(i).yVelocity = 0;
                }
              }
            }
          }
        }
      }
    }
  }

  void miniMap() {
    fill(255, 255, 255, 0);
    stroke(255, 20, 20, 50);
    rect(width/2, height/16, width/9, height/9);
    stroke(255, 255, 255, 50);
    rect(width/2, height/16, width/12, height/12);

    for (int i = 0; i < players.size(); i++) {
      if (players.get(i).lives >=1) {
        fill(players.get(i).r, players.get(i).g, players.get(i).b);
        stroke(players.get(i).r, players.get(i).g, players.get(i).b, 50);
        ellipse(players.get(i).x/12 + width/2 - width/24, players.get(i).y/12 + height/16 - height/24, 1, 1);
      }
    }

    for (int i = 0; i < gravityWhells.size(); i++) {
      fill(200);
      stroke(200);
      ellipse(gravityWhells.get(i).x/12 + width/2 - width/24, gravityWhells.get(i).y/12 + height/16 - height/24, gravityWhells.get(i).mass/15000000, gravityWhells.get(i).mass/15000000);
    }

    for (int i = 0; i < massBombs.size(); i++) {
      stroke(255, 255, 255);
      ellipse(massBombs.get(i).x/12 + width/2 - width/24, massBombs.get(i).y/12 + height/16 - height/24, .1, .1);
    }

    noStroke();
  }

  void playerOutOfBounds() {
    for (int i = 0; i < players.size(); i++) {
      if (players.get(i).x > width + width/9 || players.get(i).x < 0 - width/9 || players.get(i).y > height + height/9|| players.get(i).y < 0 - height/9) {
        if (players.get(i).lives > 0) {
          players.get(i).lives -= 1;
          players.get(i).xVelocity = 0;
          players.get(i).yVelocity = 0;
          players.get(i).x = players.get(i).initialX;
          players.get(i).y = players.get(i).initialY;
          players.get(i).immunityFrames = true;
        } else {
          players.remove(i);
          i = 0;
        }
      }
    }
  }

  void playerOnMassBombsBounce() {
    for (int j = 0; j < players.size(); j++) {
      if (players.get(j).immunityFrames == false) {
        for (int i = 0; i < massBombs.size(); i++) {
          if (dist(massBombs.get(i).x, massBombs.get(i).y, players.get(j).x, players.get(j).y) < massBombs.get(i).size) {

            //float momentumTransferX = (players.get(j).mass * players.get(j).xVelocity) + (massBombs.get(i).mass * massBombs.get(i).xVelocity) / (players.get(j).mass);
            //float momentumTransferY = (players.get(j).mass * players.get(j).yVelocity) + (massBombs.get(i).mass * massBombs.get(i).yVelocity) / (players.get(j).mass);

            float basicMomentumTransferX = players.get(j).xVelocity + massBombs.get(i).xVelocity;
            float basicMomentumTransferY = players.get(j).xVelocity + massBombs.get(i).xVelocity;

            players.get(j).xVelocity += basicMomentumTransferX;
            players.get(j).yVelocity -= basicMomentumTransferY;

            massBombs.get(i).xVelocity = 0;
            massBombs.get(i).yVelocity = 0;
          }
        }
      }
    }
  }

  void massBombCulling() {
    for (int i = 0; i < massBombs.size(); i++) {
      if (massBombs.get(i).size < 1) {
        massBombs.remove(i);
        i = 0;
      }
    }
  }

  void hearts() {
    for (int i = 0; i < players.size(); i++) {
      for (int j = 0; j < players.get(i).lives; j++) {
        fill(players.get(i).r, players.get(i).g, players.get(i).b, 200);
        ellipse(width-(j*width/55) - width/75, (i + 1) * height/70, 10, 10);
      }
    }
  }

  void gameOverCondition() {
    for (int i = 0; i < players.size(); i++) {
      if (players.get(i).lives <= 0) {
        players.remove(i);
        i = 0;
      }
    }
    if (players.size() == 1) {
      players.get(0).winner = true;
    }

    for (int i = 0; i < players.size(); i++) {
      if (players.get(i).winner == true) {
        gamePhase = gamePhase.gameWon;
      }
    }
  }

  void runAllObjects() {
    for (int i = 0; i < players.size(); i++) {
      if (players.get(i).lives >= 1) {
        players.get(i).run();
      }
    }
    for (int i = 0; i < massBombs.size(); i++) {
      massBombs.get(i).run();
    }
    for (int i = 0; i < gravityWhells.size(); i++) {
      if (gravityWhells.get(i).mass > 1) {
        gravityWhells.get(i).run();
      }
    }
  }

  void runAllPhysics() {
    // removeLostMissiles();
    // playerGravityWhellBounce();
    runGravityOnPlayerAndMassBombs();
    offScreenArrows();
    playerOnPlayerBounce();
    miniMap();
    runGravityOnGravityWhell();
    runGravitybetweenMassBombs();
    runGravitybetweenPlayers();
    gravityWhellMurging();
    playerOutOfBounds();
    playerOnMassBombsBounce();
    hearts();
    MassBombsMurging();
    massBombCulling();

    gameOverCondition();
  }

  void runAll() {
    runAllPhysics();
    runAllObjects();
  }

  void pausedGameRun() {
    for (int i = 0; i < players.size(); i++) {
      players.get(i).display();
    }
    for (int i = 0; i < massBombs.size(); i++) {
      massBombs.get(i).display();
    }
    for (int i = 0; i < gravityWhells.size(); i++) {
      gravityWhells.get(i).display();
    }
    miniMap();
    hearts();
  }
}
