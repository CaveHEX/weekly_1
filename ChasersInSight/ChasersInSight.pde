PShape g_shape;
Camera camera;
PShader neon;
Palette palette;

boolean debug = false;
boolean debugView = false;
boolean useShader = false;
boolean zoomedOut = false;

Stars stars;
StarChasers starChasers;

PVector chaserTarget;

Animator animator;

void setup() {
  size(1000, 1000, P3D);
  smooth(8);
  frameRate(60);

  camera = new Camera();
  chaserTarget = camera.target.pos;
  neon = loadShader("neon.glsl");

  palette = new Palette();
  palette.loadPalette("palette_tuttifruty");

  stars = new Stars();
  regenerate();

  starChasers = new StarChasers();

  animator = new Animator(new PVector(), "textures/anim_0/frame_", 4, 5);
}

void draw() {
  background(0);

  push();
  {
    beginCamera();
    camera.run();
    scale(1);
    if ( !debugView ) {
      shape(g_shape);
    } else {
      stars.renderDebug();
    }
    starChasers.run();
    endCamera();
  }
  pop();

  if ( useShader ) {
    filter(neon);
  }

  animator.run();

  record();
}


void keyPressed() {
  if ( key == '0' ) {
    regenerate();
  }

  if ( key == 'r' ) {
    recording = true;
  }

  if ( key == 's' ) {
    screenshot();
  }

  // debug view
  if ( key == '7' ) { 
    debugView = true;
  }
  if ( key == '4' ) { 
    debugView = false;
  }

  // debug info
  if ( key == '8' ) { 
    debug = true;
  }
  if ( key == '5' ) { 
    debug = false;
  }

  // Neon shader
  if ( key == '9' ) { 
    useShader = true;
  }
  if ( key == '6' ) { 
    useShader = false;
  }

  // Zoomed out
  if ( key == '1' ) { 
    zoomedOut = true;
  }
  if ( key == '2' ) { 
    zoomedOut = false;
  }
}
