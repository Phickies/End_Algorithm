class ParticleSystem{
  
  ArrayList<Particle> particles;
  PVector             origin;
  
  boolean             isShow;
  
  
  ParticleSystem(){
    particles = new ArrayList<Particle>();
    origin    = new PVector();
  }
  
  
  void update(){
    // Spawn new particle
    if (isShow){
      PVector position = new PVector(
                          random(-10+origin.x, 10+origin.x), 
                          random(-10+origin.y, 10+origin.y)
      );
      particles.add(new Particle(position));                  
    }
    
    // Update velocity for each particle and delete old particle
    for (int i = particles.size() - 1; i >= 0; i--) {
      particles.get(i).update();
      if (particles.get(i).isDead()) {
        particles.remove(i);
      }
    } 
  }
  
  
  void show(){
    for (Particle particle : particles) {
      particle.show();
    }
  }
}
