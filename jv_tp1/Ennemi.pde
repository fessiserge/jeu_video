enum StatutMonstre {
  DORMANT,
  HOSTILE
}

class Ennemi {

  PVector location;
  PVector velocity;
  PVector acceleration;

  PVector ancrage;      
  float longueurNormal; 
  float longueurMax;

  float raideur = 0.12;       
  float amortissement = 0.95;  
  float forceAttaque = 0.8;   
  float gravite = 0.4;       

  float rayon = 18;

  StatutMonstre statut = StatutMonstre.DORMANT;

  float seuilProche = 190;
  float seuilLoin = 210;

  Ennemi(PVector ancre, float repos) {
    ancrage = ancre.copy();
    longueurNormal = repos;
    longueurMax = longueurNormal + 100;

    location = new PVector(ancrage.x, ancrage.y + longueurNormal);
    velocity = new PVector();
    acceleration = new PVector();
  }

  void setDistance(float proche, float loin) {
    seuilProche = proche;
    seuilLoin = loin;
  }

  void applyForce(PVector f) {
    acceleration.add(f);
  }

  void miseAJourStatut(float distanceAuJoueur) {
    switch (statut) {
      case DORMANT:
        if (distanceAuJoueur < seuilProche) {
          statut = StatutMonstre.HOSTILE;
        }
        break;
      case HOSTILE:
        if (distanceAuJoueur > seuilLoin) {
          statut = StatutMonstre.DORMANT;
        }
        break;
    }
  }

  PVector calculTensionRessort() {
    PVector tige = PVector.sub(location, ancrage);
    float longueur = tige.mag();
    float delta = longueur - longueurNormal;

    PVector direction = tige.copy();
    direction.normalize();

    return direction.mult(-raideur * delta);
  }

  PVector calculPoursuite(PVector cible) {
    PVector versLaCible = PVector.sub(cible, location);
    versLaCible.normalize();
    versLaCible.mult(forceAttaque);
    return versLaCible;
  }

  void contraindreLongueur() {
    PVector tige = PVector.sub(location, ancrage);

    if (tige.mag() > longueurMax) {
      tige.setMag(longueurMax);
      location = PVector.add(ancrage, tige);
    }
  }

  void update(int dt, PVector cible) {
    float d = PVector.dist(location, cible);
    miseAJourStatut(d);

    applyForce(new PVector(0, gravite));
    applyForce(calculTensionRessort());

    if (statut == StatutMonstre.HOSTILE) {
      applyForce(calculPoursuite(cible));
    }

    velocity.add(acceleration);
    velocity.mult(amortissement);
    location.add(velocity);
    acceleration.mult(0);

    contraindreLongueur();
  }

  void display() {
    stroke(200);
    line(ancrage.x, ancrage.y, location.x, location.y);

    noStroke();
    fill(150);
    circle(ancrage.x, ancrage.y, 10);

    noStroke();
    color teinte = (statut == StatutMonstre.HOSTILE) ? color(220, 30, 30) : color(180);
    fill(teinte);
    circle(location.x, location.y, rayon * 2);
  }
}
