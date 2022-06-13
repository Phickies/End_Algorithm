int MAX_BALL  = 100;

class Balls {

  Ball[] ball = new Ball[MAX_BALL];

  int generated;

  Balls() {
  }


  void show() {
    for (int k=0; k<generated; k++) {
      ball[k].show();
    }
  }


  void shoot(PVector force) {
    ball[generated-1].shoot(force);
  }
  
  
  void update() {
    // Collision detection
    for (int k=0; k<generated-1; k++) {
      for (int l=k+1; l<generated; l++) {
        collide( ball[k], ball[l]);
      }
    }

    // Movement
    for (int k=0; k<generated; k++) {
      ball[k].update();
    }
  }


  void collide(Ball ball1, Ball ball2) {
    /*
      Bouncing with each other;
      Code from online, document from example Bouncing Ball Processing.
    */
    float distance = PVector.dist(ball1.position, ball2.position);
    float minDist = ball2.size + ball1.size;
   
    if (distance < minDist) {
      float angle = atan2(ball2.position.y - ball1.position.y, ball2.position.x - ball1.position.x);
      float targetX = ball1.position.x + cos(angle) * minDist;
      float targetY = ball1.position.y + sin(angle) * minDist;
      float ax = (targetX - ball2.position.x) * (pow(ball1.spring, 2)+pow(ball2.spring, 2));
      float ay = (targetY - ball2.position.y) * (pow(ball1.spring, 2)+pow(ball2.spring, 2));
      ball1.speed.sub(ax,ay);
      ball2.speed.add(ax,ay);
    }
  }


  void spawnEvent(PVector mouse) {
    // A new ball is only created here!
    if ( generated < MAX_BALL) {
      Ball newCandidate = new Ball(mouse.x, mouse.y);

      boolean addThisBall = true;

      for (int i = 0; i<generated; i++) {
        if (PVector.dist(ball[i].position, newCandidate.position) < (ball[i].size + newCandidate.size)) {
          addThisBall = false;
        }
      }

      if (addThisBall) {
        ball[generated] = newCandidate;
        generated++;
      }
    }
  }


  void setRelease(boolean isRelease) {
    ball[generated-1].setRelease(isRelease);
  }


  boolean getRelease() {
    return ball[generated-1].getRelease();
  }


  float getPositionX() {
    return ball[generated-1].getPositionX();
  }


  float getPositionY() {
    return ball[generated-1].getPositionY();
  }


  float getSize() {
    return ball[generated-1].getSize();
  }
}
