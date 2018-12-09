PShape makeShapeCluster() {
  PShape s = createShape();
  float range = 300;
  PVector amp_ex = PVector.random3D();
  amp_ex.mult(10.0);
  PVector dist = PVector.random3D();
  dist.mult(100);
  //float hue = map(mouseY, 0, height, 0, 360);
  int nb = 40000;
  float ex_n = 0.003;
  float n_off = random(10000, 99999);
  
  s.beginShape(POINTS);
  s.noFill();
  s.strokeWeight(4);
  
  for ( int i = 0; i < nb; ++i ) {
    PVector vec = PVector.random3D();
    float d = random(range * 0.999, range);
    d += sin(vec.x*amp_ex.x + vec.z*amp_ex.z*0.5)*dist.x;
    d += cos(vec.y*amp_ex.y + vec.x*amp_ex.x*2.0)*dist.y;
    d += cos(vec.z*amp_ex.z)*dist.z;
    vec.mult(d);
    
    float n = noise(vec.x * ex_n, vec.y * ex_n, n_off + vec.z * ex_n);
    s.stroke(palette.col(n*2.5));
    s.vertex(vec.x, vec.y, vec.z);
  }
  s.endShape();
  
  return s;
}

void initStars() {
 stars.s.clear();
 
 for ( int i = 0; i < g_shape.getVertexCount(); ++i ) {
   if ( random(1) > 0.7 ) {
     PVector vec = g_shape.getVertex(i);
     stars.addStar(vec);
   }
 }
}
