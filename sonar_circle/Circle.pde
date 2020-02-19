class Circle {
  
  PVector position, center, radial;
  
  float speed = 0, acc, RPS = TWO_PI / 60;
  float maxAcc = RPS/40, radius = 200;
  ArrayList<Fade> trail;
  boolean remove = true;
  
  Circle(){
    radial = new PVector(radius, 0);
    center = new PVector(width/2, height/2);
    trail = new ArrayList<Fade>();
  }
  
  void rotate(float f){ // f for frequency
  
  
    f = max(1, f); // limit smallest value
    f = min(f, 31); // limit biggest value
    
    f = (36-f)/25 + 0.05; // scale it down
    f = f*RPS; // desired frequency
    
    acc = f - speed; // finding acceleration
    acc = constrain(acc, -maxAcc, maxAcc); // limit max acceleration
    
    speed += acc; // movement
    radial.rotate(speed);
    position = PVector.add(center, radial);
    
    draw();  
  }
  
  void draw(){
    fill(0, 0, 0);
    ellipse(center.x, center.y, 20, 20);
    
    trail.add(new Fade(position.x, position.y));
    
    remove = true;
    while (remove){
      if (trail.get(0).time <= 0) trail.remove(0);
      else remove = false;
    }
    for (Fade object : trail){
      object.draw();
    }
  }
  
}