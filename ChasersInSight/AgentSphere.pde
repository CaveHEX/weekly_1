class AgentSphere {
 
  PVector pos = new PVector();
  PVector ang = new PVector();
  PVector vel = new PVector();
  PVector acc = new PVector();
  float friction = 0.98;
  float speedEx = 0.0003;
  
  float radius = 300;
  
  float mood = 0;
  float moodChange = 50;
  
  float dir = random(TWO_PI);
  float dirAmp = 0.02;
  
  AgentSphere() {
    ang = PVector.random2D();
    ang.mult(TWO_PI);
  }
  
  void update() {
    PVector wind = PVector.random3D();
    wind.mult(speedEx);
    this.applyAngularForce(wind);
    
    this.updateMood();
    
    PVector forth = new PVector(cos(dir), sin(dir));
    forth.mult(speedEx);
    
    this.applyAngularForce(forth);
    
    this.physics();
    
    pos.x = radius * cos(ang.x) * sin(ang.y);
    pos.y = radius * sin(ang.x) * sin(ang.y);
    pos.z = radius * cos(ang.y);
  }
  
  void render() {
    push();
    translate(pos.x, pos.y, pos.z); 
    stroke(255, 100);
    strokeWeight(5.0);
    point(0, 0, 0);
    pop();
  }
  
  void run() {
   this.update();
   this.render();
  }
  
  void physics() {
    vel.add(acc);
    vel.mult(friction);
    ang.add(vel);
    acc.mult(0);
  }
  
  void applyAngularForce(PVector force) {
   acc.add(force); 
  }
  
  void updateMood() {
    mood += 1;
    
    if ( random(1 * map(mood, 0, moodChange, 0, 1)) > 0.9 ) {
      mood = 0;
      this.changeDirection();
    }
  }
  
  void changeDirection() {
    dir += random(-dirAmp, dirAmp);
  }
}
