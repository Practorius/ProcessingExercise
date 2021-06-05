import processing.sound.*;
SoundFile file;

//Fireworks challange
//Create a fireworks display with multicolor fireworks
ArrayList<Arrow> fireworks = new ArrayList<Arrow>();
ArrayList<ParticleSystem> ps = new ArrayList<ParticleSystem>();


void setup() {
  size(700, 700); 
  fireworks.add(new Arrow());
  
  file = new SoundFile(this, "explosion.wav");
}

void draw() {
  background(0);
  if (random(1) < 0.05) {
    fireworks.add(new Arrow());
  }

  //test ppurpose
  //if(fireworks.size() < 1){
  //  fireworks.add(new Arrow());
  //}

  for (int i = 0; i < fireworks.size(); i++) {
    fireworks.get(i).show();
   
    if(fireworks.get(i).vel.y >= 0){
      file.play();
      ps.add(new ParticleSystem(fireworks.get(i).pos));
      fireworks.remove(i);
    }
    
    else if (fireworks.get(i).pos.y > height || fireworks.get(i).pos.y < 0 || 
      fireworks.get(i).pos.x < 0 || fireworks.get(i).pos.x > width) {
      fireworks.remove(i);
    }
    
  }
  
  for(int p = 0; p<ps.size(); p++){
    ps.get(p).display();
    if(ps.get(p).particles.size() <=0){
      ps.remove(p);
    }
    println(ps.size());
  }
}
