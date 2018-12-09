color hsbVaryS(color base, float variance) { 
  return hsbModify(base, 0, random(-variance, variance), 0);
}


color hsbModify(color base, float hv, float sv, float bv) { 
  /* The hue should be wrapped around if it crosses 360 */
  float new_hue = (hue(base) + hv) % 360; 
  float new_sat = constrain(saturation(base) + sv, 0, 100); 
  float new_bri = constrain(brightness(base) + bv, 0, 100); 
  return color(new_hue, new_sat, new_bri);
}

color hsbVaryHS(color base, float hv, float sv) { 
  return hsbModify(base, random(-hv, hv), random(-sv, sv), 0);
}

color hsbVarySB(color base, float sv, float bv) { 
  return hsbModify(base, 0, random(-sv, sv), random(-bv, bv));
}

float rybRandAnalog(float hue) {
  hue += degrees(PI * 0.33 * floor(random(-1, 2)));
  return ryb(hue);
}

float rybRandTetradic(float hue) {
  hue += degrees(PI * 0.5 * floor(random(0, 4)));
  return ryb(hue);
}

float rybRandOpp(float hue) {
  hue += degrees(PI * floor(random(0, 2)));
  return ryb(hue);
}

float ryb(float hue) {

  float ryb_hue = 0;

  float[][] ryb_wheel = {
    {  0, 0}, { 15, 8}, { 30, 17}, { 45, 26}, 
    { 60, 34}, { 75, 41}, { 90, 48}, {105, 54}, 
    {120, 60}, {135, 81}, {150, 103}, {165, 123}, 
    {180, 138}, {195, 155}, {210, 171}, {225, 187}, 
    {240, 204}, {255, 219}, {270, 234}, {285, 251}, 
    {300, 267}, {315, 282}, {330, 298}, {345, 329}, 
    {360, 0  }
  };

  hue = hue % 360;

  for (int i = 0; i < ryb_wheel.length - 1; i++) {

    float x0 = ryb_wheel[i][0];
    float y0 = ryb_wheel[i][1];
    float x1 = ryb_wheel[i + 1][0];
    float y1 = ryb_wheel[i + 1][1];

    /* Ensure that y1 > y0 */
    if (y1 < y0)
      y1 += 360;

    /* If hue lies between y0 and y1, do linear mapping */
    if (hue >= x0 && hue < x1) {
      ryb_hue = map(hue, x0, x1, y0, y1) % 360;
      break;
    }
  }
  return ryb_hue;
}
