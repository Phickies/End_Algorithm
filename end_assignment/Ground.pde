class Ground {

  ArrayList<PVector> points;
  PVector            target;

  float increment;
  float yoff;


  Ground(float rough) {
    points    = new ArrayList<PVector>();
    target    = new PVector();
    increment = rough;
  }


  void update(Balls balls) {
    for (Ball ball : balls.balls) {
      reflect(ball);
    }
    for (Particle particle : balls.particles) {
      reflect(particle);
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
        yoff += increment;
      }
      vertex(width, height);
      vertex(0, height);
    }
    endShape();
  }


  void reflect(Ball ball) {
    /*
      Reflect the ball when it hitting with the ground
     */

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
        PVector n = PVector.sub(target, ball.position);
        n.normalize();

        float   a = PVector.dot(n, ball.velocity);
        PVector t = PVector.mult(PVector.mult(n, a), 2);
        PVector r = PVector.sub(ball.velocity, t);
        
        ball.velocity.set(r);
      }
    }
  }


  void reflect(Particle particle) {
    /*
      Reflect the particle when it hitting with the ground
     */

    for (int i = int(particle.position.x - particle.size);
      i < particle.position.x + particle.size; i++)
    {
      if (i<0) {
        i=0;
      } else if (i>points.size()) {
        i=points.size()-1;
      }
      float dist = PVector.dist(points.get(i), particle.position);
      
      if (dist < particle.size) {
        particle.lifetime--;
        target.set(points.get(i));
        PVector n = PVector.sub(target, particle.position);
        n.normalize();

        float   a = PVector.dot(n, particle.velocity);
        PVector t = PVector.mult(PVector.mult(n, a), 2);
        PVector r = PVector.sub(particle.velocity, t);
        
        particle.velocity.set(r);
      }
    }
  }
}
