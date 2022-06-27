class Obstacle {

  PVector position;
  float   width_, height_;
  color   color_;


  Obstacle(PVector mouse) {
    position = new PVector(mouse.x, mouse.y);
    width_   = 50;
    height_  = 50;
    color_   = color(200, 102, 103);
  }


  void update(Balls other) {
    // Update for balls
    for (Ball ball : other.balls) {
      if (ball != null && isCollide(ball)) {
        if (ball.velocity.mag() >= 30) {
          ball.destroyed = true;
        } else {
          reflect(ball);
        }
      }
    }

    // Update for particle
    for (Particle particle : other.particles) {
      if (isCollide(particle)) {
        reflect(particle);
      }
    }
  }


  void show() {
    fill(color_);
    rect(position.x, position.y, width_, height_);
  }


  void reflect(Ball ball) {
    /*
      Reflect the ball when it hitting with the obstacle
     */

    // Right and left from the obstacle
    if (ball.position.x + ball.size >= position.x - width_
      && ball.position.x < position.x - width_)
    {
      ball.position.x  = position.x - width_ - ball.size;
      ball.velocity.x *= -1;
    }
    if (ball.position.x - ball.size <= position.x + width_
      && ball.position.x > position.x + width_)
    {
      ball.position.x  = position.x + width_ + ball.size;
      ball.velocity.x *= -1;
    }

    // Under and above from the obstacle
    if (ball.position.y - ball.size <= position.y + height_
      && ball.position.y > position.y + height_)
    {
      ball.position.y  = position.y + height_ + ball.size;
      ball.velocity.y *= -1;
    }
    if (ball.position.y + ball.size >= position.y - height_
      && ball.position.y < position.y - height_)
    {
      ball.position.y  = position.y - height_ - ball.size;
      ball.velocity.y *= -1;
      ball.velocity.mult(0.8);
    }
  }


  void reflect(Particle ball) {
    /*
      Reflect the particle when it hitting with the obstacle
     */

    // Right and left from the obstacle
    if (ball.position.x + ball.size >= position.x - width_
      && ball.position.x < position.x - width_)
    {
      ball.position.x   = position.x - width_ - ball.size;
      ball.velocity.x  *= -0.8;
    }
    if (ball.position.x - ball.size <= position.x + width_
      && ball.position.x > position.x + width_)
    {
      ball.position.x   = position.x + width_ + ball.size;
      ball.velocity.x  *= -0.8;
    }

    // Under and above from the obstacle
    if (ball.position.y - ball.size <= position.y + height_
      && ball.position.y + 10 > position.y + height_)
    {
      ball.position.y   = position.y + height_ + ball.size;
      ball.velocity.y  *= -1;
      ball.velocity.mult(0.8);
    }
    if (ball.position.y + ball.size >= position.y - height_
      && ball.position.y - 10 < position.y - height_)
    {
      ball.position.y   = position.y - height_ - ball.size;
      ball.velocity.y  *= -1;
      ball.velocity.mult(0.8);
    }
  }


  boolean isCollide(Ball ball) {
    float dx = ball.position.x - position.x;
    float dy = ball.position.y - position.y;
    if ((-width_ - ball.size < dx && dx < width_ + ball.size)
      && (-height_ - ball.size < dy && dy < height_ + ball.size)) {
      return true;
    } else {
      return false;
    }
  }


  boolean isCollide(Particle ball) {
    float dx = ball.position.x - position.x;
    float dy = ball.position.y - position.y;
    if ((-width_ - ball.size < dx && dx < width_ + ball.size)
      && (-height_ - ball.size < dy && dy < height_ + ball.size)) {
      return true;
    } else {
      return false;
    }
  }
}
