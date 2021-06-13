/******************************************************
 RecursiveBubbles.pde
 Created by: Practorius
 Date: 2021 06 13
 Created with: Processing 3.5.4
 ======================================================
 Based on Coding Train Challenge #77 by Daniel Shiffman
 ======================================================
 This is my take on recursion and drawing ' bubbbles'  
 with it. The initial diameter based on the width and
 height of the canvas.
 The stroke color of the bubble depends on the position
 on the canvas. The fill color depends on the position
 on the canvas and a 20% change of it being filled.
 ******************************************************/
float initD;

void setup() {
  size(900, 600);
  if (width<=height) {
    initD = 0.9 * width;
  } else {
    initD = 0.9*height;
  }
}


void draw() {
  background(0);
  noFill();
  drawFigure(0.5*width, 0.5*height, initD);
  noLoop();
}

void drawFigure(float x, float y, float d) {

  float col = map(y, 0, height, 0, 255);
  colorMode(HSB);
  if (random(1) < 0.2) {
    fill(col, 255, 150);
  } else {
    noFill();
  }
  stroke(col, 255, 255);
  ellipse(x, y, d, d); 

  if (d>2) {
    drawFigure(x - random(50), random(height), d*0.6);
    drawFigure(x + random(50), random(height), d*0.6);
  }
}
