// Program for end assignment for Algorithm Course
// All documents and code are written by Tran Quy An

int  delta_time;

float terrian_roughness   = 0.002;
float gravitational_field = 0.2;

Environment environment;
Balls       balls;
Catapult    catapult;


void setup() {
  fullScreen();
  noStroke();
  ellipseMode(RADIUS);
  rectMode   (RADIUS); 
  
  environment = new Environment(terrian_roughness, gravitational_field);
  balls       = new Balls();
  catapult    = new Catapult(balls);
}


void draw() {
  background(113, 188, 225); 
  
  balls.update();
  environment.update(balls); 
  
  balls.show();
  environment.show();
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
