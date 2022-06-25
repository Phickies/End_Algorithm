class Ground {

  ArrayList<PVector> points;
  PVector            target;

  float INCREMENT = 0.002;
  float yoff;


  Ground() {
    points = new ArrayList<PVector>();
    target = new PVector();
  }


  void update(Balls balls) {

    for (Ball ball : balls.balls) {
      if (isCollide(ball)) {
        if (ball.velocity.mag() >= 30) {
          ball.collision = true;
        } else {
          reflect(ball);
        }
      }
    }
    for (Particle particle : balls.particles) {
      if (isCollide(particle)) {
        reflect(particle);
      }
    }
  }


  void show() {

    fill(0, 150, 0);

    beginShape();
    yoff = 0.0;
    {
      for (int i=0; i<width; i++) {
        float y = map(noise(yoff), 0, 1, height/2, height);
        points.add(new PVector(i, y));
        vertex(i, y);
        yoff += INCREMENT;
      }
      vertex(width, height);
      vertex(0, height);
    }
    endShape();
  }


  void reflect(Ball ball) {
    PVector n = PVector.sub(target, ball.position);
    n.normalize();

    float   a = PVector.dot(n, ball.velocity);
    PVector t = PVector.mult(PVector.mult(n, a), 2);
    PVector r = PVector.sub(ball.velocity, t);
    ball.velocity.set(r);
  }


  void reflect(Particle ball) {
    PVector n = PVector.sub(target, ball.position);
    n.normalize();

    float   a = PVector.dot(n, ball.velocity);
    PVector t = PVector.mult(PVector.mult(n, a), 2);
    PVector r = PVector.sub(ball.velocity, t);
    ball.velocity.set(r);
  }



  boolean isCollide(Ball ball) {
    for (int i = int(ball.position.x - ball.size);
      i < ball.position.x + ball.size; i++)
    {
      if (i<0) {
        i=0;
      } else if (i>points.size()) {
        i=points.size()-1;
      }
      float dist = PVector.dist(points.get(i), ball.position);
      if (dist < ball.size) {
        target.set(points.get(i));
        return true;
      }
    }
    return false;
  }


  boolean isCollide(Particle ball) {
    for (int i = int(ball.position.x - ball.size);
      i < ball.position.x + ball.size; i++)
    {
      if (i<0) {
        i=0;
      } else if (i>points.size()) {
        i=points.size()-1;
      }
      float dist = PVector.dist(points.get(i), ball.position);
      if (dist < ball.size) {
        target.set(points.get(i));
        return true;
      }
    }
    return false;
  }
}
