// Program for end assignment for Algorithm Course
// All documents and code are written by Tran Quy An

int   delta_time;

float terrian_roughness   = 0.001;
float gravitational_field = 0.2;
int   star_density        = 1080;

Stars       stars;
Environment environment;
Balls       balls;
Catapult    catapult;


void setup() {
  fullScreen();
  noStroke();
  ellipseMode(RADIUS);
  rectMode   (RADIUS);

  stars       = new Stars(width/2, height/2, star_density);
  environment = new Environment(terrian_roughness, gravitational_field);
  balls       = new Balls();
  catapult    = new Catapult(balls);
}


void draw() {
  background(10);

  balls.update();
  environment.update(balls);

  stars.show();
  environment.show();
  balls.show();
  catapult.show();
}


void mousePressed() {
  environment.obstacles.mousePressedEvent(new PVector(mouseX, mouseY));
}


void mouseDragged() {
  catapult.mouseDraggedEvent(new PVector(mouseX, mouseY));
}


void mouseReleased() {
  catapult.mouseReleasedEvent(new PVector(mouseX, mouseY));
}
