class ParticleSystem{
 ArrayList<Particle> particles;
 PVector origin;
 
 int elements = 25;
 
 int colorFirework;
 
 ParticleSystem(PVector o){
   origin = o;
   colorFirework = floor(random(0, 256));
   particles = new ArrayList();
   for(int i = 0; i< elements; i++){
     particles.add(new Particle(origin, colorFirework));
   }
 }
 
 void display(){
    for(int i = 0; i < particles.size(); i++){
      particles.get(i).update();
      particles.get(i).show();
      if(particles.get(i).lifespan<=0){
        particles.remove(i);
      }
    }
 }
  
  
}
