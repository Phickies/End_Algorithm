// Program for end assignment for Algorithm Course
// Written by Tran Quy An.

Ground    ground;
Obstacles obstacles;
Balls     balls;
Catapult  catapult;


void setup() {
  fullScreen();
  noStroke();
  ellipseMode(RADIUS);
  rectMode   (RADIUS);
  last_time   = System.nanoTime();
  ground      = new Ground();
  obstacles   = new Obstacles(width/3, width);
  balls       = new Balls();
  catapult    = new Catapult(new PVector(150, height-350), balls);
}


void draw() {
  background(0);
  catapult.update();
  balls.update();
  ground.update(balls);
  obstacles.update(balls);
  catapult.show();
  ground.show();
  balls.show();

  obstacles.show();
}


void mousePressed() {
  obstacles.mousePressedEvent(new PVector(mouseX, mouseY));
}


void mouseDragged() {
  catapult.mouseDraggedEvent(new PVector(mouseX, mouseY));
}


void mouseReleased() {
  catapult.mouseReleasedEvent(new PVector(mouseX, mouseY));
}
