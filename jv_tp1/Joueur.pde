
class Joueur {

  PVector location;
  float rayon = 20;
  float vitesse = 200; 

  boolean versLaGauche = false;
  boolean versLaDroite = false;

  Joueur(float x, float y) {
    location = new PVector(x, y);
  }

  void update(int dt) {
    float dtSecondes = dt / 1000.0;

    if (versLaGauche) {
      location.x -= vitesse * dtSecondes;
    }
    if (versLaDroite) {
      location.x += vitesse * dtSecondes;
    }
    location.x = constrain(location.x, rayon, width - rayon);
  }

  void display() {
    noStroke();
    fill(0, 200, 0);
    rect(location.x - rayon, location.y - rayon, rayon * 2, rayon * 2);
  }
}
