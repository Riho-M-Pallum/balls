class ball{
  
  float x =0;
  float y= 0;
  int r= 0;
  float velx =0;
  float vely = 0;
  
  
  ball(){}
  
  void display(){
    ellipse(x,y,r,r); 
  }
  
  void move(){
   x+= velx;
   y+= vely;
  }
  
  void colour (){

    fill(random(0,255),random(0,255),random(0,255)); 
  }
  
}
