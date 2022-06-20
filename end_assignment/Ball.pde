class Ball {

  PVector position;
  PVector velocity;
  PVector acceleration;

  float   size, mass, c, spring, gravity;
  boolean release, collision;

  float   GCONST    = 0.001;
  float   BODYMASS  = 1000000;
  float   BODYRAD   = 100;


  Ball(float posX, float posY) {
    position     = new PVector(posX, posY);
    velocity     = new PVector();
    acceleration = new PVector();

    size    = random(10, 40);
    mass    = map(size, 10, 40, 1, 4);
    c       = map(size, 40, 10, -20, 10);
    spring  = map(size, 40, 10, 0.05, 0.9);

    release   = false;
    collision = false;

    gravity = (GCONST*BODYMASS*mass)/(BODYRAD*BODYRAD);
  }


  void show() {
    fill(180);
    ellipse(position.x, position.y, size, size);
  }


  void shoot(PVector force) {
    velocity.x = (force.x*(100+c)/100);
    velocity.y = (force.y*(100+c)/100);
    velocity.mult(delta_time);
  }


  void update() {

    // Physical applied only after the ball has been release from the catapult
    if (release) {
      // Falling
      acceleration.y = gravity/mass;
      acceleration.mult(delta_time);
      velocity.add(acceleration);
      position.add(velocity);

      // Bounce the ball when hitting ground or wall;
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
    } else {
      position.set(mouseX, mouseY);
    }
  }


  void setRelease(boolean isRelease) {
    try {
      this.release = isRelease;
    }
    catch (ArrayIndexOutOfBoundsException e) {
    }
  }


  boolean getRelease() {
    return release;
  }


  float getPositionX() {
    return position.x;
  }


  float getPositionY() {
    return position.y;
  }


  float getSize() {
    return size;
  }
}
