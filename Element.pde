class Element{
  PVector positionL;
  PVector positionR;
  int colour;
  float level;
  int shape;
  
  Element(PVector l, PVector r, int c, float v, int s){
    positionL = l;
    positionR = r;
    colour = c;
    level =v;
    shape =s;
  }
  
  void display(){
    if(shape == 0){
      stroke(colour,level*1000);
      strokeWeight(2);
      noFill();
      circle(positionL.x,positionL.y,level*500);
    }else{
      stroke(colour);
      strokeWeight(2);
      //line(positionL.x,positionL.y,positionR.x,positionR.y);
      line(positionL.x,positionL.y,positionL.x,positionL.y+level*1000);
    }
    
  }
  
  void moveRight(float s){
    positionL.add(s,0);
    //positionR.add(s,0);
    //if(positionL.x >= width && positionR.x >= width){
    if(positionL.x >= width){
      positionL.x = 0;
      //positionR.x = 0;
    }
  }
  
   void moveLeft(float s){
    positionL.add(-s,0);
    //positionR.add(-s,0);
    //if(positionL.x <= 0 && positionR.x <= 0){
    if(positionL.x <= 0){
      positionL.x = width;
      //positionR.x = width;
    }
  }
}
