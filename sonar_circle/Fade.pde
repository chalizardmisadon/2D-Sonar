class Fade {
  
  // variable
  int time;
  float posx, posy;
  
  Fade(float x, float y){
    time = 15;
    posx = x;
    posy = y;
  }
  
  
  void draw(){
    fill(0, 0, 0, time*17);
    ellipse(posx, posy, time*6, time*6);
    if (time > 0) time -= 1;
  }
}