class Obstacle {

  PVector position;
  float   width_, height_;
  color   color_;


  Obstacle(PVector mouse) {
    position = new PVector(mouse.x, mouse.y);
    width_   = 50;
    height_  = 50;
    color_   = color(
      int(random(100, 255)),
      int(random(100, 255)),
      int(random(100, 255))
      );
  }


  void update(Balls other) {
    for (Ball ball : other.balls) {
      if (ball != null) {
        if (isCollision(ball)) {
          if (ball.velocity.mag() >= 30) {
            ball.collision = true;
          } else {
            reflect(ball);
          }
        }
      }
    }
    for (Particle particle : other.particles) {
      if (isCollision(particle)) {
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
      ball.position.x = position.x - width_ - ball.size;
      ball.velocity.x   *= -1;
    } else if (ball.position.x - ball.size <= position.x + width_
      && ball.position.x > position.x + width_)
    {
      ball.position.x = position.x + width_ + ball.size;
      ball.velocity.x   *= -1;
      //ball.velocity.x    = (ball.velocity.x*(60+ball.c))/100;
    }

    // Under and above from the obstacle
    else if (ball.position.y - ball.size <= position.y + height_
      && ball.position.y > position.y + height_)
    {
      ball.position.y = position.y + height_ + ball.size;
      ball.velocity.y   *= -1;
      //ball.velocity.y    = (ball.velocity.y*(80+ball.c))/100;
      ball.velocity.x    = (ball.velocity.x*(80+ball.c))/100;
    } else if (ball.position.y + ball.size >= position.y - height_
      && ball.position.y < position.y - height_)
    {
      ball.position.y = position.y - height_ - ball.size;
      ball.velocity.y   *= -1;
      //ball.velocity.y    = (ball.velocity.y*(60+ball.c))/100;
      //ball.velocity.x    = (ball.velocity.x*(90+ball.c))/100;
    }
  }


  void reflect(Particle ball) {
    /*
      Reflect the particle when it hitting with the obstacle
     */

    // Right and left from the obstacle
    if (ball.position.x + ball.size >= position.x - width_
      && ball.position.x + 10 < position.x - width_)
    {
      ball.position.x   = position.x - width_ - ball.size;
      ball.velocity.x  *= -1;
      ball.velocity.x   = ball.velocity.x*0.8;
    } else if (ball.position.x - ball.size <= position.x + width_
      && ball.position.x - 10 > position.x + width_)
    {
      ball.position.x   = position.x + width_ + ball.size;
      ball.velocity.x  *= -1;
      ball.velocity.x   = ball.velocity.x*0.8;
    }

    // Under and above from the obstacle
    else if (ball.position.y - ball.size <= position.y + height_
      && ball.position.y + 10 > position.y + height_)
    {
      ball.position.y   = position.y + height_ + ball.size;
      ball.velocity.y  *= -1;
      ball.velocity.y   = ball.velocity.y*0.8;
      ball.velocity.x   = ball.velocity.x*0.8;
    } else if (ball.position.y + ball.size >= position.y - height_
      && ball.position.y - 10 < position.y - height_)
    {
      ball.position.y   = position.y - height_ - ball.size;
      ball.velocity.y  *= -1;
      ball.velocity.y   = ball.velocity.y*0.8;
      ball.velocity.x   = ball.velocity.x*0.8;
    }
  }


  boolean isCollision(Ball ball) {
    float dx = ball.position.x - position.x;
    float dy = ball.position.y - position.y;
    if ((-width_ - ball.size < dx && dx < width_ + ball.size)
      && (-height_ - ball.size < dy && dy < height_ + ball.size)) {
      return true;
    } else {
      return false;
    }
  }


  boolean isCollision(Particle ball) {
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
