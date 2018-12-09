class Star {
  PVector pos;
  boolean taken = false;

  Star() {
    pos = new PVector();
  }

  Star(PVector pos_) {
    pos = pos_.copy();
  }

  boolean isFree() {
    return !taken;
  }

  boolean isTaken() {
    return taken;
  }

  void reserve() {
    taken = true;
  }

  void free() {
    taken = false;
  }
}
