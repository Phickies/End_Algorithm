class Particle {

  PVector position;
  PVector velocity;
  PVector acceleration;

  float   mass, size, lifetime;


  Particle(PVector origin) {
    position      = new PVector(origin.x, origin.y);
    velocity      = new PVector(random(-2, 2), random(-2, 2));
    acceleration  = new PVector();

    mass     = 0.3;
    size     = 5;
    lifetime = 255;
  }


  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }


  void show() {
    fill(lifetime, lifetime, 0);
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
