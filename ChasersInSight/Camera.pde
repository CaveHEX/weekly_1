class Camera {
  AgentSphere target;
  PVector lookAt;

  Camera() {
    target = new AgentSphere();
    lookAt = target.pos.copy();
  }

  void update() {
    target.update();
    lookAt.lerp(target.pos, 0.1);
  }

  void render() {
    float exTime = 0.005;
    float rad = 100;
    camera(
      cos(frameCount*exTime)*rad, sin(frameCount*exTime)*rad, zoomedOut ? -1000 : 0, // Where's my eye ?!
      lookAt.x, lookAt.y, lookAt.z,                                                   // What am I looking at ? (The AgentSphere)
      0, 1, 0);                                                                       // Y axis is what I want upward!

    if ( debug ) {
      push();
      {
        strokeWeight(10.0);
        stroke(ryb(120), 0, 100);
        point(lookAt.x, lookAt.y, lookAt.z);
        stroke(ryb(120 + 180), 0, 100);
        point(target.pos.x, target.pos.y, target.pos.z);
      }
      pop();
    }
  }

  void run() {
    this.update();
    this.render();
  }
}
