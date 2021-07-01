/******************************************************
 RecursiveMovingBubbles.pde
 Created by: Practorius
 Date: 2021 07 01
 Created with: Processing 3.5.4
 ======================================================
 Based on RecursiveBubbles
 ======================================================
 This program initially creates recursive Bubbles on 
 canvas. On creation it will initialize a speed for
 given bubble. Color of Bubble is based on Y-position.
 Filling the bubble is based on 20% chance.
 ******************************************************/
float initD;
ArrayList<Bubble> balls = new ArrayList<Bubble>();

void setup() {
  size(900, 600);

  if (width<=height) {
    initD = 0.9 * width;
  } else {
    initD = 0.9*height;
  }

  /*Initilize all recursive bubbles */
  makeBubbles(0.5*width, 0.5*height, initD);
}


void draw() {
  background(0);
  noFill();

  for (int i = 0; i < balls.size(); i++) {
    balls.get(i).update();
    balls.get(i).show(); 
    if (balls.get(i).pos.x + 0.5 * balls.get(i).diameter < 0 || 
      balls.get(i).pos.x - 0.5 * balls.get(i).diameter > width ||
      balls.get(i).pos.y - 0.5 * balls.get(i).diameter > height) {
      balls.remove(i);
    }
  }
}

/* This part is the recursive part */
void makeBubbles(float x, float y, float d) {
  balls.add(new Bubble(x, y, d)); 

  if (d>2) {
    makeBubbles(x - random(50), random(height), d*0.6);
    makeBubbles(x + random(50), random(height), d*0.6);
  }
}
