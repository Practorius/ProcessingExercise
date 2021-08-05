class Vehicle {
  PVector position;

  FloatList headings;

  float radius = 6;             //The radius of the vehicle itself
  float sniffer_radius = 50;    //The radius of it's (sniff) horizon
  float lifespan = 255;
  float increment = 0.5;        //increment for lifespan
  float stepsize = 30;          //max stepsize, the actual step will be a random number based on this max

  int sniffed; 
  int thinkcount;             //this will be used to 'think' slower if the vehicle becomes hungry
  int thinkspeed;             //this will be the limit for the think proces. It will start with 50
  //and can increase or decrease depending on the amount of hunger the vehicle has

  //Previous values so it can determine if it should move back to that position
  PVector prevPosition;
  int prevSniffed;

  Vehicle() {
    position = new PVector(random(width), random(height));
    prevPosition = position.copy();
    sniffed = 0;
    prevSniffed = 0;
    thinkcount = 0;
    thinkspeed = 50;
    headings = new FloatList();
  }

  void update() {
    if (lifespan<=0) {
      lifespan = 0;
    } else {
      lifespan -= increment;
    }

    thinkcount += 1;
    if (thinkcount >= thinkspeed) {  //If the thinktime is up, the vehicle will move and reset some values
      move();
      thinkcount = 0;
      headings = new FloatList();    //reset FloatList headings
    }
  }

  void move() {
    PVector newPos;

    if (sniffed > prevSniffed) {        //If ite sniffed more particles than previous it will move
      prevPosition = position.copy();   //Remeber this current position
      //If it sniffed particles it will move in the average direction of those sniffed particles
      newPos = calcPos(newHeading(), random(stepsize));
      position.add(newPos);
    } else if (sniffed < prevSniffed) {  //If it sniffed less particles it will move back to previous location
      position = prevPosition.copy();
    }
    //In all other cases the vehicle will stay at it's current position

    prevSniffed = sniffed; 
    sniffed = 0;
  }

  void show() {
    stroke(255);

    //Change the background color of the sniff area based on the lifespan. The more if sniffs
    //the brighter the color
    int sb = floor(map(lifespan, 255, 600, 0, 255));
    fill(0, 0, sb);
    //noFill();            //Zet deze aan als je de sniffer geen achtergrond wilt geven
    ellipse(position.x, position.y, sniffer_radius, sniffer_radius); 

    int cr = floor(lifespan);
    int cg = floor(map(lifespan, 0, 255, 0, 150));
    int cb = floor(map(lifespan, 0, 255, 0, 180));
    fill(cr, cg, cb);
    ellipse(position.x, position.y, radius, radius);

    //Show text on screen of its health
    stroke(255);
    fill(255);
    textSize(21);
    text(commentTxt(lifespan), 50, 40);
  }

  boolean detect(PVector p_, PVector v_) {
    //If a particle is sniffed change it's detection to true
    if (dist(position.x, position.y, p_.x, p_.y) <= 0.5 * sniffer_radius) {
      lifespan+=50;      //Increase the lifespan when a particle is sniffed
      sniffed += 1;      //Increase the number of sniffed particles
      
      //Flash a green circle when some thing was detected
      fill(0, 255, 0);
      ellipse(500, 50, 25, 25);
      //End of green circle
      
      float nh;              //Determine what the heading of the vehicle should be based on that one
      //particle that was detected and store it in an arraylist
      if (v_.heading() < 0) {
        nh = PI + v_.heading();
      } else {
        nh = -PI + v_.heading();
      }
      headings.append(nh);    //Store the heading for later calculations
      return true;
    } else {              
      return false;
    }
  }

  float newHeading(){        //calculate an average heading based on the particles that were sniffed
    int nr = headings.size();
    float tot = 0;
    float newHead;
    for (int i=0; i<headings.size(); i++) {
      tot += headings.get(i);
    }
    newHead = tot/nr;
    return newHead;
  }

  PVector calcPos(float h_, float s_) {  //calculate a new step based on avg heading and random stepsize
    PVector xy;
    float x = s_ * cos(h_);
    float y = s_ * sin(h_);
    xy = new PVector(x, y);
    return xy;
  }

  String commentTxt(float l_) {         //Do stuff to in-/decrease thinkspeed and what kind of text to show
    //println(thinkspeed, thinkcount);

    if (l_ <= 0) {
      return "I died :-(";
    } else if (lifespan<=100) {
      if (thinkspeed >= 75) {
        thinkspeed = 75;
      } else {
        thinkspeed += 1;
      }
      return "Need food :-O";
    } else if (lifespan<=180) {
      if (thinkspeed >= 50) {
        thinkspeed = 50;
      } else {
        thinkspeed += 1;
      }
      return "Getting hungry :-|";
    } else {
      if (thinkspeed <= 0) {
        thinkspeed = 0;
      } else {
        thinkspeed -= 1;
      }
      return "Doing fine :-)";
    }
  }
}
