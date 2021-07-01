class Bubble{
  PVector pos;
  float diameter;
  PVector vel;
  float xvel, yvel;
  int col;
  boolean fill;
  
  Bubble(float x, float y, float d){
    pos = new PVector(x, y);
    diameter = d;
    
    xvel = random(-2, 2);
    yvel = random(-2, 2);
    
    vel = new PVector(xvel, yvel);
    
    col = floor(map(y, 0, height, 0, 255));
    if(random(1) < 0.2){
      fill = true;
    }else{
      fill = false;
    }
  }
  
  void update(){   
   pos.add(vel); 
   col = floor(map(pos.y, 0, height, 0, 255));
  }
  
  void show(){
    colorMode(HSB);
    if(fill){
      fill(col, 255, 150);
    }else{
      noFill();
    }
    stroke(col, 255, 255);
    ellipse(pos.x, pos.y, diameter, diameter); 
  }
  
}
