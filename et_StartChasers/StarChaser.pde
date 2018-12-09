class SearchingArea {

  float radius;
  PVector pos;

  SearchingArea() {
    pos = new PVector();
    radius = 0;
  }

  SearchingArea(PVector pos_, float radius_) {
    pos = pos_.copy();
    radius = radius_;
  }

  boolean isInArea(PVector point) {
    return dist(point.x, point.y, point.z, pos.x, pos.y, pos.z) < radius;
  }
}



class StarChaser {

  PVector head;
  PVector tail;

  PVector origin;
  PVector destination;

  float animationState = 0.0;
  float animationRandAmp = 0.01;
  float animationSpeedBase = 0.02; // 0.05
  float animationSpeed = animationSpeedBase;

  boolean done = true;
  boolean animate = false;

  Star starDest = new Star();
  Star starOri = new Star();

  SearchingArea searchArea;

  StarChaser(Star star, PVector spawnStar) {
    starOri = star;
    starOri.reserve();
    
    origin = spawnStar.copy();

    tail = new PVector();
    head = new PVector();
    destination = new PVector();

    searchArea = new SearchingArea();
  }

  void update() {
    if ( animate ) {
      animationState += animationSpeed;
      constrain(animationState, 0.0, 1.0);
      head = PVector.lerp(origin, destination, constrain(animationState * animationState, 0, 1));
      tail = PVector.lerp(origin, destination, constrain(animationState * animationState * animationState, 0, 1));

      if ( animationState > 0.99999999 ) { // What's the const for float's epsilon in Processing?
        this.reset();
      }
    } else {
      refreshSearchingArea();
    }
  }

  void render() {
    push();
    stroke(255);
    strokeWeight(2.0);
    line(head.x, head.y, head.z, tail.x, tail.y, tail.z);
    pop();
  }

  void setDestination(Star newStar, PVector dest) {
    this.free();
    starDest = newStar;
    starDest.reserve();
    destination = dest.copy();
    animate = true;
    done = false;
    //refreshSearchingArea();

    animationSpeed = animationSpeedBase + random(-animationRandAmp, animationRandAmp);
    float d = PVector.dist(origin, destination);
    animationSpeed = map(d, 300, 0, animationSpeed, animationSpeed * 0.5);
  }

  boolean isDone() {
    return done;
  }

  SearchingArea getSearchArea() {
    return searchArea;
  }

  void refreshSearchingArea() {
    searchArea = new SearchingArea(PVector.lerp(origin, target, 0.4), 60);
  }

  void free() {
    starOri.free();
    starOri = starDest;
  }

  void reset() {
    done = true;
    animate = false;
    animationState = 0;
    origin = destination.copy();
    destination.mult(0);
    refreshSearchingArea();
  }
}
