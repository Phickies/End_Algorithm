class Ball {

  PVector position;
  PVector velocity;
  PVector acceleration;

  float   mass, size, spring;
  boolean release, destroyed, inGround;


  Ball(PVector pos) {
    position     = new PVector(pos.x, pos.y);
    velocity     = new PVector();
    acceleration = new PVector();

    mass         = random(1, 4);
    size         = map(mass, 1, 4, 10, 40);
    spring       = map(mass, 4, 1, 0.05, 0.9);
    release      = false;
    destroyed    = false;
    inGround     = false;
  }


  void update() {
    if (release) {
      velocity.add(acceleration);
      position.add(velocity);
      acceleration.mult(0);
    } else {
      position.set(mouseX, mouseY);
    }
  }


  void show() {
    fill(200);
    ellipse(position.x, position.y, size, size);
  }


  void applyForce(PVector force) {
    if (release) {
      PVector f = PVector.div(force, mass);
      acceleration.add(f);
      acceleration.mult(delta_time);
    }
  }


  void shoot(PVector force) {
    PVector f = PVector.div(force, mass);
    velocity.add(f);
    velocity.mult(delta_time);
  }


  void checkEdges() {
    float c = map(mass, 1, 4, 0.8, 0.6);

    if (position.y + size >= height) {
      destroyed   = true;
    }
    if (position.x + size >= width) {
      position.x  = width - size;
      velocity.x *= -c;
      velocity.y *= c;
    }
    if (position.x - size <= 0) {
      position.x  = size;
      velocity.x *= -c;
      velocity.y *= c;
    }
  }
}
