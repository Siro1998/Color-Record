class Path{
  
  ArrayList<Element> elements;
  float speed;
  boolean direction;
  
  Path(float s, boolean d){
    elements = new ArrayList<Element>();
    speed = s;
    direction = d;
  }
  
  void addElement(Element e){
    elements.add(e);
  }
  
  void move(){
    for(int i=0; i<elements.size();i++){
      Element e = elements.get(i);
      if(direction == true){
        e.moveRight(speed);
      }else{
        e.moveLeft(speed);
      }
      e.display();
    }
  }
  
  void display(){
     for(int i=0; i<elements.size();i++){
      Element e = elements.get(i);
      e.display();
    }
  }
  
  void clean(){
     for(int n=0; n<elements.size();n++){
      elements.remove(n);
    }
  }
}
