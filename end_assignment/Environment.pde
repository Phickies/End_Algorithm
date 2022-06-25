class Environment {

  Ground    ground;
  Obstacles obstacles;
  Balls     balls;


  Environment() {
    balls     = new Balls();
    ground    = new Ground();
    obstacles = new Obstacles(width/3, width);
  }


  void update(Balls balls) {
    for (Ball ball : balls.balls) {
      ground.update(ball);
      obstacles.update(ball);
    }
  }
  
  
  void show(){
    ground.show();
    obstacles.show();
  }
}
