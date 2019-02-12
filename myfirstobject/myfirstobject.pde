  // varialbes
  /*
  to do: sort out collision detenction between balls, currently only works if
  they come at eachother from opposite sides
  also it only work when a small radius inside the ball touches the small radius
  inside the other ball i.e. if gate logic needs to be looked over
  */
ball b;
float vel = 0.5;

ball b2;

void setup(){      // void setup
 background(0);
 size(1500,1000);
 
 b = new ball();
 b.x = width;
 b.y = height+100;
 b.r = width/12;
 b.velx = 75;
 b.vely = 1;
 
 b2 = new ball();
 b2.x = 0;
 b2.y = 0;
 b2.r = width/20;
 b2.velx = -10;
 b2.vely = -1;
}

void keyPressed(){      // void key pressed
 
  if (key == CODED){
    if(keyCode == UP){
     b.vely -= vel/2; 
     b2.vely -= vel*4;
     key = 0;
    }
    if(keyCode == DOWN){
     b.vely += vel/2; 
     b2.vely += vel*4;
     key = 0;
    }
    if(keyCode == RIGHT){
     b.velx += vel/2; 
     b2.velx += vel*4;
     key = 0;
    }
    if(keyCode == LEFT){
      b.velx -= vel/2; 
      b2.velx -= vel*4;
      key = 0;
    }
  }
  if (key == TAB){
   b.velx = 0;
   b.vely = 0;
   b2.velx = 0;
   b2.vely = 0;
   key = 0;
  }
  if (key == 'd'){
   background(0); 
  }
}

void draw(){      // void main
  //background(0);
  stroke(random(0,255),random(0,255),random(0,255));
  //b.display();
  b2.display();
  
  //b.move();
  b2.move();
  
  b.colour();
  b2.colour();
  
  if(b.y-b.r/2 <= 0){      //b1 up collosion
    b.vely = abs(b.vely); 
  }
  if(b.x-b.r/2 <= 0){   //b1 left collision
   b.velx = abs(b.velx); 
  }
  else if (b.y+b.r/2 > height){    //b1 down collision
    b.vely =  -abs(b.vely); 
  }
  if(b.x+b.r/2 >= width){      //b1 right collision
    b.velx = -abs(b.velx); 
  }
  
    if(b2.y-b2.r/2 <= 0){      //b2 up collosion
    b2.vely = abs(b2.vely); 
  }
  if(b2.x-b2.r/2 <= 0){   //b2 left collision
   b2.velx = abs(b2.velx); 
  }
  else if (b2.y+b2.r/2 > height){    //b2 down collision
    b2.vely =  -abs(b2.vely); 
  }
  if(b2.x+b2.r/2 >= width){      //b2 right collision
    b2.velx = -abs(b2.velx); 
  }
  
 /* for(int z = -b.r/10; z<b.r;z+=z){
    for (int w = -b2.r/10; w <b2.r; w+=w){
       if(b2.x + w == b.x + z && b2.y +w == b.x + z){
         b.velx = -b.velx;
         b2.velx = -b2.velx;
         b.vely = -b.vely;
         b2.vely = -b2.vely;
       }      
     }
  }*/
  if(b2.x + b2.r < b.x +b.r && b2.x -b2.r > b.x - b.r 
      && b2.y +b2.r < b.y + b.r && b2.y -b2.r > b.y -b.r){
    print("tru");
    b.velx = -b.velx;
    b2.velx = abs(b.velx)/b.velx * b2.velx;
    b.vely = -b.vely;
    b2.vely = abs (b.vely ) / b.vely *b2.vely;
  }
}
