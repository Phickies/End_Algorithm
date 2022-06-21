class Ball {

  float   size, mass, c, spring;

  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector gravity;

  boolean release, collision;


  Ball(float posX, float posY) {
    size    = random(10, 40);
    mass    = map(size, 10, 40, 1, 4);
    c       = map(size, 40, 10, -20, 10);
    spring  = map(size, 40, 10, 0.05, 0.9);

    position     = new PVector(posX, posY);
    velocity     = new PVector();
    acceleration = new PVector();
    gravity      = new PVector(0, mass*0.15);

    release   = false;
    collision = false;
  }


  void show() {
    fill(180);
    ellipse(position.x, position.y, size, size);
  }


  void update() {

    // Physical applied only after the ball has been release from the catapult
    if (release) {

      applyForce(gravity);

      velocity.add(acceleration);
      position.add(velocity);
      acceleration.mult(0);
    } else {
      position.set(mouseX, mouseY);
    }
  }


  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
    acceleration.mult(delta_time);
  }


  void checkEdges() {
    if (position.y + size >= height) {
      position.y  = height - size;
      velocity.y *= -1;
      velocity.y  = (velocity.y*(60+c))/100;
      velocity.x  = (velocity.x*(90+c))/100;
    }
    if (position.x + size >= width) {
      position.x  = width - size;
      velocity.x *= -1;
      velocity.x  = (velocity.x*(60+c))/100;
      velocity.y  = (velocity.y*(90+c))/100;
    }
    if (position.x - size <= 0) {
      position.x  = size;
      velocity.x *= -1;
      velocity.x  = (velocity.x*(60+c))/100;
      velocity.y  = (velocity.y*(90+c))/100;
    }
  }
}
