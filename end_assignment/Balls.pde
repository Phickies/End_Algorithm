class Balls {

  ArrayList<Ball> balls;

  int generated;

  Balls() {
    balls = new ArrayList<Ball>();
  }


  void show() {
    for (Ball ball : balls) {
      ball.show();
    }
  }


  void shoot(PVector force) {
    balls.get(balls.size()-1).shoot(force);
  }


  void update() {
    // Collision detection
    for (Ball ball : balls) {
      collide( ball, balls);
    }

    // Movement
    for (int i = balls.size()-1; i>=0; i--) {
      balls.get(i).update();
      if (balls.get(i).collision) {
        balls.remove(i);
      }
    }
  }


  void collide(Ball ball, ArrayList<Ball> others) {
    /*
      Bouncing with each other;
     */

    for (Ball other : others) {

      float distance = PVector.dist(ball.position, other.position);
      float minDist = other.size + ball.size;

      if (distance > 0 && distance < minDist) {
        float angle = atan2(other.position.y - ball.position.y, other.position.x - ball.position.x);

        float targetX = ball.position.x + cos(angle) * minDist;
        float targetY = ball.position.y + sin(angle) * minDist;

        float ax = (targetX - other.position.x) * (pow(ball.spring, 2)+pow(other.spring, 2));
        float ay = (targetY - other.position.y) * (pow(ball.spring, 2)+pow(other.spring, 2));

        ball.speed.sub(ax, ay);
        other.speed.add(ax, ay);
      }
    }
  }


  void spawnEvent(PVector mouse) {
    /*
      A new ball is only created here!
     */

    Ball newCandidate = new Ball(mouse.x, mouse.y);

    boolean addThisBall = true;

    for (int i = 0; i<balls.size(); i++) {
      if (PVector.dist(balls.get(i).position, newCandidate.position) < (balls.get(i).size + newCandidate.size)) {
        addThisBall = false;
      }
    }

    if (addThisBall) {
      balls.add(newCandidate);
    }
  }


  void setRelease(boolean isRelease) { //<>//
    if (balls.size() != 0) {
      balls.get(balls.size()-1).setRelease(isRelease);
    }
  }


  boolean getRelease() {
    if (balls.size() == 0) {
      return true;
    } else {
      return balls.get(balls.size()-1).getRelease();
    }
  }


  float getPositionX() {
    return balls.get(balls.size()-1).getPositionX();
  }


  float getPositionY() {
    return balls.get(balls.size()-1).getPositionY();
  }


  float getSize() {
    return balls.get(balls.size()-1).getSize();
  }
}
