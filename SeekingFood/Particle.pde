class Particle {
  PVector pos;
  PVector vel;
  PVector acc;        //This will be used when the wind is not 0

  float r = 3;        //The particle size
  float lifespan = 255;
  float inc;          //The increment for lifespan of particle

  boolean detected;  //The detected boolean will be set by the detection of the particle by vehicle

  Particle(PVector p_) {
    pos = p_.copy();
    vel = new PVector(random(-1, 1), random(-1, 1));
    //vel = new PVector(-1, -1);
    acc = new PVector(0, 0);
    inc = random(2);            //Increment is a random number between 0 and 2
    detected = false;
  }

  void checkEdges() {
    if (pos.x < 0 | pos.x>width | pos.y<0 | pos.y > height) {
      lifespan = 0;
    }
  }
  void applyforce(PVector f_) {
    PVector force = f_.copy();
    acc.add(force);
  }
  void update() {
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);

    lifespan -= inc;
    checkEdges();
  }

  void show() {
    stroke(90);
    fill(lifespan);
    ellipse(pos.x, pos.y, r, r);
  }
}
