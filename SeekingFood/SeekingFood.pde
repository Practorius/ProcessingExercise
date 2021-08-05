/*********************************************************
 SeekingFood.pde
 ========================================================
 Author      : Practorius
 Date        : 05 aug 2021
 Created with: Processing 3.5.4
 --------------------------------------------------------
 Used classes: ParticleSystem
               Particles
               Vehicle
 --------------------------------------------------------
 This program creates moving sources of particles. The 
 vehicle will either receive (or sniff) these particles
 or not. If it sniffs particles it will move in the average
 direction of the sniffed particles. If not it will move
 in a random fashion until it dies.
 *********************************************************/
ArrayList<ParticleSystem> systems;
int maxSystems = 3;

Vehicle v;
PVector wind;          //Set the wind in the setup, if needed. It will be used to direct particles

void setup() {
  size(600, 600);
  systems = new ArrayList<ParticleSystem>();
  systems.add(new ParticleSystem());

  //wind = new PVector(random(-0.01, 0.01), random(-0.01, 0.01));
  wind = new PVector(0, 0);

  v = new Vehicle();
}

void draw() {
  background(0);

  //Display the particleSystem
  for (int i = 0; i<systems.size(); i++) {
    if(systems.get(i).maxParts <= 0){
      systems.remove(i);
    }
    systems.get(i).show(wind);
  }

  //Do something with the vehicle
  v.show();
  v.update();

  //Check if any particles are detected by the vehicle
  //The detect is part of the main program
  detect();     
    
  addNewSystem();          //Check if a new system should be added
  //Stop the program if the vehicle is dead
  if(v.lifespan <= 0){
    stroke(255, 0, 0);
    fill(255, 0, 0);
    textSize(45);
    text("I died :o(", 100, 255);
    noLoop();
  }
}

void detect() {
  for (int y = 0; y< systems.size(); y++) {
    for (int i=0; i<systems.get(y).particles.size(); i++) {
      systems.get(y).particles.get(i).detected = v.detect(systems.get(y).particles.get(i).pos, systems.get(y).particles.get(i).vel);
    }
  }
}

void addNewSystem(){
  if(systems.size() < maxSystems){
    for(int i=0; i<systems.size(); i++){
      if(systems.get(i).lifespan < 3){
        systems.add(new ParticleSystem());
      }
    }
  }
}
