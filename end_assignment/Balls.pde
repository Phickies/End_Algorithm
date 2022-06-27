class Balls { //<>//

  ArrayList<Ball> balls;
  ArrayList<Particle> particles;

  Balls() {
    balls     = new ArrayList<Ball>();
    particles = new ArrayList<Particle>();
  }


  void update() {

    // Update physic for balls
    for (Ball ball : balls) {
      ball.update();
      ball.checkEdges();
      collideB2B(ball, balls);
      collideB2P(ball, particles);
    }

    // Spawn particles
    for (int i = balls.size()-1; i>=0; i--) {
      if (balls.get(i).destroyed) {
        for (int j = int(balls.get(i).size); j>=0; j--) {
          PVector position = new PVector(
            random(-balls.get(i).size + balls.get(i).position.x, balls.get(i).size + balls.get(i).position.x),
            random(-balls.get(i).size + balls.get(i).position.y, balls.get(i).size + balls.get(i).position.y)
            );
          particles.add(new Particle(position));
        }
        balls.remove(i);
      }
    }

    // Only exercute when have particles
    if (particles.size() > 0) {
      // Update physic for particles
      for (Particle particle : particles) {
        particle.checkEdge();
        particle.update();
        collideP2P(particle, particles);
      }

      // Delete old particle
      for (int i = particles.size() - 1; i >= 0; i--) {
        if (particles.get(i).isDead()) {
          particles.remove(i);
        }
      }
    }
  }


  void show() {
    for (Ball ball : balls) {
      ball.show();
    }

    for (Particle particle : particles) {
      particle.show();
    }
  }


  void collideB2B(Ball ball, ArrayList<Ball> others) {
    /*
      Bouncing ball with other ball;
     */

    for (Ball other : others) {

      float distance = PVector.dist(ball.position, other.position);
      float minDist = other.size + ball.size;

      if (distance > 0 && distance < minDist) {
        float angle = atan2(other.position.y - ball.position.y,
          other.position.x - ball.position.x);

        float targetX = ball.position.x + cos(angle) * minDist;
        float targetY = ball.position.y + sin(angle) * minDist;

        PVector target = new PVector(targetX, targetY);
        PVector bounce = PVector.sub(target, other.position);
        bounce.mult(pow(ball.spring, 2)+pow(other.spring, 2));

        ball.velocity.sub(bounce);
        other.velocity.add(bounce);
      }
    }
  }


  void collideB2P(Ball ball, ArrayList<Particle> others) {
    /*
      Bouncing ball with other particle;
     */

    for (Particle other : others) {

      float distance = PVector.dist(ball.position, other.position);
      float minDist = other.size + ball.size;

      if (distance > 0 && distance < minDist) {
        float angle = atan2(other.position.y - ball.position.y,
          other.position.x - ball.position.x);

        float targetX = ball.position.x + cos(angle) * minDist;
        float targetY = ball.position.y + sin(angle) * minDist;

        PVector target = new PVector(targetX, targetY);
        PVector bounce = PVector.sub(target, other.position);
        bounce.mult(pow(ball.spring, 2)+pow(other.spring, 2));

        ball.velocity.sub(bounce);
        other.velocity.add(bounce);
      }
    }
  }


  void collideP2P(Particle particle, ArrayList<Particle> others) {
    /*
      Bouncing particle with other particle;
     */

    for (Particle other : others) {

      float distance = PVector.dist(particle.position, other.position);
      float minDist = other.size + particle.size;

      if (distance > 0 && distance < minDist) {
        float angle = atan2(other.position.y - particle.position.y,
          other.position.x - particle.position.x);

        float targetX = particle.position.x + cos(angle) * minDist;
        float targetY = particle.position.y + sin(angle) * minDist;

        PVector target = new PVector(targetX, targetY);
        PVector bounce = PVector.sub(target, other.position);
        bounce.mult(pow(particle.spring, 2)+pow(other.spring, 2));

        particle.velocity.sub(bounce);
        other.velocity.add(bounce);
      }
    }
  }


  void spawnEvent(PVector mouse) {
    /*
      A new ball is only created here!
     */

    Ball newCandidate = new Ball(mouse);

    boolean addThisBall = true;

    for (int i = 0; i<balls.size(); i++) {
      if (PVector.dist(balls.get(i).position, newCandidate.position)
        < (balls.get(i).size + newCandidate.size))
      {
        addThisBall = false;
      }
    }

    if (addThisBall) {
      balls.add(newCandidate);
    }
  }


  void mouseDraggedEvent(PVector mouse) {
    for (Ball ball : balls) {
      if (!ball.release) {
        ball.position.set(mouse);
      }
    }
  }
}
