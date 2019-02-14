 /*

Same as my first object but the collisions are actually elastic and not really funky

Curent config, the bigger ball is not affected by the smaller ball bouncing aginst it

*/



Vecball b;
Vecball b2;

Vecball [] balls  = new Vecball [300];

float vel = 0.5;


void setup(){
  size (1900,1000);
  background(255);
  
  int radius = width/100;    // radius of smallest balls
  
  b = new Vecball(width/12,height/12);    // creates an object and spawns it at specified location
  b.r = width/20;        // radius of ball
  b.velocity.x = -10;    //x velocity of ball
  b.velocity.y = -1;      // y velocity of ball
  b.vel = vel/100;      // velocity change when keys are pressed
  b.m = b.r*.2;        // mass for elastic collisions
  
  b2 = new Vecball(width,height);
  b2.r = width/12;
  b2.velocity.x = 75;
  b2.velocity.y = 1;
  b2.vel = vel / 10;
  b2.m = b2.r*.1;
  
  for (int i = 0; i<balls.length;i++){
    if(i*radius+radius+2<width){
     balls[i] = new Vecball(i*radius+radius+1,width/6); 
    }
    else if(i*radius+radius+2<width*2){
     balls[i] = new Vecball((i-pow(radius,-1)*width)*radius+radius,2*width/6); 
    }
    else if(i*radius+radius+2<width*3){
     balls[i] = new Vecball((i-pow(radius,-1)*width*2)*radius+radius,3*width/6); 
    }
    else if(i*radius+radius+2<width*4){
     balls[i] = new Vecball((i-pow(radius,-1)*width*3)*radius+radius,4*width/6); 
    }
    else if(i*radius+radius+2<width*5){
      balls[i] = new Vecball((i-pow(radius,-1)*width*4)*radius+radius,5*width/6); 
    }
   // balls[i] = new Vecball(random(0,width),random(0,height));
   // balls[i] = new Vecball(0,0);
    balls[i].r = radius;
    balls[i].velocity.x = 0;
    balls[i].velocity.y = 2;
    balls[i].vel = vel;
    balls[i].m = balls[i].r*.1;
  }
  
}
void keyPressed(){

}


void draw(){
  //background(255);                    // doesn't delete their trails
  /*b.display();
  b.colour();
  b.move();
  b.collision();
 
  b.keyReleased();
  b.collisionother(b2); 
 /* b2.display();
  b2.colour();
  b2.move();
  b2.collision();*/
  
  for(int i = 0; i < balls.length;i++){
    b.collisionother(balls[i]);
    //b2.collisionother(balls[i]);
    balls[i].display();                          // draws them
    balls[i].colour();                          // makes them flashy
    balls[i].move();                            // makes them move at all
    balls[i].key();
    balls[i].collision();                      // collisions with walls
    for ( int j = 0; j<balls.length;j++){      // inefficient, a lot of double checks
      balls[i].collisionother(balls[j]);        //balls collision with each other

    }
  }
}
