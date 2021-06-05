class Particle{
  PVector loc;
  PVector vel;
  PVector grav;
  
  int lifespan;
  int colorFirework;
  
  Particle(PVector explosion, int cFW){
    loc = explosion.copy();
    grav = new PVector(0, 0.05);
    vel = new PVector(random(-2, 2), random(-2, 2));
    
    lifespan = floor(random(180, 256));
    
    colorFirework = cFW;
  }
  
  void update(){
    vel.add(grav);
    loc.add(vel);
    lifespan -= 5;
  }
  
  void show(){
    noStroke();
    colorMode(HSB, 255);
    //fill(colorFirework, lifespan, 255);
    fill(colorFirework, 255, lifespan);
    //fill(lifespan);
     ellipse(loc.x, loc.y, 5, 5); 
  }
  
  
  
}
