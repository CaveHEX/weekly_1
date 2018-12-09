import java.util.*;

Stars stars;
StarChasers starChasers;
PVector target;

void setup() {
  size(1000, 1000, P3D);
  frameRate(60);
  
  stars = new Stars();
  for ( int i = 0; i < 2000; ++i ) {
    float x = random(-width * 0.5, width * 0.5);
    float y = random(-height * 0.5, height * 0.5);
    float z = random(-150, 150);
    stars.addStar(new PVector(x, y, z));
  }
  starChasers = new StarChasers();
  
  target = new PVector();
}

void draw() {
  background(0);
  
  target.x = cos(frameCount * 0.005) * 500;
  target.y = sin(frameCount * 0.005 * 2) * 500;
  target.z = sin(frameCount * 0.01) * 30;
  
  push();
  {
    translate(width * 0.5, height * 0.5, -150);
    rotateY(frameCount * 0.003);
    starChasers.update();
    starChasers.render();
    stars.renderDebug();
    strokeWeight(10.0);
    stroke(0, 255, 0);
    point(target.x, target.y, target.z);
  }
  pop();
   
  record();
}


void keyPressed() {
  if ( key == 'r' ) {
    recording = true;
  }
}
