class ParticleSystem {
  PVector pos;
  PVector vel;

  ArrayList<Particle> particles = new ArrayList<Particle>();

  //Voor test
  int counter;     //counter to depend bloomtime on - counter goes up to 50 until bloomtime is decreased
  int lifespan;    //maximum lifespan of system
  int maxParts;    //maximum number of particles it will be able to hold

  ParticleSystem() {
    //pos = new PVector(0.5*width, 0.5*height);
    pos = new PVector(random(width), random(height));
    //vel = new PVector(0, 0);
    vel = new PVector(random(-0.5, 0.5), random(-0.5, 0.5));
    particles.add(new Particle(pos));

    lifespan = floor(random(4, 15));
    maxParts = floor(random(255, 1000));
    counter = 0;
  }

  void update() {
    //Add new particle to system if there is room
    if (particles.size() < maxParts) {
      particles.add(new Particle(pos));
    }
    //Calculate new position with velocity
    pos.add(vel);
    
    //Check edges and recalc velocity vector
    checkEdges();
    
    //Update lifespan
    if (lifespan > 0) {
      calcLifespan();
    }else{
      maxParts -= 1;
    }
    
  }

  void show(PVector w_) {
    update();          //Update the particle system by moving it and spawning new particle every loop   

    for (int i = 0; i<particles.size(); i++) {
      particles.get(i).applyforce(w_);
      particles.get(i).update();
      if (particles.get(i).lifespan<=0 | particles.get(i).detected == true) {
        particles.remove(i);
      } else {
        particles.get(i).show();
      }
    }
  }

  void checkEdges(){
    if (pos.x < 0 | pos.x > width) {
      vel.x *= -1;
    }
    if (pos.y < 0 | pos.y > height) {
      vel.y *= -1;
    }
  }

  void calcLifespan() {
    counter += 1;
    if (counter >= 50) {
      lifespan -= 1;
      counter = 0;
    }
  }
}
