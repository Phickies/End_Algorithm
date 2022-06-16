// Program for end assignment for Algorithm Course
// Written by Tran Quy An.
Ground   ground;
Walls    walls;
Balls    balls;
Catapult catapult;


void setup() {
  last_time = System.nanoTime();
  
  size(2000,2000);
  noStroke();
  ellipseMode(RADIUS);
  rectMode   (RADIUS);
  ground      = new Ground();
  walls       = new Walls();
  balls       = new Balls();
  catapult    = new Catapult(new PVector(150, height-250));
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
  walls.update(balls);
  catapult.show();
  balls.show();
  ground.show();
  walls.show();
}

void mousePressed(){
  walls.mousePressedEvent(new PVector(mouseX, mouseY));
}


void mouseDragged() {
  catapult.mouseDraggedEvent(new PVector(mouseX, mouseY), balls);
}


void mouseReleased() {
  catapult.mouseReleasedEvent(new PVector(mouseX, mouseY), balls);
}
