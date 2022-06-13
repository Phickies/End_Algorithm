// Program for end assignment for Algorithm Course
// Written by Tran Quy An.
Ground   ground;
Wall     wall;
Balls    balls;
Catapult catapult;


void setup() {
  last_time = System.nanoTime();
  
  size(700,1000);
  noStroke();
  ellipseMode(RADIUS);
  rectMode   (RADIUS);
  ground      = new Ground();
  wall        = new Wall();
  balls       = new Balls();
  catapult    = new Catapult();
}


void draw() {
  // Calculate delta_time (TimeStep).
  long time   = System.nanoTime();
  delta_time  = ((int) ((time - last_time) / 1000000))/10;
  last_time   = time;

  background(200);
  catapult.update(balls);
  balls.update();
  ground.update(balls);
  wall.update(balls);
  catapult.show();
  balls.show();
}


void mouseDragged() {
  catapult.mouseDraggedEvent(new PVector(mouseX, mouseY), balls);
}


void mouseReleased() {
  catapult.mouseReleasedEvent(new PVector(mouseX, mouseY), balls);
}
