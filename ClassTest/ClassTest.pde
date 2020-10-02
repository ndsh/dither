Dither d;
Dither d2;
PImage p;

void setup() {
  size(800, 800);
  surface.setLocation(0,0);
  colorMode(HSB, 360, 100, 100);
  p = loadImage("medusa.jpg");
  d = new Dither();
  d2 = new Dither("sample.jpg");
  d.setCanvas(400, 400);
  d.feed(p);
  
  // example of how to set the modes differently via d2 object
  d2.setMode("RANDOM");
  d2.setMode(3);
  
}

void draw() {
  background(255);
  
  image(d.floyd_steinberg(), 0, 0);
  image(d.bayer(), 0, 400);
  image(d.atkinson(), 400, 0);
  image(d.rand(), 400, 400);
  
  // get random outputs
  d2.setMode((int)random(4));
  // ask the dither object just for the calculated dither image instead of going to a mode directly
  image(d2.dither(), 200, 200);
}
