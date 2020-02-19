import processing.serial.*;

Serial serialIn; // create serial object
String arduino = "COM4", input;

Circle circle;
float speed = 30, sum, num, prevNum = 0;

void setup(){
  size(800, 640);
  background(0, 230, 230);
  noStroke();
  
  serialIn = new Serial(this, arduino, 9600);
  serialIn.clear(); // clear the port
  circle = new Circle();
}

void updateNum(float n){
  num = n - prevNum;
  num = constrain(num, -3, 3);
  prevNum = prevNum + num;
  //println(num, n, prevNum);
}


void draw(){
  background(0, 230, 230);
  println(prevNum);
  circle.rotate(prevNum);
  
  if (0 < serialIn.available()){
    input = serialIn.readString().trim(); // read string and trim to clean data
    num = float(input);
    if (Float.isNaN(num)){}
    else {
      if (0 < num) updateNum(float(input));
      else updateNum(35);
    }
  }
  serialIn.clear();
}