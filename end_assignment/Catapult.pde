class Catapult { //<>//

  Balls  balls;
  Ball   ball;

  PVector position;
  PVector spawPos;
  boolean release;


  Catapult(Balls balls) {
    this.balls = balls;
    position   = new PVector(200, height/2);
    spawPos    = new PVector(position.x, position.y-60);
    release    = true;
  }


  void show() {
    // Draw the body
    fill(#5c2414);
    rect(position.x, position.y, 10, 60);

    // Draw string
    if (ball != null && !release && !ball.release) {
      fill(100);
      beginShape();
      vertex(spawPos.x-10, spawPos.y);
      vertex(ball.position.x-ball.size, ball.position.y);
      vertex(ball.position.x, ball.position.y+ball.size);
      vertex(spawPos.x+10, spawPos.y);
      vertex(ball.position.x+ball.size, ball.position.y);
      vertex(ball.position.x, ball.position.y-ball.size);
      endShape();
    }
  }


  void mouseDraggedEvent(PVector mouse) {
    /*
      Spawn the ball on the catapults
     */

    if (release) {
      if (PVector.dist(mouse, spawPos) <= 40) {
        balls.spawnEvent(mouse);
        if (balls.balls.size() == 0) {
          ball = balls.balls.get(0);
        } else {
          ball = balls.balls.get(balls.balls.size()-1);
        }
      }
      release = false;
    }
  }


  void mouseReleasedEvent(PVector mouse) {
    /*
      Release and shoot the ball
     */

    PVector force   = PVector.sub(mouse, spawPos).div(-3);

    if (ball != null) {
      if (!ball.release) {
        ball.shoot(force);
      }
      release = true;
      ball.release = true;
    }
  }
}
