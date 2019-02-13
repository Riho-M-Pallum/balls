 /*

Same as my first object but the collisions are actually elastic and not really funky

Curent config, the bigger ball is not affected by the smaller ball bouncing aginst it

*/

Vecball b;
Vecball b2;

Vecball [] balls  = new Vecball [50];

float vel = 0.5;


void setup(){
  size (1500,1000);
  background(0);
  
  b = new Vecball(width/12,height/12);
  b.r = width/20;
  b.velocity.x = -10;
  b.velocity.y = -1;
  b.vel = vel/2;
  b.m = b.r*.2;
  
  b2 = new Vecball(width,height);
  b2.r = width/12;
  b2.velocity.x = 75;
  b2.velocity.y = 1;
  b2.vel = vel / 10;
  b2.m = b2.r*.1;
  
  for (int i = 0; i<balls.length;i++){
    balls[i] = new Vecball(i*width/39,0);
        balls[i].r = width/40;
    balls[i].velocity.x = 10;
    balls[i].velocity.y = 10;
    balls[i].vel = vel/2;
    balls[i].m = balls[i].r*.1;
  }
  
}



void draw(){
  //background(0);
 /* b.display();
  b.colour();
  b.move();
  b.collision();
  
  b.collisionother(b2);
  b.keyReleased(b2);
  
  b2.display();
  b2.colour();
  b2.move();
  b2.collision();*/
  
  for(int i = 0; i < balls.length;i++){
    balls[i].display();
    balls[i].colour();
    balls[i].move();
    balls[i].collision();
    for ( int j = 0; j<balls.length;j++){
      balls[i].collisionother(balls[j]);
    }
  }
}
