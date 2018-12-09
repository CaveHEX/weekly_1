class Stars {

  ArrayList<Star> s;

  Stars() {
    s = new ArrayList<Star>();
  }

  void addStar(PVector pos) {
    s.add(new Star(pos));
  }

  int starCount() {
    return s.size();
  }

  PVector posAt(int index) {
    return s.get(index).pos;
  }

  boolean isFree(int index) {
    return s.get(index).isFree();
  }

  boolean isTaken(int index) {
    return s.get(index).isTaken();
  }

  void reserve(int index) {
    s.get(index).reserve();
  }

  void free(int index) {
    s.get(index).free();
  }

  void freeAll() {
    for ( Star st : s ) {
      st.free();
    }
  }
  
  Star at(int index) {
    return s.get(index);
  }

  void renderDebug() {
    push();
    for ( int i = 0; i < this.starCount(); ++i ) {
      strokeWeight(3.0);
      if ( s.get(i).isTaken() ) {
        stroke(255, 0, 0);
      } else {
        stroke(0, 255, 0);
      }
      point(s.get(i).pos.x, s.get(i).pos.y, s.get(i).pos.z);
    }
    pop();
  }
}
