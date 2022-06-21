class Catapult {

  Balls balls;
  Ball  ball;

  PVector position;
  PVector spawPos;
  boolean release;


  Catapult(PVector newPos, Balls balls) {
    this.balls = balls;
    position = new PVector(newPos.x, newPos.y);
    spawPos  = new PVector(position.x, position.y-60);
    release  = true;
  }


  void update() {
    if (!release && !ball.release) {
      // Draw string
      fill(255);
      beginShape();
      vertex(spawPos.x-10, spawPos.y);
      vertex(ball.position.x-ball.size, ball.position.y);
      vertex(ball.position.x, ball.position.y+ball.size);
      vertex(spawPos.x+10, spawPos.y);
      vertex(ball.position.x+ball.size, ball.position.y);
      vertex(ball.position.x, ball.position.y-ball.size);
      endShape(); //<>//
    }
  } //<>//


  void show() {
    fill(#5c2414);
    rect(position.x, position.y, 10, 60);
  }


  void mouseDraggedEvent(PVector mouse) {
    /*
      Spawn the ball on the catapults
     */

    if (release) {
      if (PVector.dist(mouse, spawPos) <= 40) {
        balls.spawnEvent(mouse);
        ball = balls.balls.get(balls.balls.size()-1);
      }
      release = false;
    }
  }


  void mouseReleasedEvent(PVector mouse) {
    /*
      Release and shoot the ball
     */

    if (balls.balls.size() > 0) {
      PVector force   = PVector.sub(mouse, spawPos).div(-3);

      if (!ball.release) {
        ball.applyForce(force);
      }
      release = true; //<>//
      ball.release = true;
    }
  }
} //<>//
