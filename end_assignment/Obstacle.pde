class Obstacle {

  PVector position;
  float   width_, height_;
  color   color_;


  Obstacle(PVector mouse) {
    position = new PVector(mouse.x, mouse.y);
    width_   = 50;
    height_  = 50;
    color_   = color(int(random(255)), int(random(255)), int(random(255)), 200);
  }


  void update(Balls other) {
    for (Ball ball : other.balls) {
      if (ball != null) {
        if (isCollision(ball)) {
          if (ball.speed.mag() >= 10) {
            ball.collision = true;
          } else {
            reflect(ball);
          }
        }
      }
    }
    
    for (Particle particle : other.particles){
      reflect(particle);
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
      ball.speed.x   *= -1;
      //ball.speed.x    = (ball.speed.x*(60+ball.c))/100;
    }

    if (ball.position.x - ball.size <= position.x + width_
      && ball.position.x > position.x + width_)
    {
      ball.position.x = position.x + width_ + ball.size;
      ball.speed.x   *= -1;
      //ball.speed.x    = (ball.speed.x*(60+ball.c))/100;
    }

    // Under and above from the obstacle
    if (ball.position.y - ball.size <= position.y + height_
      && ball.position.y > position.y + height_)
    {
      ball.position.y = position.y + height_ + ball.size;
      ball.speed.y   *= -1;
      //ball.speed.y    = (ball.speed.y*(80+ball.c))/100;
      ball.speed.x    = (ball.speed.x*(80+ball.c))/100;
    }

    if (ball.position.y + ball.size >= position.y - height_
      && ball.position.y < position.y - height_)
    {
      ball.position.y = position.y - height_ - ball.size;
      ball.speed.y   *= -1;
      //ball.speed.y    = (ball.speed.y*(60+ball.c))/100;
      //ball.speed.x    = (ball.speed.x*(90+ball.c))/100;
    }
  }
  
  
  void reflect(Particle ball) {
    /*
      Reflect the ball when it hitting with the obstacle
     */

    // Right and left from the obstacle
    if (ball.position.x + ball.size >= position.x - width_
      && ball.position.x < position.x - width_)
    {
      ball.position.x = position.x - width_ - ball.size;
      ball.velocity.x   *= -1;
    }

    if (ball.position.x - ball.size <= position.x + width_
      && ball.position.x > position.x + width_)
    {
      ball.position.x = position.x + width_ + ball.size;
      ball.velocity.x   *= -1;
    }

    // Under and above from the obstacle
    if (ball.position.y - ball.size <= position.y + height_
      && ball.position.y > position.y + height_)
    {
      ball.position.y = position.y + height_ + ball.size;
      ball.velocity.y   *= -1;
      ball.velocity.x    = ball.velocity.x*0.6;
    }

    if (ball.position.y + ball.size >= position.y - height_
      && ball.position.y < position.y - height_)
    {
      ball.position.y = position.y - height_ - ball.size;
      ball.velocity.y   *= -1;
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
}
