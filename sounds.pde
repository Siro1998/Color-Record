import processing.serial.*;
import processing.video.*;
import ddf.minim.analysis.*;
import ddf.minim.*;
import com.hamoid.*;
//import codeanticode.syphon.*;

Serial mySerial;
char myVal;

//SyphonServer server;

Minim minim;  
AudioInput in;
AudioRecorder recorder;
AudioPlayer player;
VideoExport videoExport;

Movie myMovie;

float t=0;
ArrayList<Path> paths;

int counter=1;
int currentFunction;
boolean recording = false;
boolean movieStart = false;

int a;
int b;
int c;

void setup() {
  size(1920, 1080, P3D);
  background(0);

  minim = new Minim(this);
  in = minim.getLineIn();

  textFont(createFont("Arial", 30));
  
  paths = new ArrayList<Path>();
  
  String myPort = Serial.list() [8];
  mySerial = new Serial(this, myPort, 9600);
  //server = new SyphonServer(this, "Processing Syphon");
}

void draw() {
  soundViz();
      t+=10;
    delay(50);
    if (t == height) {
      t=0;
    }
  playMovie();
  while (mySerial.available() > 0) {
    myVal = mySerial.readChar();
    if (myVal == 'r') {
      recording = !recording;
    }
    switch(myVal) {
    case 'r': if (recording == true) {recordSoundViz();
            } else {saveRecord();
            }break; 
    case 'b': showRecord(); break;
    case 'w': saveImage(); break;
    }
  }
  //server.sendScreen();
}

void movieEvent(Movie movie) {
  movie.read();
}

void soundViz() {
  if (recording == true) {
    background(color(a,b,c));
    movieStart = false; 
   if(in.left.level()*1000 > 7){
    newPath();
  }
  for(int i=0; i<paths.size();i++){
    Path path = paths.get(i);
    path.move();
    }
    println(paths.size());
    videoExport.saveFrame();
  }
}

void newPath(){
  int s = (int)random(0,2);
  println(s);
  float x = random(0,1);
  boolean d;
  if(x >= 0.5){
    d = true;
  }else{ d = false;
  }
  Path path = new Path(random(0,10), d);
  int p= (int)random(50,255);
  int q= (int)random(50,255);
  int m= (int)random(50,255);
  int y = (int)random(1,6);
  for (int i = 0; i < in.bufferSize()-1; i+=y) {
      float x1 = map( i, 0, in.bufferSize(), 0, width );
      float x2 = map( i+1, 0, in.bufferSize(), 0, width );
      PVector l = new PVector(x1, t+in.left.get(i)*500);
      PVector r = new PVector(x2, t+in.left.get(i+1)*500);
      int c = color(p,q,m);
      float v = in.left.level();
      Element e = new Element(l,r,c,v,s);
      path.addElement(e);
    }
   paths.add(path);
   path.display();

}

void playMovie() {
  if (recording == false && movieStart == true) {
    image(myMovie, 0, 0);
  }
}

void recordSoundViz() {
  for (int i=paths.size()-1;i>=0;i--) {
      Path path = paths.get(i);
      path.clean();
      paths.remove(i);
  }
  a=(int)random(150);
  b=(int)random(150);
  c=(int)random(150);
  background(color(a,b,c));
  t=0;
  recorder = minim.createRecorder(in, "recording/" + "myrecording" + counter + ".wav");
  recorder.beginRecord();
  videoExport = new VideoExport(this, "data/" + "mymovie" + counter + ".mp4");
  videoExport.setQuality(100, 256);
  videoExport.setFrameRate(14);
  //videoExport.setAudioFileName("recording/" + "myrecording" + counter + ".wav");
  videoExport.startMovie();
  if ( recorder.isRecording() ) {
    println("start recording");
  }
}

void saveRecord() {
  recorder.save();
  println("Done saving.");
  videoExport.endMovie();
}

void showRecord() {
  movieStart = true;
  player = minim.loadFile("recording/" + "myrecording" + counter + ".wav");
  player.play();
  myMovie = new Movie(this, "mymovie" + counter + ".mp4");
  myMovie.play();
  println("show my recording");
}

void saveImage() {
  save("image/" + "Image" + counter + ".png");
  println("Save & print image.");
  counter++;
}
