class Walls {

  ArrayList<Obstacle> obstacles;


  Walls() {
    obstacles = new ArrayList<Obstacle>();
  }


  void update(Balls balls) {
    for (Obstacle obstacle : obstacles) {
      obstacle.update(balls);
    }
  }


  void show() {
    for (Obstacle obstacle : obstacles) {
      obstacle.show();
    }
  }

  void mousePressedEvent(PVector mouse) {
    if (mouse.x >= (width/3)) {
      Obstacle newCandidate = new Obstacle(new PVector(mouse.x, mouse.y));

      boolean addThisObstacle = true;

      for (Obstacle obstacle : obstacles) {
        float dist = PVector.dist(obstacle.position, newCandidate.position);
        if (dist < (obstacle.width_ + newCandidate.width_)
          && dist < obstacle.height_ + newCandidate.height_)
        {
          addThisObstacle = false;
        }
      }
      if (addThisObstacle) {
        obstacles.add(newCandidate);
      }
    }
  }
}
