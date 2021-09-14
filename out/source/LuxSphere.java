/* autogenerated by Processing revision 1276 on 2021-09-14 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import peasy.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class LuxSphere extends PApplet {



PeasyCam cam;

PVector[][] globe;
int times = 0;
int total = 19 + 1;
int medios = 5;
float dLeds = 17;
float r = 150;
float c;

 public void setup() {
  /* size commented out by preprocessor */;
  cam = new PeasyCam(this, 500);
  colorMode(HSB);

  globe = new PVector [total][60];

  for (int i = 1; i < total; i++) {
    float lat = map(i, 0, total, 0, PI);
    int numLeds = ceil ((2* PI * r * sin(lat))/dLeds);
    //println(numLeds);
    //PVector arrayLeds[] = new PVector[numLeds];

    for (int j = 0; j < numLeds +1; j++) {
      float lon = map(j, 0, numLeds, 0, 2* PI);
      float x = r * sin(lat) * cos(lon);
      float y = r * sin(lat) * sin(lon);
      float z = r * cos(lat);
      globe[i][j] = new PVector(x, y, z);
    }
  }
}

 public void draw() {
  background(0);

  lights();

  stroke(c,255,255);
  strokeWeight(5);
  for (int i = 1; i < 19+1; i++) {
    float lat = map(i, 0, total, 0, PI);
    int numLeds = ceil ((2* PI * r * sin(lat))/dLeds);
    beginShape(POINTS);
    for (int j = 0; j < numLeds; j++) {
      PVector v1 = globe[i][j];
      //  if(ceil(lat)%2 == 0){
      //    vertex(v1.x*2, v1.y*2, v1.z*2);
      //  }
      if (times ==1) println(v1);

      vertex(v1.x, v1.y, v1.z);
    }
    endShape();
  }
  times++;
}
 public void mouseClicked(){
c= random(255);
}


  public void settings() { size(1200, 800, P3D); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "LuxSphere" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
