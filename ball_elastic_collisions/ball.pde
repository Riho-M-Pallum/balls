class Vecball{
  
 
  PVector velocity;     // velocity vector
  PVector position;     // position vector
  float r;              // diameter
  float vel;            // button press velocity change
  float m;              //mass for resulting speed calculation, not the value but the ratio that matters
  
  Vecball(float x, float y){      // initiate position of ball
    position = new PVector (x,y);
    velocity = new PVector();
  }
  
  
  void display (){              // displays ball
    //noStroke();
    ellipse (position.x,position.y,r,r);
  }
  
  
  void move(){                // movement logic
    position.add(velocity);
  }
  
  
  void colour(){            // makes ball flashy
    //noStroke();
    stroke(random(0,255),random(0,255),random(0,255));
    fill(random(0,255),random(0,255),random(0,255));
  }
  
  
  void collision(){      // collision with edges logic
    if(position.x-r/2<= 0){
      velocity.x = abs(velocity.x); 
    }
    if(position.x+r/2>= width){
      velocity.x = -abs(velocity.x); 
    }
    if (position.y-r/2 <= 0){
      velocity.y = abs(velocity.y);   
    }
    if(position.y+r/2 >= height){
      velocity.y = -abs(velocity.y); 
    }
  } 
  
  
  void keyReleased(Vecball other){  // allows you to control the speed of the ball with arrow keys
    if (keyCode == UP){
      velocity.y -= vel;
      other.velocity.y -= other.vel;
      keyCode = 0;
    }
    if (keyCode == RIGHT){
      velocity.x += vel; 
      other.velocity.x += other.vel;
      keyCode = 0;
    }
    if(keyCode == DOWN){
      velocity.y +=vel; 
      other.velocity.y += other.vel;
      keyCode = 0;
    }
    if(keyCode == LEFT){
      velocity.x -= vel; 
      other.velocity.x -= other.vel;
      keyCode = 0;
    }
    if (key == TAB){
      velocity.x = 0;
      velocity.y = 0;
      other.velocity.x = 0;
      other.velocity.y = 0;
      key = 0;
    }
    if(key == 'F'){
      velocity.x *= -1;
      velocity.y *= -1;
      other.velocity.x *= -1;
      other.velocity.y *= -1;
      key = 0;
      
    }
  }
  
  
  void collisionother(Vecball other){      // a Vecball objcet called other, also this whole thing is shamelessly copied off of the internet(at least i tried to understand how it works, and somewhat did)
  //and i have no idea what most of the bTemp and bFinal things , the bloody thing even works without them
    PVector distance = PVector.sub(other.position, position);  // PVector.sub substracts the x and y components of one vector from another vector, vector from position to other.poition
    float distancemag = distance.mag();                        // distance or magnitude of distance vector
    float distangle = distance.heading();                      // angle vector makes to horizontal
    
    if (distancemag<(r+other.r)/2){                                        // if distance is smaller than radius of both then
    
      float distanceCorrection = ((r+other.r)/2-distancemag)/2.0;      // making suret that the balls don't end up inside eachother, doesn't happen often anyway(unless going really fast)
      PVector d = distance.copy();
      PVector correctionVector = d.normalize().mult(distanceCorrection);
      other.position.add(correctionVector);
      position.sub(correctionVector);
                                                                       // do vector rotation          "x2=cosβx1−sinβy1, y2=sinβx1+cosβy1"
                                                                       
                                                                       
                                                                       
      // actual vector calculation starts here
      float sin = sin(distangle);
      float cos = cos(distangle);      
        /* bTemp will hold rotated ball positions. You 
         just need to worry about bTemp[1] position*/
      /*PVector[] bTemp = {
        new PVector(), new PVector()
      };*/
    
                                                                        /* this ball's position is relative to the other  
                                                                         so you can use the vector between them (bVect) as the 
                                                                         reference point in the rotation expressions.
                                                                         bTemp[0].position.x and bTemp[0].position.y will initialize
                                                                         automatically to 0.0, which is what you want
                                                                         since b[1] will rotate around b[0] */
/*      bTemp[1].x  = cos * distance.x + sin * distance.y;    //  X/r*X + Y/r*Y = x2/r +y2/r
      bTemp[1].y  = cos * distance.y - sin * distance.x;    // X/r*Y + Y/r*X = 2YX/r 
  */
        // rotate Temporary velocities, HL math bitches, we haven't done vector rotation yet. But it's actually quite simple "x2=cosβx1−sinβy1, y2=sinβx1+cosβy1"
      PVector[] vTemp = {
        new PVector(), new PVector()
      };
  
      vTemp[0].x  = cos * velocity.x + sin * velocity.y;
      vTemp[0].y  = cos * velocity.y - sin * velocity.x;
      vTemp[1].x  = cos * other.velocity.x + sin * other.velocity.y;
      vTemp[1].y  = cos * other.velocity.y - sin * other.velocity.x;
  
                                                                                        /* Now that velocities are rotated, you can use 1D
                                                                                         conservation of momentum equations to calculate 
                                                                                         the final velocity along the x-axis. */
      PVector[] vFinal = {  
        new PVector(), new PVector()
      };
  
                                                                                              // final rotated velocity for b[0]
      vFinal[0].x = ((m - other.m) * vTemp[0].x + 2 * other.m * vTemp[1].x) / (m + other.m);
      vFinal[0].y = vTemp[0].y;
  
                                                                                          // final rotated velocity for b[0]
      vFinal[1].x = ((other.m - m) * vTemp[1].x + 2 * m * vTemp[0].x) / (m + other.m);
      vFinal[1].y = vTemp[1].y;
  
                                                                          // hack to avoid clumping, also no idea what it does
                                                                         // bTemp[0].x += vFinal[0].x;
                                                                          //bTemp[1].x += vFinal[1].x;
                                                                    
                                                                          /* Rotate ball positions and velocities back
                                                                           Reverse signs in trig expressions to rotate 
                                                                           in the opposite direction */
                                                                          // rotate balls
                                                                        /*  PVector[] bFinal = { 
                                                                            new PVector(), new PVector()
                                                                          };
                                                                    
                                                                          bFinal[0].x = cos * bTemp[0].x - sin * bTemp[0].y;
                                                                          bFinal[0].y = cos * bTemp[0].y + sin * bTemp[0].x;
                                                                          bFinal[1].x = cos * bTemp[1].x - sin * bTemp[1].y;
                                                                          bFinal[1].y = cos * bTemp[1].y + sin * bTemp[1].x;
                                                                    
                                                                          // update balls to screen position
                                                                          other.position.x = position.x + bFinal[1].x;
                                                                          other.position.y = position.y + bFinal[1].y;
                                                                    
                                                                          position.add(bFinal[0]);*/
                                                                    
                                                                          // update velocities
      velocity.x = cos * vFinal[0].x - sin * vFinal[0].y;
      velocity.y = cos * vFinal[0].y + sin * vFinal[0].x;
     other.velocity.x = cos * vFinal[1].x - sin * vFinal[1].y;             //   DECOMMENT TO MAKE BALL HAVE ELASTIC COLLISIONS AGAIN
     other.velocity.y = cos * vFinal[1].y + sin * vFinal[1].x; 
    }
  }
}
