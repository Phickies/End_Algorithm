class Catapult {

  PVector spawPos  = new PVector();
  boolean release  = true;

  Catapult() {
  }

  void show() {
    PVector position = new PVector(150, height-250);
    fill(#5c2414);
    rect(position.x, position.y, 10, 60);
    spawPos.set(position.x, position.y-60);
  }

  void update(Balls balls) {
    if (!release && !balls.getRelease()) {
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
  
  void drawString(){
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
