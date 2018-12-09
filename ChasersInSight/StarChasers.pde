final int MODE_ROAM = 0;
final int MODE_SEEK = 1;

class StarChasers {

  int nb = 30;
  StarChaser scs[];

  float minJumpDist = 20;
  int chaseMode = MODE_SEEK;

  StarChasers() {
    scs = new StarChaser[nb];

    for ( int i = 0; i < nb; ++i ) {
      int starIndex = -1;
      boolean done = false;
      for ( int j = 0; j < stars.starCount() && !done; ++j ) {
        if ( stars.isFree(j) ) {
          starIndex = j;
          done = true;
        }
      }
      if ( starIndex == -1 ) {
        println("big nono"); //<>//
        exit(); // boom
      }
      scs[i] = new StarChaser(stars.at(starIndex), stars.posAt(starIndex));
    }
  }

  void update() {
    for ( int i = 0; i < nb; ++i ) {
      scs[i].update();

      if ( scs[i].isDone() ) {
        this.matchmaking(i);
      }
    }
  }

  void render() {
    push();
    beginShape(LINES);
    stroke(255);
    strokeWeight(1.0);
    for ( int i = 0; i < nb; ++i ) {
      scs[i].render();
    }
    endShape();
    pop();
  }

  void run() {
    this.update();
    this.render();
  }

  void matchmaking(int index) {
    int starIndex = -1;
    boolean done = false;

    if ( chaseMode == MODE_ROAM ) {

      for ( int j = 0; j < stars.starCount() && !done; ++j ) {
        float d = PVector.dist(stars.posAt(j), scs[index].origin);
        if ( stars.isFree(j) && d > minJumpDist ) {
          starIndex = j;
          done = true;
        }
      }
    }

    if ( chaseMode == MODE_SEEK ) {

      SearchingArea sa = scs[index].getSearchArea();

      for ( int j = 0; j < stars.starCount() && !done; ++j ) {
        float d_ori = PVector.dist(stars.posAt(j), scs[index].origin);
        float d_sch = PVector.dist(stars.posAt(j), sa.pos);
        if ( stars.isFree(j) && d_ori > minJumpDist && d_sch < sa.radius ) {
          starIndex = j;
          done = true;
        }
      }
    }

    if ( starIndex != -1 ) {
      scs[index].setDestination(stars.at(starIndex), stars.posAt(starIndex));
      if ( debug ) {
        println("Chaser " + str(index) + " reserved star " + str(starIndex));
      }
    }
  }
}
