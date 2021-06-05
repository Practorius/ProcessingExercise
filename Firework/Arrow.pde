class Arrow{
  PVector pos;
  PVector vel;
  PVector grav = new PVector(0, 0.02);
  //PVector py;
  
  Arrow(){
     pos = new PVector(random(width), height);
     vel = new PVector(random(-1, 1), random(-5, -3));
  }
  
  void update(){
    vel.add(grav);
    pos.add(vel);
  }
  
  void show(){
    update();
    noStroke();
    fill(255);
    ellipse(pos.x, pos.y, 5, 5);
  }
}
