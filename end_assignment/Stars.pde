int MAX_STARS = 400;

class Stars {


  Star[] stars = new Star[MAX_STARS];


  Stars(float meanWidth, float meanHeight, float sd) {
    for (int i = 0; i < stars.length; i++) {
      stars[i] = new Star(meanWidth, meanHeight, sd);
    }
  }


  void show() {
    for (int i = 0; i < stars.length; i++) {
      stars[i].show();
    }
  }
}
