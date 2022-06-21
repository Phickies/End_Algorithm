class Particle {

  PVector position;
  PVector velocity;
  PVector acceleration;

  float   size;
  float   lifetime;


  Particle(PVector origin) {
    position      = new PVector(origin.x, origin.y - 45);
    velocity      = new PVector(random(-2, 2), random(-2, -2));
    acceleration  = new PVector(0, 0.1);

    size          = 5;
    lifetime      = 255;
  }


  void update() {
    acceleration.y = 0.1;
    velocity.add(acceleration.mult(delta_time));
    position.add(velocity);

    // Bounce the particle when hitting ground or wall;
    if (position.y + size >= height) {
      position.y   = height - size;
      velocity.y  *= -1;
      velocity.y   = velocity.y*0.6;
      velocity.x   = velocity.x*0.6;
      lifetime    -= 1;
    }
    if (position.x + size >= width) {
      position.x  = width - size;
      velocity.x *= -1;
      velocity.x  = velocity.x*0.6;
      velocity.y  = velocity.y*0.6;
      lifetime   -= 1;
    }
    if (position.x - size <= 0) {
      position.x  = size;
      velocity.x *= -1;
      velocity.x  = velocity.x*0.6;
      velocity.y  = velocity.y*0.6;
      lifetime   -= 1;
    }
  }


  void show() {
    pushMatrix();
    translate(position.x, position.y);
    fill(lifetime, lifetime, 0);
    circle(0, 0, size);
    popMatrix();
  }


  boolean isDead() {
    return (lifetime < 0);
  }
}
