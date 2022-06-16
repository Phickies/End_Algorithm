long last_time;
int delta_time;

class Ball {

  PVector position  = new PVector();
  PVector speed     = new PVector();

  float   size, mass, c, spring;
  boolean release   = false;
  boolean collision = false;
  
  // Declare constant
  float   gConst    = 0.001;
  float   bodyMass  = 1000000;
  float   bodyRad   = 100;
  float   gravity;


  Ball(float posX, float posY) {
    size    = random(10, 40);
    mass    = map(size, 10, 40, 1, 4);
    c       = map(size, 40, 10, -20, 10);
    spring  = map(size, 40, 10, 0.05, 0.9);
    gravity = (gConst*bodyMass*mass)/(bodyRad*bodyRad);
    position.set(posX, posY);
    speed.set(0, 0);
  }


  void show() {
    fill(150);
    ellipse(position.x, position.y, size, size);
  }
  
  
  void shoot(PVector force) {
    speed.x = (force.x*(100+c)/100)*delta_time;
    speed.y = (force.y*(100+c)/100)*delta_time;
  }


  void update() {

    // Physical applied only after the ball has been release from the catapult
    if (release) {
      float   accelaration = gravity/mass;

      // Falling
      speed.y     += accelaration*delta_time;
      position.add(speed);

      // Bounce the ball when hitting ground or wall;
      if (position.y + size >= height) {
        position.y = height - size;
        speed.y   *= -1;
        speed.y    = (speed.y*(60+c))/100;
        speed.x    = (speed.x*(90+c))/100;
      }
      if (position.x + size >= width) {
        position.x = width - size;
        speed.x   *= -1;
        speed.x    = (speed.x*(60+c))/100;
        speed.y    = (speed.y*(90+c))/100;
      }
      if (position.x - size <= 0) {
        position.x = size;
        speed.x   *= -1;
        speed.x    = (speed.x*(60+c))/100;
        speed.y    = (speed.y*(90+c))/100;
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
