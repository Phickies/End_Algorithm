class Ground {

  ArrayList<PVector> coords;
  PVector            target;

  float increment;
  float yoff;


  Ground(float rough) {
    coords    = new ArrayList<PVector>();
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
        coords.add(new PVector(i, y));
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

    float minLength = ball.size;
    int   start     = ceil(ball.position.x - minLength);
    int   end       = ceil(ball.position.x + minLength);

    // Only checking boundary within the ball size
    for (int i = start; i < end; i++) {
      if (i<0) {
        i=0;
      } else if (i>coords.size()) {
        i=coords.size()-1;
      }

      // Find the min length from point to ball position
      // If min length -> perpendicular point for calculate normal.
      float dist = PVector.dist(coords.get(i), ball.position);
      if (dist < ball.size && dist < minLength) {
        minLength = dist;
      }
    }

    // Only excercuted when hitting with the ground.
    if (minLength < ball.size) {
      for (int i = start; i < end; i++) {
        if (i<0) {
          i=0;
        } else if (i>coords.size()) {
          i=coords.size()-1;
        }
        float dist = PVector.dist(coords.get(i), ball.position);

        // Calculate reflecting vector
        if (dist == minLength && !ball.inGround) {
          PVector coord1    = coords.get(i).copy();
          PVector coord2    = coords.get(i+1).copy();

          PVector d         = PVector.sub(coord2, coord1);
          d.normalize();
          PVector normal    = new PVector(-d.y, d.x);
          PVector incidence = PVector.mult(ball.velocity, -1);

          float dot         = incidence.dot(normal);
          PVector reflect   = new PVector(2*normal.x*dot - incidence.x,
            2*normal.y*dot - incidence.y
            );
          ball.velocity.set(reflect);
          ball.inGround = true;
        }
      }
    } else {
      ball.inGround = false;
    }
  }




  void reflect(Particle particle) {
    /*
      Reflect the ball when it hitting with the ground
     */

    float minLength = particle.size;
    int   start     = ceil(particle.position.x - minLength);
    int   end       = ceil(particle.position.x + minLength);

    // Only checking boundary within the ball size
    for (int i = start; i < end; i++) {
      if (i<0) {
        i=0;
      } else if (i>coords.size()) {
        i=coords.size()-1;
      }

      // Find the min length from point to ball position
      // If min length -> perpendicular point for calculate normal.
      float dist = PVector.dist(coords.get(i), particle.position);
      if (dist < particle.size && dist < minLength) {
        minLength = dist;
      }
    }

    // Only excercuted when hitting with the ground.
    if (minLength < particle.size) {
      for (int i = start; i < end; i++) {
        if (i<0) {
          i=0;
        } else if (i>coords.size()) {
          i=coords.size()-1;
        }
        float dist = PVector.dist(coords.get(i), particle.position);

        // Calculate reflecting vector
        if (dist == minLength) {

          if (particle.velocity.x > 0.1 || particle.velocity.y > 0.2) {
            PVector coord1 = coords.get(i).copy();
            PVector coord2 = coords.get(i+1).copy();

            PVector d      = PVector.sub(coord2, coord1);
            d.normalize();
            PVector normal = new PVector(-d.y, d.x);
            PVector incidence = PVector.mult(particle.velocity, -1);

            float dot = incidence.dot(normal);
            PVector reflect   = new PVector(2*normal.x*dot - incidence.x,
              2*normal.y*dot - incidence.y
              );

            particle.velocity.set(reflect);
            particle.lifetime--;
          }
        }
      }
    }
  }
}
