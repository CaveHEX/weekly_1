AgentSphere agents[];
int nb = 10;

void setup() {
  size(1000, 1000, P3D);
  frameRate(60);

  agents = new AgentSphere[nb];

  for ( int i = 0; i < nb; ++i ) {
    agents[i] = new AgentSphere();
  }

}

void draw() {
  background(0);
  
  translate(width * 0.5, height * 0.5, -200);
  rotateY(frameCount * 0.01);

  for ( int i = 0; i < nb; ++i ) {
    agents[i].run();
  }

  record();
}

void keyPressed() {
  if ( key == 'r' ) {
    recording = true;
  }
}
