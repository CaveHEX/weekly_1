void push() {
  pushMatrix();
  pushStyle();
}

void pop() {
  popMatrix();
  popStyle();
}

void screenshot() {
  save("data/img/img_" + str(round(random(1000, 9999))) + ".png");
}

boolean recording = false;
int framesToSave = 2500;

void record() {
  if ( recording ) {
    saveFrame("data/movie/img#####.png");
    if ( framesToSave <= 0 ) {
      exit();
    }
    --framesToSave;
  }
}

void regenerate() {
  g_shape = makeShapeCluster();
  initStars();
}
