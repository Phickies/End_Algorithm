class Environment {

  Ground    ground;
  Obstacles obstacles;
  Balls     balls;

  long  last_time;
  float gra;

  Environment(float rough, float gravity) {
    balls     = new Balls();
    ground    = new Ground(rough);
    obstacles = new Obstacles(width/3, width);
    last_time = System.nanoTime();
    gra       = gravity;
  }


  void update(Balls balls) {
    // Calculate delta_time (TimeStep).
    long time   = System.nanoTime();
    delta_time  = int((time - last_time) / 1000000)/10;
    last_time   = time;

    // Update environment
    obstacles.update(balls);
    ground.update(balls);

    // Set gravity force
    for (Ball ball : balls.balls) {
      PVector g = new PVector(0, ball.mass*gra);
      ball.applyForce(g);
    }

    for (Particle particle : balls.particles) {
      PVector g = new PVector(0, particle.mass*gra);
      particle.applyForce(g);
    }
  }


  void show() {
    obstacles.show();
    ground.show();
  }
}
