class FadeLine {
  
  int time, timeStep; // fading time
  float a, d;
  
  FadeLine(float angle, float distance){
    time = trailLength;
    timeStep = 255/time;
    a = angle;
    d = distance;
  }
  
  
  void draw(){
    pushMatrix();
    translate(origin.x, origin.y); // move graph to origin
    rotate(-a*PI/180); // rotate to angle
    noStroke();
    fill(255, 0, 0, time*timeStep); // red
    arc(0, 0, radarLen, radarLen, -PI/360, PI/360); // draw background
    fill(0, 255, 0, time*timeStep); // green
    arc(0, 0, d, d, -PI/360, PI/360); // draw detected distance
    popMatrix();
    if (time > 0) time -= 1;
  }
}