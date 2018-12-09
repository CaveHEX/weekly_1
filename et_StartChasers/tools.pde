void push() {
  pushMatrix();
  pushStyle();
}

void pop() {
  popMatrix();
  popStyle();
}

boolean recording = false;
int framesToSave = 500;

void record() {
  if ( recording ) {
    saveFrame("data/movie/img#####.png");
    if ( framesToSave <= 0 ) {
      exit();
    }
    --framesToSave;
  }
}
