
import peasy.*;

PeasyCam cam;

PVector[][] globe;
int total = 20;

void setup() {
  size(1200, 800, P3D);
  cam = new PeasyCam(this, 500);
  colorMode(HSB);
  globe = new PVector[total+1][total+1];
}

void draw() {
  background(0);
  fill(255);
  lights();
  float r = 200;
  
  for (int i = 1; i < total; i++) {
    float lat = map(i, 0, total, 0, PI);
    for (int j = 0; j < total+1; j++) {
      float lon = map(j, 0, total, 0, PI);
      float x = r * sin(lat) * cos(lon);
      float y = r * sin(lat) * sin(lon);
      float z = r * cos(lat);

      globe[i][j] = new PVector(x, y, z);
      
    }
  }

  stroke(255);
  strokeWeight(5);
  for (int i = 1; i < total; i++) {

    beginShape(POINTS);
    for (int j = 0; j < total+1; j++) {
      PVector v1 = globe[i][j];
      // if(j%2 ==0){
      //   vertex(v1.x*2, v1.y*2, v1.z*2);
      // }
      
      vertex(v1.x, v1.y, v1.z);

    }
    endShape();
  }
}
