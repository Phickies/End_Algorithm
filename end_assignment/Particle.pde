class Particle {

  PVector position;
  PVector velocity;
  PVector acceleration;

  float   mass, size, spring, lifetime;


  Particle(PVector origin) {
    position      = new PVector(origin.x, origin.y);
    velocity      = new PVector();
    acceleration  = new PVector();

    mass     = 0.3;
    size     = 5;
    spring   = 0.05;
    lifetime = 255;

    velocity = PVector.random2D();
    velocity.mult(2);
    velocity.mult(delta_time);
  }


  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }


  void show() {
    fill(255, 255, 0, lifetime);
    ellipse(position.x, position.y, size, size);
  }


  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
    acceleration.mult(delta_time);
  }


  void checkEdge() {
    if (position.y + size >= height) {
      position.y   = height - size;
      velocity.y  *= -0.6;
      velocity.x  *= 0.6;
      lifetime    -= 1;
    }
    if (position.x + size >= width) {
      position.x  = width - size;
      velocity.x *= -0.6;
      velocity.y *= 0.6;
      lifetime   -= 1;
    }
    if (position.x - size <= 0) {
      position.x  = size;
      velocity.x *= -0.6;
      velocity.y *= 0.6;
      lifetime   -= 1;
    }
  }


  boolean isDead() {
    return (lifetime < 0);
  }
}
