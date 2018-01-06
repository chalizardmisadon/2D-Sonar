import processing.serial.*;

Serial myPort; // serial object
String arduinoPort = "COM4";
float[] inData;

PVector origin;
float arcRad, gradLen, gradAng, radarLen; // radar variables
float angle = 0, distance = 100; // input variables
int trailLength = 35;

FadeLine[] trail;
boolean remove = true;

void setup(){
  size (1600, 900);
  background(14, 34, 4); // myrtle rgb
  
  origin = new PVector(width/2, height*0.9);
  arcRad = width*0.22; // set arc radius
  gradLen = width*0.45; // set gradation line length
  gradAng = 6; // set angle gradation
  radarLen = (arcRad*4+gradLen*2)/2; // set radar line length
  
  myPort = new Serial(this, arduinoPort, 9600);
  myPort.bufferUntil('\n'); // next line character
  
  trail = new FadeLine[trailLength];
  for (int i = 0; i < trail.length; i++){
    trail[i] = new FadeLine(angle, distance);
  }
}

void draw(){
  background(14, 34, 4); // dark myrtle rgb
  drawRadar();
  
  for (FadeLine object : trail){
    object.draw();
  }
  
  fill(255, 255, 255);
  text("Framerate: " + int(frameRate),10,height-6);
}

void serialEvent(Serial serialIn){ // serial input
  inData = float(serialIn.readString().trim().split(":"));
  angle = inData[0]; // read angle
  distance = inData[1]/100*radarLen; // read distance (cm)
  addNewLine();
}

void addNewLine(){
  for (int i = trail.length-1; 0 < i; i--){
    trail[i] = trail[i-1];
  }
  trail[0] = new FadeLine(angle, distance);
}

void drawRadar(){
  pushMatrix();
  translate(origin.x, origin.y); // move graph to origin
  noFill();
  strokeWeight(2);
  stroke(78, 196, 25);
  
  arc(0, 0, arcRad, arcRad, PI, TWO_PI); // innermost half-circle
  arc(0, 0, arcRad*2, arcRad*2, PI, TWO_PI);
  arc(0, 0, arcRad*3, arcRad*3, PI, TWO_PI);
  arc(0, 0, arcRad*4, arcRad*4, PI, TWO_PI); // outermost half-circle
  
  for (int g = 0; g < gradAng+1; g++){ // set angle gradation
    pushMatrix();
    rotate(-PI*g/gradAng); // rotate to angle
    line(0, 0, gradLen, 0); // draw line
    popMatrix();
  }
  popMatrix();
}