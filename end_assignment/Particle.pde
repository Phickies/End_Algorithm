class Particle{
  
  PVector position;
  PVector velocity;
  PVector acceleration;

  float   size;
  float   lifetime;
  
  
  Particle(PVector origin){
    position      = new PVector(origin.x, origin.y - 45);
    velocity      = new PVector(random(-2, 2), random(-1, -2));
    acceleration  = new PVector(0, 0.1);

    size          = 4;
    lifetime      = 255;
  }
  
  
  void update(){
    velocity.add(acceleration);
    position.add(velocity);
    lifetime -= 3;
  }
  
  
  void show(){
    pushMatrix();
    translate(position.x, position.y);
    fill(lifetime, lifetime, 0);
    rotate(frameCount / -100.0);
    ellipse(0, 0, 4, 4);
    popMatrix();
  }
  
  
  boolean isDead(){
    return (lifetime < 0);
  }
  
}
