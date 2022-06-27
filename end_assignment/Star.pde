class Star {

  PVector position;
  float   size;


  Star(float meanWidth, float meanHeight, float sd) {
    position = new PVector();
    position.set((randomGaussian() * sd) + meanWidth, (randomGaussian() * sd) + meanHeight);
    size     = (randomGaussian() * meanSize()) + meanSize();
  }


  void show() {
    fill(255, 223, 0);
    pushMatrix();
    translate(position.x, position.y);
    rotate(frameCount / -100.0);
    star(0, 0, size, size/3, 4);
    popMatrix();
  }


  void star(float x, float y, float radius1, float radius2, int npoints) {
    /*
     Create stars function
     Document is taken from processing example
     https://processing.org/examples/star.html
     */

    float angle     = TWO_PI / npoints;
    float halfAngle = angle/2.0;

    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius2;
      float sy = y + sin(a) * radius2;
      vertex(sx, sy);
      sx = x + cos(a+halfAngle) * radius1;
      sy = y + sin(a+halfAngle) * radius1;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }


  float meanSize() {
    /*
     Return the size mapping with the position
     */

    float dist     = dist(position.x, position.y, width/2, height/2);
    float meanSize = map(dist, 0, dist(width/2, height/2, 0, 0), 5, 0);
    return meanSize;
  }
}
