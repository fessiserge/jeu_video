
Joueur joueur;
Ennemi ennemi;

int currentTime;
int previousTime;
int deltaTime;

void setup() {
  size(800, 600);

  currentTime = millis();
  previousTime = millis();

  joueur = new Joueur(200, height - 30);

  PVector ancrage = new PVector(width / 2, 200);
  ennemi = new Ennemi(ancrage, 180); 
  ennemi.setDistance(200, 240);
}

void draw() {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
  
  background(10);

  ennemi.update(deltaTime, joueur.location);
  joueur.update(deltaTime);

  ennemi.display();
  joueur.display();

}

void keyPressed() {
  if (key == 'a' || key == 'A') joueur.versLaGauche = true;
  if (key == 'd' || key == 'D') joueur.versLaDroite = true;
}

void keyReleased() {
  if (key == 'a' || key == 'A') joueur.versLaGauche = false;
  if (key == 'd' || key == 'D') joueur.versLaDroite = false;
}
