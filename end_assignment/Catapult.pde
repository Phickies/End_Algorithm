class Catapult {

  PVector position;
  PVector spawPos;
  boolean release;


  Catapult(PVector newPos) {
    position = new PVector(newPos.x, newPos.y);
    spawPos  = new PVector(position.x, position.y-60);
    release  = true;
  }


  void show() {
    fill(#5c2414);
    rect(position.x, position.y, 10, 60);
  }


  void update(Balls balls) {
    if (!release && !balls.getRelease() && balls.balls != null) {
      drawString();
    }
  }


  void mouseDraggedEvent(PVector mouse, Balls balls) {
    /*
      Spawn the ball on the catapults
    */

    if (release) {
      if (PVector.dist(mouse, spawPos) <= 40) {
        balls.spawnEvent(mouse);
      }
      release = false;
    }
  }


  void mouseReleasedEvent(PVector mouse, Balls balls) {
    /*
      Release and shoot the ball
    */

    PVector force   = PVector.sub(mouse, spawPos).div(-5);

    if (!balls.getRelease()) {
      balls.shoot(force);
    }
    release = true;
    balls.setRelease(true);
  }


  void drawString() {
    fill(0);
    beginShape();
    vertex(spawPos.x-10, spawPos.y);
    vertex(balls.getPositionX()-balls.getSize(), balls.getPositionY());
    vertex(balls.getPositionX(), balls.getPositionY()+balls.getSize());
    vertex(spawPos.x+10, spawPos.y);
    vertex(balls.getPositionX()+balls.getSize(), balls.getPositionY());
    vertex(balls.getPositionX(), balls.getPositionY()-balls.getSize());
    endShape();
  }
}
