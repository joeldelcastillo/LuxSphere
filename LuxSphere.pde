import peasy.*;

PeasyCam cam;

PVector[][] globe;
int times = 0;
int total = 19 + 1;
int medios = 5;
float dLeds = 17;
float r = 150;
float c;
float bolbingMax = 1.1;
float xoff = 0;
float phase = 0;
float speed = 0.003;
float colorMutator = 0.04;

void setup() {
  size(1200, 800, P3D);
  cam = new PeasyCam(this, 500);
  colorMode(HSB);
  globe = new PVector [total][60];

  for (int i = 1; i < total; i++) {
    float lat = map(i, 0, total, 0, PI);
    int numLeds = ceil ((2* PI * r * sin(lat))/dLeds);
    println(numLeds);
    PVector arrayLeds[] = new PVector[numLeds];

    for (int j = 0; j < numLeds +1; j++) {
      float lon = map(j, 0, numLeds, 0, 2* PI);
      float x = r * sin(lat) * cos(lon);
      float y = r * sin(lat) * sin(lon);
      float z = r * cos(lat);
      globe[i][j] = new PVector(x, y, z);
    }
  }
}

void draw() {
  background(0);
  stroke(255);
  lights();
  strokeWeight(5);
  for (int i = 1; i < 19+1; i++) {
    float lat = map(i, 0, total, 0, PI);
    int numLeds = ceil ((2* PI * r * sin(lat))/dLeds);
    beginShape(POINTS);
    for (int j = 0; j < numLeds; j++) {
      float lon = map(j, 0, numLeds, 0, 2* PI);
      PVector v1 = globe[i][j];

      float xoff = map(sin(lat)*cos(lon), -1, 1, 0, bolbingMax);
      float yoff = map(sin(lat) * sin(lon), -1, 1, 0, bolbingMax);
      float zoff = map(cos(lat), -1, 1, 0, bolbingMax);
      float pNoise = noise(xoff+phase, yoff+phase, zoff+phase);
      float r = map(pNoise, 0, 1, 20, 200);

      float x = r * sin(lat) * cos(lon);
      float y = r * sin(lat) * sin(lon);
      float z = r * cos(lat);

      // Color with Perlin noise
      float redShift = map(r, 100, 200, 0, 255);
      float cNoise = noise(phase + colorMutator * v1.x, phase + colorMutator * v1.y, phase +colorMutator * v1.z);
      // float hu = map(cNoise, 0, 1, 0, 45 - redShift);
      // float hu = map(cNoise, 0.8, 1, 0, 255);
      // stroke(random(255), random(255), random(255));
      // stroke(redShift,255, 255);
      
      float hu = map(r, 0, 1.1, 0, PI/2);
      stroke(hu,255, 255);

      globe[i][j] = new PVector(x, y, z);




      //  if(ceil(lat)%2 == 0){
      //    vertex(v1.x*2, v1.y*2, v1.z*2);
      //  }
      // if (times ==1) println(v1);

      vertex(v1.x, v1.y, v1.z);
    }
    endShape();
  }
  times++;
  phase += speed;
}


void mouseClicked(){
c= random(255);
}